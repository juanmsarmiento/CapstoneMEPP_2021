## Caracterización de palmicultores en minucipios seleccionados del Departamento del Cesar

Juan Manuel Sarmiento Medina <br>
28-05-2021

![Capstone.png](https://github.com/juanmsarmiento/CapstoneMEPP_2021/blob/main/images/Capstone.png)

## Descripción y Motivación


En este proyecto, se analiza y georreferencia la oferta y demanda de sedes de iniciativas para jóvenes de
entre 14 y 28 años en Bogotá D.C. Este análisis permite obtener, de forma detallada, información respecto
a qué Unidades de Planeación Zonal (UPZ) y Localidades de la ciudad de Bogotá sufren de mayores
necesidades respecto a la oferta iniciativas para jóvenes. Así mismo, permite cruzar la información con la
cantidad de jóvenes que necesitan estas iniciativas. Las pregunta principal a responder es ¿Cuál es la correlación entre la oferta de servicios públicos y privados a jóvenes y la problemática de los jóvenes que no estudian ni trabajan o están en la informalidad en Bogotá?

Las subpreguntas que guian el estudio son: 

- ¿Dónde se evidencia una mayor o menor concentración de servicios o programas sociales para jóvenes en Bogotá?

- ¿Las zonas con mayor problemática de jóvenes que no estudian ni trabajan tienen una baja cobertura de servicios y programas sociales para los jóvenes?

- ¿Cuáles son las zonas de atención prioritaria para focalizar servicios o programas sociales para jóvenes?

Para responder estas preguntas, primero se levanta la información de las sedes de iniciativas para jóvenes en toda Bogotá D.C., la cual es clasificada según las categorías de análisis propuestas en el Modelo de Empleo Inclusivo para Población Vulnerable. Así mismo, es georreferenciada a través de un código desarrollado en Python, apoyandose librerías de JSON y el API de Google Maps, con el propósito de determinar a qué UPZ y localidad pertenece cada sede. En segundo lugar, se sistematizan los datos provenientes de la Encuesta Multipropósito 2017, para encontrar la cantidad y distribución de los jóvenes que necesitan de estas iniciativas en cada UPZ y localidad en Bogotá D.C. Con esta información, se pasa a realizar estadísticas descriptivas y correlaciones en STATA, con el objetivo de describir de forma más precisa el comportamiento de la oferta y la demanda. Por último, con la información recolecta, se crea una visualización en Power BI que permite observar de forma fácil e interactiva los territorios a priorizar a través de mapas y estadísticas.

## Objetivo General

Determinar si hay evidencia de que las UPZ con mayor número de jóvenes que ni estudian ni trabajan están relacionadas con zonas donde es menor la oferta de servicios y programas para jóvenes en ámbitos educativos, de intermediación laboral, culturales, recreativos, entre otros.

### Objetivos específicos

1. Mapear y georreferenciar la oferta de servicios y programas públicos y privados para jóvenes en Bogotá 
2. Correlacionar la oferta y demanda de programas y servicios a jóvenes en Bogotá a nivel de localidades y UPZ
3. Identificar zonas de atención prioritaria donde la demanda de servicios sociales para jóvenes sea alta y la oferta escasa.



## Hallazgos 

- Se encontraron y clasificaron 4659 servicios para jóvenes Bogotá

- Las localidades con mayor concentración de iniciativas son Suba, Engativá, Kennedy y Ciudad Bolívar, pero en el análisis por cantidad de jóvenes estas localidades ocupan los últimos lugares, siendo reemplazadas por La Candelaria, Antionio Nariño, Los Mártires y Barrios Unidos. Esto indica que las localidades al sur de la ciudad, a pesar de concentrar una amplia oferta, tienen, proporciuonalmente, menos oferta que otras localidades en el norte y centro.

- Se encuentra que la oferta de servicios y programas para jóvenes en proporción a la cantidad de jóvenes es menor en las localidades de Bosa, Ciudad Bolívar, Usaquén, Kennedy, Fontibón y Suba, las cuáles además son algunas de las localidades con mayor número de jóvenes en el Distrito.

- Se encuentra una desconexión en las localidades respecto al tramo 1 y tramo 2. Es decir, varias de las localidades con mayor oferta en educación media son, a la vez, las localidades con menor oferta en educación para el trabajo, el cuál es el siguiente paso en el Modelo de Empleo Inclusivo.

- Se evidencia que al realizar la comparación entre localidades y jóvenes con potencial existe una gran correlación de Spearman superior a 0.8 positiva; sin embargo, al ajustar las correlaciones a ser per cápita y/o por tramos se evidencia que la correlación disminuye. Esto da lugar a nuevas investigaciones que profundicen en estas correlaciones, analizando el progreso de las iniciativas existentes relacionadas en el tablero Power BI, al comparar los jóvenes con potencial existentes para los resultados de encuestas más recientes. 

- Las correlaciones positivas en tramo 1 y 3 respecto a la cantidad de jóvenes desconectados de la educación media y del mercado laboral, respectivamente, pueden responder a la relación con la demanda potencial. Es decir, aquellos territorios en los que se observan mayor cantidad de jóvenes desconectados en esos tramos reciben posteriormente las sedes de los servicios y programas respectivos.

- Las correlaciones positivas en tramo 1 y 3 respecto a la cantidad de jóvenes desconectados de la educación media y del mercado laboral, respectivamente, pueden responder a la relación con la demanda potencial. Es decir, aquellos territorios en los que se observan mayor cantidad de jóvenes desconectados en esos tramos reciben posteriormente las sedes de los servicios y programas respectivos.

## Territorios a priorizar

- La oferta de servicios y programas para jóvenes en proporción a la cantidad de jóvenes es menor en las localidades de Bosa, Ciudad Bolívar, Usaquén, Kennedy, Fontibón y Suba.

- Desconexión entre tramo 1 y tramo 2 en Ciudad Bolívar, Usme y Rafael Uribe Uribe.

- Alto número de jóvenes desconectados de la educación media y poca oferta en el tramo 1, como en las UPZ de La Flora (Usme), Jerusalén(Ciudad Bolívar), Corabastos (Kennedy) y Patio Bonito (Kennedy).

- Modelia (Fontibón), Restrepo (Antonio Nariño), San Rafael (Puente Aranda), Teusaquillo (Teusaquillo), Bolivia (Engativá) y Timiza (Kennedy) contienen una alta cantidad de jóvenes desconectados del mercado laboral y a la vez pocas sedes de iniciativas de intermediación.

- Posible desconexión entre la demanda del tramo 2 y la oferta de servicios y programas. Esta desconexión es especialmente dramática en las localidades de Usme, Ciudad Bolívar, San Cristóbal y Bosa

A continuación, se muestran solo algunas de las gráficas, para consultarlas todas, igresar [Aquí](./images)


![edad_palmicultores.png](https://github.com/juanmsarmiento/MCPP_juan.sarmiento/blob/master/Proyecto%20final/images/edad_palmicultores.png)

![sexo_palmicultores.png](https://github.com/juanmsarmiento/MCPP_juan.sarmiento/blob/master/Proyecto%20final/images/sexo_palmicultores.png)

![hijos_palmicultores.png](https://github.com/juanmsarmiento/MCPP_juan.sarmiento/blob/master/Proyecto%20final/images/hijos_palmicultores.png)

![vivprop_palmicultores.png](https://github.com/juanmsarmiento/MCPP_juan.sarmiento/blob/master/Proyecto%20final/images/vivprop_palmicultores.png)

![regsalud_palmicultores.png](https://github.com/juanmsarmiento/MCPP_juan.sarmiento/blob/master/Proyecto%20final/images/regsalud_palmicultores.png)

![disper_palmicultores.png](https://github.com/juanmsarmiento/MCPP_juan.sarmiento/blob/master/Proyecto%20final/images/disper_palmicultores.png)

![victimas_palmicultores.png](https://github.com/juanmsarmiento/MCPP_juan.sarmiento/blob/master/Proyecto%20final/images/victimas_palmicultores.png)

![wordcloud_dificultades.png](https://github.com/juanmsarmiento/MCPP_juan.sarmiento/blob/master/Proyecto%20final/images/wordcloud_dificultades.png)

-------
