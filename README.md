## Caracterización de palmicultores en minucipios seleccionados del Departamento del Cesar

Juan Manuel Sarmiento Medina <br>
28-05-2021

![Capstone.png](https://github.com/juanmsarmiento/CapstoneMEPP_2021/blob/main/images/Capstone.png)

## Descripción y Motivación

El desarrollo rural es uno de los principales objetivos de la política de Estado en Colombia. Diferentes organizaciones públicas y privadas han impulsado programas y políticas que tienen como objetivo mejorar la calidad de vida de la población rural en el país. En este contexto, Palmas del Cesar S.A., una empresa dedicada a la extración de aceite del cultivo de palma africana, ha dedicado recursos y esfuerzos para conocer a los proveedores de palma, los cuales son campesinos dedicados al cultivo de la misma. En el 2020, Palmas del Cesar S.A. adelantó una serie de entrevistas a palmicultores de los municipios de San Martín, Río de Oro y San Alberto, con el objetivo de conocer las características sociales, productivas y demográfica de los palmicultores de la región. 

Este proyecto tabula, limpia y analiza las 144 encuestas con 293 variables realizadas a los palmicultores, con el objetivo de producir estadísticas y gráficas descriptivas que sirvan para entender las características de los campesinos. En este orden de ideas, se plantea la pregunta ¿Cuáles son las características demográficas y productivas de los palmicultores proveedores de Palmas del Cesar S.A.?

Las subpreguntas que guian el estudio son: 

- ¿Cómo se distribuye la edad de los palmicultores?

- ¿Cómo se distribuyen los palmicultores en términos de sexo?

- ¿Cómo se componen las familias de los palmicultores?

- ¿Cuáles son las características de las viviendas de los palmicultores?

- ¿Cómo se distribuyen los palmicultores en términos de regímenes de salud?

- ¿Cuál es la relación entre la la cantidad de hijos y el nivel educativo? 

- ¿De qué forma se han visto afectados los palmicultores por el conflicto armado?

- ¿Cuáles son las principales preocupaciones de los palmicultores respecto al cultivo?

Estas preguntas serán respondidas a través del análisis de los datos de las encuestas, apoyandose en distintos métodos de programación que permitirán extraer la información necesaria. Cabe resaltar que la encuesta recolecta muchos más datos que los que se necesitarán para responder estas preguntas. Sin embargo, dado que la motivación planteada es exploratoria: concoer las principales características de los palmicultores, no se considera necesario ser exhaustivo en cada una de las variables.

## Objetivo General

El objetivo de este proyecto es tabular, limpiar, consolidar y analizar la información de las encuestas realizas por Palmas del Cesar S.A. a 144 palmicultores en los municipios de San Martín, San Alberto y Río de Oro.

### Objetivos específicos

1. Agrupar todas las entrevistas en un solo documento scrapeable 
2. Tabular cada una de las respuestas de cada entrevista en distintas variables
3. Limpiar las variables resultantes de posibles errores de tabulación
4. Consolidar todas las variables en una base de datos
5. Analizar las variables necesarias para responder las preguntas planteadas


## Métodos:
1. Agrupar las entrevistas en un solo documento
  - Las entrevistas se contenían en el archivo [Encuestas.xsls](./Encuestas.xlsx), en el cuál cada entrevista estaba en una hoja del documento
  - Para hacer esto, utilizé métodos Pandas para leer archivos .xsls y guardarlos en .csv, así como para unirlos todos en un solo archivo, a través de un loop. 
  - Los métodos utilizados puede visulizarse [Aquí](./scraper_consolidate_surveys.ipynb)
2. Tabular cada una de las respuestas de cada entrevista en distintas variables
  - Para tabular las respuestas de cada entrevista, se utilizó la libería Regex. Con esta, se crearon funciones para cada pregunta en las que estaban los paths correspondients y las cuales retornan listas con las respuestas para cada pregunta en orden.
  - Estas funciones se crearon en un archivo aparte, para facilitar la lectura del código, [Aquí](./scraper_helper.py)
 3. Limpiar las variables resultantes de posibles errores de tabulación
  - Para limpiar los datos, se utlizaron estructuras de control con loops con funciones de string y unicode. [Aquí](./scraper_consolidate_surveys.ipynb)
  4. Consolidar todas las variables en una base de datos
    - La base de datos se consolidó con la librería Pandas. Además también se utilizó su función de merge para unirla con otros datos que no estaban en las encuestas.
    - También se utilizó esta librería para exportar la base de datos a 'pickle'
    - El código está dispobible [Aquí](./scraper_consolidate_surveys.ipynb)
  5. Analizar las variables necesarias para responder las preguntas planteadas
    - Las variables se analizaron principalmente a través de gráficos creados con las librerías Matplotlist y Seaborne. A través de estas se hicieron gráficos de barra, gráficos cirulares y gráficos de dispersión que permitieron ilustrar los datos necesarios.
    - El código está disponible [Aquí](./analysis_surveys.ipynb)    
    
Otros programas:
 *Además de los métodos mencionados, también se utilizaron programas con Tableau o wordclouds.com, que permitieron generar gráficos sobre los datos necesarios. El gráfico de Tableau se puede encontrar aquí:
https://public.tableau.com/views/Tabla1_16222575049310/Hoja2?:language=es-ES&:display_count=n&:origin=viz_share_link
    



## Hallazgos 

- Se encontró que la mayoría de palmicultores tiene por encima de 40 años y existen muy pocos jóvenes. Esto podría sugerir que no se está dando un relevo generacional y las nuevas generaciones no están interesadas en el campo

- Se encuentra que en su mayoría, los proveedores de Palmas del Cesar S.A. son hombres. 

- Se encuetra que los palmicultores tiene generalmente entre 2 y 4 hijos, mientras que su núcleo familiar tiende a tener 4 personas.

- La mayoría de los palmicultores tiene vivienda propia. Sin embargo, se encuentra que más de 20 de los encuestados aún no tienen todos los servicios públicos domiciliarios

- Los palmicultores tienen en su mayoría un régimen contirbutivo de salud

- Se encuentra que parece existir una correlación negativa entre número de hijos y nivel educativo. A medida que se avanza en los grados de escolaridad, los palmicultores tienden a tener menos hijos.

- Se encuentra que la mayoría de los palmicultores han sido víctimas del conflicto armado. En su mayoría, han sufrido de extorsiones, robos y desplazamiento forzado

- Los palmicultores se preocupan principalmente por temas de sanidad, transporte y costos de su cultivo. Estas preocupaciones se mantienen a pesar de que los palmicultores tengan otras fuentes de ingreso.

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
