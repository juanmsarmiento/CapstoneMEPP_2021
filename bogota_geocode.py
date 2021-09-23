#!/usr/bin/env python
# coding: utf-8

# In[2]:


###########################################################################################
    #Proyecto:      Capstone Urosario
    #Title:         Georreferenciación y obtención de localidades y UPZ en Bogotá
    #Autores:       Juan Felipe Gómez y Juan Manuel Sarmiento
    #Fecha:         20 de agosto de 2021
    #Última modificación: 23 de septiembre de 2021
    #Version:        Python 3.8.3
    #Resumen:        Este código genera coordenadas, localidad y upz a partir de ubicaciones geográficas en bases de datos
  			
###########################################################################################

from office365.sharepoint.files.file import File
from office365.runtime.auth.user_credential import UserCredential
from office365.sharepoint.client_context import ClientContext
import googlemaps
import io
import pandas as pd
import json
from shapely.geometry import shape, Point
from collections import defaultdict, deque

# Se importa directamente de One Drive la base de datos actualizada
site_url = ''
relative_url = ''
ctx = ClientContext(site_url).with_credentials(UserCredential('juanm.sarmiento@urosario.edu.co', password=''))
response = File.open_binary(ctx, relative_url)
#Se gurada en BytesIO stream
bytes_file_obj = io.BytesIO()
bytes_file_obj.write(response.content)
bytes_file_obj.seek(0) 
#Se lee el objeto en formato dataframe. En caso de querer importar la base directamente desde los archivos locales, en la siguiente línea debe reemplazarse bytes_file_obj por el nombre del archivo de la sigueinte forma 'nombre.xlsx' 
df = pd.read_excel(bytes_file_obj)


# In[3]:


df


# In[4]:


# Si no hay modificaciones ni nuevas obsrvaciones, puede utilizarce la última lista de datos geográficos obtenidos de la API con las siguientes líneas:
# Esto evita desperdiciar los request gratis al mes que permite la API de Google Maps
with open("coordenadas.txt", "r") as fp:
    coordenadas = json.load(fp)


# In[3]:


# Utilización de la API de Google Maps para obtener los datos geográfico de cada una de las observaciones
# Hay que tener en cuenta que la API de Google Maps permité una cantidad de requests al mes antes de cobrar por cada request. Si solo se tiene una clave, el uso gratis del código se limita a alrededor de 40.000 requests por mes.
gmaps = googlemaps.Client(key='') #Aquí debe ingresarse la clave individual de la API en formato string
coordenadas = []
for ubicación in list(df.loc[:,"UBICACIÓN"]): #se parte de la columna de UBICACIÓN
    geocode_result = gmaps.geocode(ubicación, components={"administrative_area": "Bogotá", "country": "'Colombia'"})
    coordenadas.append(geocode_result)
len(coordenadas) #Conformación de que la longitud de datos geográficos es igual al número de observaciones


# In[33]:


# Para evitar utilizar la API siempre que se corra el código y malgastar requests gratis, se exporta la lista a un archivo externo
with open("coordenadas.txt", "w") as fp:
    json.dump(coordenadas, fp)


# In[5]:


# Para algunas observaciones no es posible obtener datos geográficos, debido a que la variable de unicación está vacía o contiene ubicaciones no comprensibles para Google Maps. Se buscan y visualizan las observaciones de este tipo.
list_emptycoor = []
for i in range(len(coordenadas)):
    if coordenadas[i] == []:
        list_emptycoor.append(int(i))
df.iloc[list_emptycoor]


# In[13]:


# Para facilitar el código, a las observaciones sin datos geográficos se les asiga los datos del PROGRAMA NACIONAL ESCUELAS TALLER DE COLOMBIA. Luego, estas observaciones deben corregirse y buscarse manualmente.
for i in range(len(coordenadas)):
    if coordenadas[i] == []:
        coordenadas[i] = coordenadas[22]


# In[14]:


# De los datos geográficos, se sacan los datos de interés: latitudes y longitudes, para conformar las coordenadas
latitudes = []
longitudes = []
for element in coordenadas: # se hace un for loop que bsuca en la estructura de los datos geográficos la información de latitudes y longitudes, luego se agregan a sus respectivas listas en el mismo orden de la base de datos
    latitudes.append(element[0]['geometry']['location']['lat'])
    longitudes.append(element[0]['geometry']['location']['lng'])


# In[15]:


# Se genera lista de tuplas con las coordenadas de cada observación
coordinatelist = [list(pair) for pair in zip(longitudes, latitudes)]
# Se genera lista de puntos en el formato necesario (point de la librería Shapely) para comprobar si está dentro de determinado polígono
pointlist = []
for coordinate in coordinatelist:
        point = Point(coordinate)
        pointlist.append(point)
# Se comprueba dentro de qué polígono de localidades está cada uno de los puntos
aux_localidades = []   # Se hace una lista de lo datos geográficos de los polígonos de las localidades a las que pertenece cada punto, en orden     
aux_foundpoints = []   # se hace una lista de los puntos que pudieron ser encontrados dentro de los polígonos de localidades
with open('poligonos-localidades.geojson') as f: # Se importa el archivo .geojson con los polígonos de las localidades
    js = json.load(f)
for point in pointlist: # Se hace la comprobación de a qué polígono pertenece cada punto
    for feature in js['features']: 
        polygon = shape(feature['geometry'])
        if point.within(polygon) or point.intersects(polygon): 
            aux_localidades.append(feature)
            aux_foundpoints.append(point)


# In[16]:


# Se hace una lista de los puntos que NO fueron econtrados en los polígonos de localidades
point_dictionary = dict(zip(list(range(len(df.loc[:,"UBICACIÓN"]))), pointlist))
aux_notfoundpoints = []
for key, value in point_dictionary.items():
    if value not in aux_foundpoints:
        aux_notfoundpoints.append(key)


# In[17]:


# Se extrae de la lista de datos geográficos de las localidades de cada punto la información relevante: nombre y número de localidad
localidades_name = []
localidades_num = []
for element in aux_localidades:
    localidades_name.append(element['properties']['Nombre de la localidad'])
    localidades_num.append(element['properties']['Identificador unico de la localidad'])


# In[18]:


# Se compreba dentro de qué polígono de UPZ está cada uno de los puntos
aux_upz = [] # Se hace una lista de lo datos geográficos de los polígonos de las UPZ a las que pertenece cada punto, en orden     
aux_foundupz = [] # se hace una lista de los puntos que pudieron ser encontrados dentro de los polígonos de UPZ
with open('unidad-de-planeamiento13.geojson') as f: # Se importa el archivo .geojson con los polígonos de las UPZ
    js = json.load(f)
for point in pointlist: # Se hace la comprobación de a qué polígono pertenece cada punto
    for feature in js['features']: 
        polygon = shape(feature['geometry'])
        if point.within(polygon) or point.intersects(polygon): 
            aux_upz.append(feature)
            aux_foundupz.append(point)


# In[19]:


# Se hace una lista de los puntos que NO fueron econtrados en los polígonos de UPZ
aux_notfoundupz = []
for key, value in point_dictionary.items():
    if value not in aux_foundupz:
        aux_notfoundupz.append(key)


# In[20]:


# Se extrae de la lista de datos geográficos de las UPZ de cada punto la información relevante: nombre y número de UPZ
upz_name = []
upz_num = []
for element in aux_upz:
    upz_name.append(element['properties']['uplnombre'])
    upz_num.append(element['properties']['uplcodigo'])


# In[21]:


# Se genera lista con el número de cada observación 
keys = (list(range(len(df.loc[:,"UBICACIÓN"]))))


# In[22]:


# Se genera lista de longitud igual a la de puntos no encontrados con el strinh "not found" en cada posición
notfountlist = ['not found'] * len(aux_notfoundpoints)


# In[24]:


# Se genera una lista de tuplas en la que se combina el número de cada observación con su point, el número de cada observación no encontrada con el string "not found" y el número de cada observación encontrada con el número de su localidad 
dict_list = list(zip(keys, pointlist)) + list(zip(aux_notfoundpoints, notfountlist)) + list(zip([elem for elem in keys if elem not in aux_notfoundpoints ], localidades_name)) +list(zip([elem for elem in keys if elem not in aux_notfoundpoints ], localidades_num))


# In[26]:


# se crea un diccionario a aprtir de la lista de tuplas anterior en el que el número de observación es la key y el value es una lista con el point, el nombre de la localidad y el número de la localidad en caso de encontrarse. Para el caso de los puntos no encontrados, se les asigna el point y "not found"
result = {}
for i in dict_list:  
   result.setdefault(i[0],[]).append(i[1])


# In[27]:


# Se crea un dataframe con el diccionario anterior
localidades_df = pd.DataFrame.from_dict(result,orient='index', columns = ['Coordenadas', 'Localidad', 'Número de Localidad'])


# In[28]:


# Se genera una lista de tuplas en la que se combina el número de cada observación con su point, el número de cada observación no encontrada con el string "not found" y el número de cada observación encontrada con el número de su UPZ 
notfountlistupz = ['not found'] * len(aux_notfoundupz)
dict_listupz = list(zip(keys, pointlist)) + list(zip(aux_notfoundupz, notfountlistupz)) + list(zip([elem for elem in keys if elem not in aux_notfoundupz ], upz_name)) + list(zip([elem for elem in keys if elem not in aux_notfoundupz ], upz_num))


# In[29]:


# se crea un diccionario a aprtir de la lista de tuplas anterior en el que el número de observación es la key y el value es una lista con el point, el nombre de la UPZ y el número de la UPZ en caso de encontrarse. Para el caso de los puntos no encontrados, se les asigna el point y "not found"
resultupz = {}
for i in dict_listupz:  
   resultupz.setdefault(i[0],[]).append(i[1])


# In[30]:


# Se crea un dataframe con el diccionario anterior
upz_df = pd.DataFrame.from_dict(resultupz,orient='index', columns = ['Coordenadas', 'UPZ',
                                                                     'Número de UPZ'])


# In[36]:


# Se crea el data frame final en el que se agrega el nombre de la iniciativa, las coordenadas, localidad, número de localidad, UPZ y número de UPZ
coor_colum = list(zip(latitudes, longitudes))
coor_series = pd.Series(coor_colum)
coor_df = pd.merge(localidades_df, upz_df, how='outer', left_index=True, right_index=True)
del coor_df['Coordenadas_y']
coor_df = coor_df.rename(columns={'Coordenadas_x': 'Coordenadas'})
aux_df = pd.merge(df, coor_df, how='outer', left_index=True, right_index=True)
aux_df = aux_df.rename(columns={'Localidad_y': 'Localidad', 'UPZ_y':'UPZ' })
final_df = aux_df[['NOMBRE DE INICIATIVA', 'Coordenadas', 'Localidad','Número de Localidad', 'UPZ', 'Número de UPZ']]
final_df['COORDEADAS (Latitud, longitud)'] = coor_series
final_df.index += 1
final_df.to_excel("Localidades y UPZ1.xlsx") 

