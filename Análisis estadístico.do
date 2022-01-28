/*******************************************************************************
  Project:        Capstone GOYN

  Title:          ANÁLISIS GEORREFERENCIADO DE LA OFERTA Y DEMANDA DE PROGRAMAS Y SERVICIOS PARA LA JUVENTUD EN BOGOTÁ
  Autores:         Juan Sarmiento, Juan Felipe Gómez, María Angélica Huertas y Hernando Valentin Padilla
  Fecha:           Septiembre 23 2021
  Última modificación :  Octubre 28 2021
  Versión:        Stata 17
  Resumen:         Este do file trabaja las bases de datos de oferta de iniciativas para jóvenes, Censo poblacional de 2018 y la encuesta multipropósito 2017 para correlacionar la oferta y la demanda de servicios para jóvenes en Bogotá a nivel de UPZ y localidades 
  			
*******************************************************************************/


di "current user: `c(username)'"
	
if "`c(username)'" == "HP"{
	global path "C:\Users\HP\Desktop\Universidad\Maestría\Capstone\STATA"

}

*En caso de utilizar este código en otro PC, es necesario modificar las direcciones con un else if, tal y como se muestra a continuación. La dirección debe ser aquella en la que se encuentran las bases de datos a utilizar y donde se quieren guardar los datos.
*else if "`c(username)'" == "MAGG"{
*	global path "C:\Users\HP\Documents\STATA"	
*}
*Así mismo, se crea otro global para guardar los gráficos en una carpeta llamada gráficos al interior del path principal. En caso de querer modificar el sitio de guardado, solo debe podificarse el siguiente global.
	global graphs "$path/Gráficos"
	
* Se instalan paquetes necesarios para la ejecución del código
ssc install chartab 
ssc install multencode

******************************************************************************
**************** Mapeo de oferta de iniciativas para jóvenes en Bogotá - 2021 *********************

import excel "$path\Oferta Jovenes GOYN.xlsx", sheet("Base Georeferenciación") firstrow clear

*Se establece un formato general para todos los gráficos
set scheme white_w3d

*Se modifica el nombra de la variable de número de UPZ para que sea igual al nombre de otras bases
rename NÚMERODEUPZ COD_UPZ




*Gráficos total oferta por localidad y upz
graph hbar (count) if  LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA", over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0)  blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas por localidad", replace) nodraw

graph hbar if LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA",  blabel(total, format(%9.2f)) over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0) blabel(total, format(%9.2f)) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas por localidad", replace) nodraw

graph hbar (count)if  UPZ != "", over(UPZ, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0)  blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas por upz", replace) nodraw

*Gráficos de tramos 1, 2, 3 y 4 por localidad y upz
graph hbar (count) if Tramo1 == "Tramo 1" &  LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA", over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0)  blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas tramo 1 por localidad", replace) nodraw

graph hbar (count) if Tramo2 == "Tramo 2" & LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA", over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0)  blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas tramo 2 por localidad", replace) nodraw

graph hbar (count) if Tramo3 == "Tramo 3" &  LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA", over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0)  blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas tramo 3 por localidad", replace) nodraw

*Por el momento, no hay observaciones para tramo 4 que estén georreferenciadas a nivel de localidad, se deja el comando como comentario

*graph hbar (count) if Tramo4 == "Tramo 4" &  LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA", over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0)  blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas tramo 4 por localidad", replace) nodraw

graph hbar  if Tramo1 == "Tramo 1" &  LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA",  blabel(total, format(%9.2f))  over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0) blabel(total, format(%9.2f)) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas tramo 1 por localidad", replace) nodraw

graph hbar if Tramo2 == "Tramo 2" & LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA",  blabel(total, format(%9.2f))  over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0) blabel(total, format(%9.2f)) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas tramo 2 por localidad", replace) nodraw

graph hbar if Tramo3 == "Tramo 3" &  LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA",  blabel(total, format(%9.2f)) over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0) blabel(total, format(%9.2f)) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas tramo 3 por localidad", replace) nodraw

*Por el momento, no hay observaciones para tramo 4 que estén georreferenciadas a nivel de UPZ, se deja el comando como comentario

*graph hbar if Tramo4 == "Tramo 4" &  LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA", over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0) blabel(total, format(%9.2f)) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas tramo 4 por localidad", replace) nodraw

*Se genera una variable que registre todas laa oferta que está en una Unidade de Planeamiento Rural UPR
gen COD_UPR = COD_UPZ if strpos(COD_UPZ, "UPR")
*Se dejan como missing values todas las observaciones que estén en UPR
replace COD_UPZ = "" if strpos(COD_UPZ, "UPR")
*Se le quita a todas las observaciones el str "UPZ", para que queden solo los numeros de la UPZ sin letras
replace COD_UPZ = subinstr(COD_UPZ,"UPZ", "", .)
*Se convierte en formato int la variable COD_UPZ para facilitar su manipulación
destring, replace
*En la Encuesta Multipropósito 2017, varias Unidades de Planeacion Zonal UPZ son agrupadas con códigos desde el 801 hasta el 817. A continuación, se hacen las respectivas agrupaciones para permitir unir esta base de datos con la Encuesta Multipropósito 2017 sin perder datos
replace UPZ = "Marco Fidel Suarez y San José" if COD_UPZ == 53 | COD_UPZ == 36
replace UPZ = "Castilla y Bavaria" if COD_UPZ == 46 | COD_UPZ == 113
replace UPZ = "Country Club, Usaquén y Santa Bárbara" if COD_UPZ == 15 | COD_UPZ == 14 | COD_UPZ == 16
replace UPZ = "Verbenal, Paseo Los Libertadores y La Uribe" if COD_UPZ == 9 | COD_UPZ == 1 | COD_UPZ == 10 
replace UPZ = "La Floresta y La Alhambra" if COD_UPZ == 25 | COD_UPZ == 20
replace UPZ = "La Academia, Guaymaral y San José de Bavaria" if COD_UPZ == 2 | COD_UPZ == 3 | COD_UPZ == 17 
replace UPZ = "Parque Salitre y Doce de Octubre" if COD_UPZ == 103 | COD_UPZ == 22 
replace UPZ = "Parque Simón Bolivar – CAN y La Esmeralda" if COD_UPZ == 104 | COD_UPZ == 106
replace UPZ = "Zona Industrial y Puente Aranda" if COD_UPZ == 108 | COD_UPZ == 111
replace UPZ = "Santa Cecilia, Alamos y Jardín Botánico" if COD_UPZ == 31 | COD_UPZ == 116 | COD_UPZ == 105 
replace UPZ = "Alfonso Lopez y Ciudad Usme" if COD_UPZ == 59 | COD_UPZ == 61 
replace UPZ = "Parque Entrenubes y Danubio" if COD_UPZ == 60 | COD_UPZ == 56
replace UPZ = "Aeropuerto El Dorado y Capellanía" if COD_UPZ == 117 | COD_UPZ == 115 
replace UPZ = "Nieves y Sagrado Corazón" if COD_UPZ == 93 | COD_UPZ == 91
replace UPZ = "Monteblanco, Tesoro y Mochuelo" if COD_UPZ == 64 | COD_UPZ == 68 | COD_UPZ == 63 
replace UPZ = "Pardo Rubio y Chapinero" if COD_UPZ == 90 | COD_UPZ == 99
replace UPZ = "Chico Lago y Refugio" if COD_UPZ == 97 | COD_UPZ == 88
replace COD_UPZ = 801 if COD_UPZ == 53 | COD_UPZ == 36
replace COD_UPZ = 802 if COD_UPZ == 46 | COD_UPZ == 113
replace COD_UPZ = 803 if COD_UPZ == 15 | COD_UPZ == 14 | COD_UPZ == 16
replace COD_UPZ = 804 if COD_UPZ == 9 | COD_UPZ == 1 | COD_UPZ == 10 
replace COD_UPZ = 805 if COD_UPZ == 25 | COD_UPZ == 20
replace COD_UPZ = 806 if COD_UPZ == 2 | COD_UPZ == 3 | COD_UPZ == 17 
replace COD_UPZ = 807 if COD_UPZ == 103 | COD_UPZ == 22 
replace COD_UPZ = 808 if COD_UPZ == 104 | COD_UPZ == 106 
replace COD_UPZ = 809 if COD_UPZ == 108 | COD_UPZ == 111 
replace COD_UPZ = 810 if COD_UPZ == 31 | COD_UPZ == 116 | COD_UPZ == 105 
replace COD_UPZ = 811 if COD_UPZ == 59 | COD_UPZ == 61 
replace COD_UPZ = 812 if COD_UPZ == 60 | COD_UPZ == 56 
replace COD_UPZ = 813 if COD_UPZ == 117 | COD_UPZ == 115 
replace COD_UPZ = 814 if COD_UPZ == 93 | COD_UPZ == 91 
replace COD_UPZ = 815 if COD_UPZ == 64 | COD_UPZ == 68 | COD_UPZ == 63 
replace COD_UPZ = 816 if COD_UPZ == 90 | COD_UPZ == 99
replace COD_UPZ = 817 if COD_UPZ == 97 | COD_UPZ == 88


*La variables de interés están en formato str y son categóricas. Por lo tanto, se hace la tabulación para obetener las mismas variables en formato int y poderlas manipular
multencode TIPODEOPORTUNIDADOPORTUNIDAD M TIPODEOPORTUNIDADOTRASOPORT CLASIFICACIÓNDEACCESOOPORTUN P Tramo1 Tramo2 Tramo3 Tramo4 Componente1 Componente2 Componente3 Componente4 Nivel1 Nivel2 Nivel3 Nivel4, generate(TIPODEOPORTUNIDADOPORTUNIDAD2 M2 TIPODEOPORTUNIDADOTRASOPORT2 CLASIFICACIÓNDEACCESOOPORTUN2 P2 Tramo12 Tramo22 Tramo32 Tramo42 Componente12 Componente22 Componente32 Componente42 Nivel12 Nivel22 Nivel32 Nivel42)

*Generación de variables de clasificación de la oferta según tipo de oportunidad y tramo
egen total_oferta = count(NOMBREDEINICIATIVA), by (NUM)
gen oportunidad_formacion_media = 1 if TIPODEOPORTUNIDADOPORTUNIDAD2 != . & Tramo12 != .    
gen oportunidad_formacion_posmedia = 1 if TIPODEOPORTUNIDADOPORTUNIDAD2 != . & Tramo22 != .
gen oportunidad_media_acceso = 1 if TIPODEOPORTUNIDADOPORTUNIDAD2 != . & Tramo12 != . & CLASIFICACIÓNDEACCESOOPORTUN2 != .
gen oportunidad_posmedia_acceso = 1 if TIPODEOPORTUNIDADOPORTUNIDAD2 != . & Tramo22 != . & CLASIFICACIÓNDEACCESOOPORTUN2 != .
gen oportunidad_empleo_acceso = 1 if M2 != . & CLASIFICACIÓNDEACCESOOPORTUN2 != .
gen oportunidad_media_com = 1 if TIPODEOPORTUNIDADOPORTUNIDAD2 != . & Tramo12 != . & P2 != .
gen oportunidad_posmedia_com = 1 if TIPODEOPORTUNIDADOPORTUNIDAD2 != . & Tramo22 != . & P2 != .
gen oportunidad_empleo_com = 1 if M2 != . & P2 != .

*A continuación, se diseñan y guardan los gráficos necesarios para describir la oferta por tramo, componente y niveles. Tanto en total como por observaciones únicas.

*Gráfico de oferta total por tramo, componente y nivel
preserve 
stack Tramo1 Tramo2 Tramo3 Tramo4, into(v) 

graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas por tramo", replace) nodraw


graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas por tramo", replace) nodraw

restore  

preserve 
stack Componente1 Componente2 Componente3 Componente4, into(v)
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas por componente", replace) nodraw

restore

preserve 
stack Nivel1 Nivel2 Nivel3 Nivel4, into(v)
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas por nivel", replace) nodraw

restore

*Gráfica de componente para tramo 1, 2, 3 y 4
preserve
stack Componente1 Componente2 Componente3 Componente4 if Tramo12 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas de tramo 1 por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas de tramo 1 por componente", replace) nodraw

restore

preserve
stack Componente1 Componente2 Componente3 Componente4 if Tramo22 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas de tramo 2 por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas de tramo 2 por componente", replace) nodraw

restore

preserve
stack Componente1 Componente2 Componente3 Componente4 if Tramo32 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas de tramo 3 por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas de tramo 3 por componente", replace) nodraw

restore

preserve
stack Componente1 Componente2 Componente3 Componente4 if Tramo42 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas de tramo 4 por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas de tramo 4 por componente", replace) nodraw

restore

*Gráfica nivel para tramo 1, 2, 3 y 4
preserve
stack Nivel1 Nivel2 Nivel3 Nivel4 if Tramo12 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas de tramo 1 por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas de tramo 1 por nivel", replace) nodraw

restore

preserve
stack Nivel1 Nivel2 Nivel3 Nivel4 if Tramo22 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas de tramo 2 por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas de tramo 2 por nivel", replace) nodraw

restore

preserve
stack Nivel1 Nivel2 Nivel3 Nivel4 if Tramo32 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas de tramo 3 por nivel", replace) nodraw 

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas de tramo 3 por nivel", replace) nodraw
restore

preserve
stack Nivel1 Nivel2 Nivel3 Nivel4 if Tramo42 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas de tramo 4 por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas de tramo 4 por nivel", replace) nodraw
restore

*A continuación se harán los gráficos por progrmas únicos. Es decir, una sola observacion por cada programa y no por cada sede. El objetivo es registrar y analizar la diversidad de programas por cada categoría de análisis

*Gráfico de programas por tramo
preserve
bysort IDPROGRAMA : keep if _n==1 
stack Tramo1 Tramo2 Tramo3 Tramo4, into(v)
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas por tramo", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas por tramo", replace) nodraw

restore 

*Gráfico de programas por componente
preserve
bysort IDPROGRAMA : keep if _n==1
stack Componente1 Componente2 Componente3 Componente4, into(v)
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas por componente", replace) nodraw

restore

*Gráfico de programas por nivel
preserve
bysort IDPROGRAMA : keep if _n==1 
stack Nivel1 Nivel2 Nivel3 Nivel4, into(v)
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas por nivel", replace) nodraw

restore


*Gráfico de programas por componente para tramo 1, 2, 3 y 4
preserve
bysort IDPROGRAMA : keep if _n==1
stack Componente1 Componente2 Componente3 Componente4 if Tramo12 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas de tramo 1 por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas de tramo 1 por componente", replace) nodraw

restore

preserve
bysort IDPROGRAMA : keep if _n==1
stack Componente1 Componente2 Componente3 Componente4 if Tramo22 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas de tramo 2 por componente", replace) nodraw


graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas de tramo 2 por componente", replace) nodraw

restore

preserve
bysort IDPROGRAMA : keep if _n==1
stack Componente1 Componente2 Componente3 Componente4 if Tramo32 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas de tramo 3 por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas de tramo 3 por componente", replace) nodraw


restore

preserve
bysort IDPROGRAMA : keep if _n==1
stack Componente1 Componente2 Componente3 Componente4 if Tramo42 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas de tramo 4 por componente", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas de tramo 4 por componente", replace) nodraw

restore

*Gráfico de programas por nivel para tramo 1, 2, 3 y 4
preserve
bysort IDPROGRAMA : keep if _n==1
stack Nivel1 Nivel2 Nivel3 Nivel4 if Tramo12 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas de tramo 1 por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas de tramo 1 por nivel", replace) nodraw

restore

preserve
bysort IDPROGRAMA : keep if _n==1
stack Nivel1 Nivel2 Nivel3 Nivel4 if Tramo22 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas de tramo 2 por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas de tramo 2 por nivel", replace) nodraw

restore

preserve
bysort IDPROGRAMA : keep if _n==1
stack Nivel1 Nivel2 Nivel3 Nivel4 if Tramo32 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas de tramo 3 por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas de tramo 3 por nivel", replace) nodraw

restore

preserve
bysort IDPROGRAMA : keep if _n==1
stack Nivel1 Nivel2 Nivel3 Nivel4 if Tramo42 != ., into(v) 
graph bar (count), over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\frecuencia iniciativas únicas de tramo 4 por nivel", replace) nodraw

graph bar,  blabel(total, format(%9.2f))  over( v, label(labcolor("gs4") labsize(relative4))) bargap(5)  lintensity(0) blabel(total) blabel(bar, size(relative3p5)) asyvars showyvars legend(off) ytitle(Porcentaje) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\porcentaje iniciativas únicas de tramo 4 por nivel", replace) nodraw

restore

* Se eliminan las observaciones que no tienen ubicación o que se encuentran fuera de Bogotá
keep if LOCALIDAD != "PENDIENTE" & LOCALIDAD != "SOACHA" & LOCALIDAD != "LA CALERA" & LOCALIDAD != "CHÍA"

* A continuación, se colapsa la base por UPZ y luego por localidad. Para obtener dos archivos .dta: uno que contenga la información de la oferta por UPZ y otro que la contenga por Localidades

preserve
*Se eliminan las observaciones ubicadas en UPR, ya que la Encuesta Multiporpósito no las contempla
drop if strpos(COD_UPR,"UPR")>0
*Se colapsa la información a nivel de UPZ
collapse (count) TIPODEOPORTUNIDADOPORTUNIDAD2 M2 TIPODEOPORTUNIDADOTRASOPORT2 CLASIFICACIÓNDEACCESOOPORTUN2 P2 Tramo12 Tramo22 Tramo32 Tramo42 Componente12 Componente22 Componente32 Componente42 Nivel12 Nivel22 Nivel32 Nivel42  oportunidad_formacion_media oportunidad_formacion_posmedia oportunidad_media_acceso oportunidad_posmedia_acceso oportunidad_empleo_acceso oportunidad_media_com oportunidad_posmedia_com oportunidad_empleo_com total_oferta, by(COD_UPZ UPZ LOCALIDAD)
*Se eliminan los conteos para las observaciones sin UPZ
keep if UPZ != ""
*Se convierten todas las variables posibles en int
destring, replace
*Se renombran ciertas variables para poner nombre de más fácil entendimiento
rename (TIPODEOPORTUNIDADOPORTUNIDAD2 M2 TIPODEOPORTUNIDADOTRASOPORT2 CLASIFICACIÓNDEACCESOOPORTUN2 P2 Tramo12 Tramo22 Tramo32 Tramo42 Componente12 Componente22 Componente32 Componente42 Nivel12 Nivel22 Nivel32 Nivel42) (oportunidad_formacion oportunidad_empleo oportunidad_otro oportunidad_acceso oportunidad_com tramo1 tramo2 tramo3 tramo4 componente1 componente2 componente3 componente4 nivel1 nivel2 nivel3 nivel4)
*Se verifica que no haya UPZ repetidas
duplicates list COD_UPZ
save "$path\oferta_colapsada_UPZ.dta", replace

restore 


* Para los nombres de las localidades, se eliminan los carácteres especiales con tilde, de esta forma se podrá unir en un futuro con la variable de localidades de la Encuesta Multipropósito
loc s LOCALIDAD
        replace `s' = subinstr(`s', "Á", "A", .)
        replace `s' = subinstr(`s', "É", "E", .)
        replace `s' = subinstr(`s', "Í", "I", .)
        replace `s' = subinstr(`s', "Ó", "O", .)
        replace `s' = subinstr(`s', "Ú", "U", .)
		
preserve
merge m:1 LOCALIDAD using "poblaciónjov_2018_LOCALIDAD.dta", gen (m_poblacion)
egen total_loc = count( NUM ), by(LOCALIDAD)
gen prop_poblacion = (total_loc / jov_total)*1000
graph hbar (first) prop_poblacion,  blabel(total, format(%9.2f)) nofill over(LOCALIDAD, sort(1) descending label(labcolor("gs4") labsize(relative4)))  bargap(5)  lintensity(0)  blabel(total) blabel(bar, size(relative3p5))  asyvars showyvars legend(off) ytitle(Frecuencia) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs9) glpattern(shortdash) gextend) ymtick(, labels labsize(relative4) labcolor(gs4)) saving("$graphs\proporción población jóven por localidad", replace) 
restore

preserve
* Se colapsa la información de la oferta por localidad
collapse (count) TIPODEOPORTUNIDADOPORTUNIDAD2 M2 TIPODEOPORTUNIDADOTRASOPORT2 CLASIFICACIÓNDEACCESOOPORTUN2 P2 Tramo12 Tramo22 Tramo32 Tramo42 Componente12 Componente22 Componente32 Componente42 Nivel12 Nivel22 Nivel32 Nivel42  oportunidad_formacion_media oportunidad_formacion_posmedia oportunidad_media_acceso oportunidad_posmedia_acceso oportunidad_empleo_acceso oportunidad_media_com oportunidad_posmedia_com oportunidad_empleo_com total_oferta, by(LOCALIDAD)
* Se modifica el nombre de ciertas variables para hacer más claro el análisis
rename (TIPODEOPORTUNIDADOPORTUNIDAD2 M2 TIPODEOPORTUNIDADOTRASOPORT2 CLASIFICACIÓNDEACCESOOPORTUN2 P2 Tramo12 Tramo22 Tramo32 Tramo42 Componente12 Componente22 Componente32 Componente42 Nivel12 Nivel22 Nivel32 Nivel42) (oportunidad_formacion oportunidad_empleo oportunidad_otro oportunidad_acceso oportunidad_com tramo1 tramo2 tramo3 tramo4 componente1 componente2 componente3 componente4 nivel1 nivel2 nivel3 nivel4)
*Se verifica no tener localidades repetidas
duplicates list LOCALIDAD
save "$path\oferta_colapsada_LOCALIDAD.dta", replace

restore


******************************************************************************
**************** Censo 2018 *********************

*Para analizar las proporciones per cápita, se incluirá la información poblacional del CENSO de 2018 por UPZ, proporcionada por la Secretaría Distrital de Planeación

import excel "$path\4._Cifras_Vivienda,_Hogares_y_Personas_desagregadas_por_áreas_calculadas_con_base_en_las_UPZ_2018-2024.xlsx", sheet("1.1") firstrow clear

* Se modifican nombres de variables para que sean iguales a los de las bases de datos con los que se combinarán
rename CódigoUPZ COD_UPZ
rename NombreUPZ UPZ
rename Nombrelocalidad LOCALIDAD
rename Códigolocalidad COD_LOCALIDAD
rename E POB_2018
destring, replace

* Se crean los grupos de variables de la Encuesta Multiporpósito 2017, de la misma forma explicada anteriormente.

replace UPZ = "Marco Fidel Suarez y San José" if COD_UPZ == 53 | COD_UPZ == 36
replace UPZ = "Castilla y Bavaria" if COD_UPZ == 46 | COD_UPZ == 113
replace UPZ = "Country Club, Usaquén y Santa Bárbara" if COD_UPZ == 15 | COD_UPZ == 14 | COD_UPZ == 16
replace UPZ = "Verbenal, Paseo Los Libertadores y La Uribe" if COD_UPZ == 9 | COD_UPZ == 1 | COD_UPZ == 10 
replace UPZ = "La Floresta y La Alhambra" if COD_UPZ == 25 | COD_UPZ == 20
replace UPZ = "La Academia, Guaymaral y San José de Bavaria" if COD_UPZ == 2 | COD_UPZ == 3 | COD_UPZ == 17 
replace UPZ = "Parque Salitre y Doce de Octubre" if COD_UPZ == 103 | COD_UPZ == 22 
replace UPZ = "Parque Simón Bolivar – CAN y La Esmeralda" if COD_UPZ == 104 | COD_UPZ == 106
replace UPZ = "Zona Industrial y Puente Aranda" if COD_UPZ == 108 | COD_UPZ == 111
replace UPZ = "Santa Cecilia, Alamos y Jardín Botánico" if COD_UPZ == 31 | COD_UPZ == 116 | COD_UPZ == 105 
replace UPZ = "Alfonso Lopez y Ciudad Usme" if COD_UPZ == 59 | COD_UPZ == 61 
replace UPZ = "Parque Entrenubes y Danubio" if COD_UPZ == 60 | COD_UPZ == 56
replace UPZ = "Aeropuerto El Dorado y Capellanía" if COD_UPZ == 117 | COD_UPZ == 115 
replace UPZ = "Nieves y Sagrado Corazón" if COD_UPZ == 93 | COD_UPZ == 91
replace UPZ = "Monteblanco, Tesoro y Mochuelo" if COD_UPZ == 64 | COD_UPZ == 68 | COD_UPZ == 63 
replace UPZ = "Pardo Rubio y Chapinero" if COD_UPZ == 90 | COD_UPZ == 99
replace UPZ = "Chico Lago y Refugio" if COD_UPZ == 97 | COD_UPZ == 88

replace COD_UPZ = 801 if COD_UPZ == 53 | COD_UPZ == 36
replace COD_UPZ = 802 if COD_UPZ == 46 | COD_UPZ == 113
replace COD_UPZ = 803 if COD_UPZ == 15 | COD_UPZ == 14 | COD_UPZ == 16
replace COD_UPZ = 804 if COD_UPZ == 9 | COD_UPZ == 1 | COD_UPZ == 10 
replace COD_UPZ = 805 if COD_UPZ == 25 | COD_UPZ == 20
replace COD_UPZ = 806 if COD_UPZ == 2 | COD_UPZ == 3 | COD_UPZ == 17 
replace COD_UPZ = 807 if COD_UPZ == 103 | COD_UPZ == 22 
replace COD_UPZ = 808 if COD_UPZ == 104 | COD_UPZ == 106 
replace COD_UPZ = 809 if COD_UPZ == 108 | COD_UPZ == 111 
replace COD_UPZ = 810 if COD_UPZ == 31 | COD_UPZ == 116 | COD_UPZ == 105 
replace COD_UPZ = 811 if COD_UPZ == 59 | COD_UPZ == 61 
replace COD_UPZ = 812 if COD_UPZ == 60 | COD_UPZ == 56 
replace COD_UPZ = 813 if COD_UPZ == 117 | COD_UPZ == 115 
replace COD_UPZ = 814 if COD_UPZ == 93 | COD_UPZ == 91 
replace COD_UPZ = 815 if COD_UPZ == 64 | COD_UPZ == 68 | COD_UPZ == 63 
replace COD_UPZ = 816 if COD_UPZ == 90 | COD_UPZ == 99
replace COD_UPZ = 817 if COD_UPZ == 97 | COD_UPZ == 88

* Se colapsa la información a nivel de UPZ
preserve
collapse(sum) POB_2018, by(COD_UPZ UPZ)
save "$path\población_2018_UPZ.dta", replace
restore

*Se colapsa la información a nivel de localidad
preserve
replace LOCALIDAD = upper(LOCALIDAD)
loc s LOCALIDAD
        replace `s' = subinstr(`s', "Á", "A", .)
        replace `s' = subinstr(`s', "É", "E", .)
        replace `s' = subinstr(`s', "Í", "I", .)
        replace `s' = subinstr(`s', "Ó", "O", .)
        replace `s' = subinstr(`s', "Ú", "U", .)
collapse(sum) POB_2018, by(LOCALIDAD)
save "$path\población_2018_LOCALIDAD.dta", replace
restore


******************************************************************************
**************** Encuesta multipropósito 2017 - juventud *********************

*El tratamiento de la información de la Encuesta Multipropósito 2017 es realizado por GOYN, entidad que fecilita el código. El equipo Capstone Urosario realiza unas modificaciones para adaptarlo al objetivo del proyecto.

clear all
cd "$path\"

*Pegar capítulos de la encuesta - datos de 107,218 hogares, 75,697 en las localidades de la ciudad
*Se encuentran datos para  319,952 personas, 221,809 de ellas en las localidades de la ciudad

use "Identificacion ( Capitulo A)"
merge 1:m DIRECTORIO  using "Composicion del hogar y demografia ( Capitulo E)", gen (m_comp)
merge 1:1 DIRECTORIO_PER using "Fuerza de trabajo  (capítulo K)", gen (m_ft)
merge 1:1 DIRECTORIO_PER using "Educacion (capitulo H)",gen (m_educ)
merge 1:1 DIRECTORIO_PER using "Salud ( Capitulo F)", gen (m_sal)

*Se eliminan registros que no son de Bogotá
drop if CODLOCALIDAD==.
*drop if LOCALIDAD_TEX=="OTRA LOCALIDAD RURAL"

set dp comma
rename FEX_C fex

*Recategorizar edad

gen edad = NPCEP4
replace edad=1 if edad<14
replace edad=2 if edad>=14 & edad<=17
replace edad=3 if edad>=18 & edad<=24
replace edad=4 if edad>=25 & edad<=28
replace edad=5 if edad>=29 

	
label define l_edad 1"menos de 14 años" 2"14 a 17 años" 3"18 a 24 años" 4"25 a 28 años" 5"29 y mas"
label values edad l_edad

* Max nivel educativo = NPCHP4 / nivel educativo actual = NPCHP6

tab NPCHP4
tab NPCHP6

gen nedu=1 if NPCHP4==1
replace nedu=2 if NPCHP4==2|NPCHP4==3|NPCHP4==4|NPCHP6==1|NPCHP6==2| NPCHP6==3
replace nedu=3 if NPCHP4==5| NPCHP4==8 | NPCHP6==4 | NPCHP6==5| NPCHP6==6| NPCHP6==7
replace nedu=4 if NPCHP4==6
replace nedu=5 if NPCHP4==7
replace nedu=6 if NPCHP4==9 |NPCHP4==10| NPCHP4==12| NPCHP4==14| NPCHP6==8| NPCHP6==9| NPCHP6==10
replace nedu=7 if NPCHP4==11|NPCHP4==13|NPCHP4==15

label var nedu "Máximo nivel educativo alcanzado"
label define l_edu 1 "Ninguno" 2 "Primaria y Secundaria" 3"Media" 4"Técnico" 5"Tecnológico" 6"Universitario" 7"Postgrado"
label values nedu l_edu


*Indicadores Mercado laboral

gen pet=1 if NPCEP4>=12
replace pet=0 if pet!=1
label var pet "Población en edad de trabajar"

gen ocupado=1 if (NPCKP1==1|NPCKP2==1|NPCKP3==1|NPCKP4==1) & pet==1
replace ocupado=0 if ocupado!=1

gen estudia=1 if NPCHP2==1
replace estudia=0 if NPCHP2!=1

gen paga_salud=1 if (NPCFP2==1|NPCFP2==2)|(NPCFP4A==1| NPCFP4B==1| NPCFP4C==1 |NPCFP4D==1)
gen informal=0 if paga_salud==1 & NPCKP43==1 & NPCKP50==1 & ocupado==1
replace informal=1 if informal==. & ocupado==1
label var informal "Informales por no cotizar a pensiones, arl y salud"

gen nini=1 if estudia==0 & ocupado==0 & (edad==2 | edad==3 | edad==4)
replace nini=0 if nini!=1
tabstat nini [aw=fex] , by (LOCALIDAD_TEX) sta(sum) format(%10.0fc)

gen oy=1 if nini==1 | informal==1 & (edad==2 | edad==3 | edad==4)
replace oy=0 if oy!=1
tabstat oy [aw=fex] , by (LOCALIDAD_TEX) sta(sum) format(%10.0fc)


*Perfiles de reconexión

*drop perfiles
gen perfiles =.
replace perfiles = 1 if ((nini==1 | informal==1) & nedu<=2 & (edad<=4 & edad>1))
replace perfiles = 2 if ((nini==1 | informal==1) & nedu==3 & (edad<=4 & edad>1))
replace perfiles = 3 if ((nini==1 | informal==1) & nedu>=4 & (edad<=4 & edad>1))

label define l_per  1 "Perfil 1"  2 "Perfil 2" 3 "Perfil 3" 
label values perfiles l_per

tabstat fex, by (perfiles) sta(sum) format(%10.0fc)

*Se tabula la variable de perfiles en las variables necesarias
tab perfiles, gen(perfiles_)
tab edad, gen(edad_)

*Se reemplazan los valores iguales a 0 por missing values para las variables de interés
foreach x of varlist edad_1 edad_2 edad_3 edad_4 edad_5 perfiles_1 perfiles_2 perfiles_3 nini oy{
  replace `x' = . if(`x' == 0)
}

* Se generan variables de perfiles por sexo, con la intención de comprobar si existen tendencias por sexo
gen perfil1_hombre = 1 if perfiles == 1 & NPCEP5 == 1
gen perfil2_hombre = 1 if perfiles == 2 & NPCEP5 == 1
gen perfil3_hombre = 1 if perfiles == 3 & NPCEP5 == 1
gen perfil1_mujer = 1 if perfiles == 1 & NPCEP5 == 2
gen perfil2_mujer = 1 if perfiles == 2 & NPCEP5 == 2
gen perfil3_mujer = 1 if perfiles == 3 & NPCEP5 == 2

* Se cambia el nombre y reemplazan las tildes de las vocales por vocales sin valores especiales para facilitar la unión con las otras bases de datos manipuladas

rename LOCALIDAD_TEX LOCALIDAD
chartab LOCALIDAD
loc s LOCALIDAD
        replace `s' = subinstr(`s', "Á", "A", .)
        replace `s' = subinstr(`s', "É", "E", .)
        replace `s' = subinstr(`s', "Í", "I", .)
        replace `s' = subinstr(`s', "Ó", "O", .)
        replace `s' = subinstr(`s', "Ú", "U", .)
		replace `s' = "LA CANDELARIA" if `s' == "CANDELARIA"
		replace `s' = usubinstr(`s', "`=uchar(65533)'", "Ñ", .)

******************************************************************************
**************** Análisis de correlaciones *********************

* A continuación, se colapsa la información de la Encuesta Multiporpósito 2017 a nivel de UPZ y se combina con las otras bases creadas para analizar

preserve 
* Se realiza el colapso de las variables de interés a nivel de UPZ
collapse (count) edad_1 edad_2 edad_3 edad_4 edad_5 perfiles_1 perfiles_2 perfiles_3 nini oy perfil1_hombre perfil2_hombr perfil3_hombre perfil1_mujer perfil2_mujer perfil3_mujer, by(COD_UPZ)
* Se une la información con las otras bases de datos
merge m:1 COD_UPZ using "$path\oferta_colapsada_UPZ.dta", gen (m_oferta)
merge m:1 COD_UPZ using "$path\población_2018_UPZ.dta", gen (m_poblacion)
* Se eliminan las observaciones que no tienen UPZ
keep if COD_UPZ != .
* Para comenzar el análisis, se realizan gráficos de dispersión para conocer la tendencia lineal de los datos y comenzar el análisis gráfico. Este se hace entre los perfiles creados y los tipos de oportunidades, según hipótesis de interés.

twoway (scatter perfiles_1 oportunidad_formacion_media) (lfit perfiles_1 oportunidad_formacion_media) (lowess perfiles_1 oportunidad_formacion_media), legend(position(6))   ytitle(variable 1) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) xtitle(, size(relative3p5) color(gs4)) xlabel(#7, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) legend(size(relative3)color(gs2)) legend(on order(1 "Observado" 2 "Lineal" 3 "Local") size(relative3) color(gs2))  saving("$graphs\gráfico de dispersión perfiles 1 y oportundiades de formación media upz", replace) nodraw


twoway (scatter perfiles_2 oportunidad_formacion_posmedia) (lfit perfiles_2 oportunidad_formacion_posmedia) (lowess perfiles_2 oportunidad_formacion_posmedia), legend(position(6))   ytitle(variable 1) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) xtitle(, size(relative3p5) color(gs4)) xlabel(#7, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) legend(size(relative3)color(gs2)) legend(on order(1 "Observado" 2 "Lineal" 3 "Local") size(relative3) color(gs2)) saving("$graphs\gráfico de dispersión perfiles 2 y oportundiades de formación posmedia upz", replace) nodraw


twoway (scatter perfiles_3 oportunidad_empleo) (lfit perfiles_3 oportunidad_empleo) (lowess perfiles_3 oportunidad_empleo), legend(position(6))   ytitle(variable 1) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) xtitle(, size(relative3p5) color(gs4)) xlabel(#7, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) legend(size(relative3)color(gs2)) legend(on order(1 "Observado" 2 "Lineal" 3 "Local") size(relative3) color(gs2)) saving("$graphs\gráfico de dispersión perfiles 3 y oportundiades de empelo upz", replace) nodraw

* Se comprueba normalidad bivariada de las variables de iterés para comprobar la idoneidad de aplicar el coeficiente de Pearson. Se encuentra que no hay normalidad bivariada para ninguna de las relaciones de interés. Además, las relaciones no son claramente lineales por los gráficos realizados y se encuentran valores atípicos. Por tanto, no se aconseja el uso del coeficiente de Pearson. 
mvtest normality  perfiles_1 oportunidad_formacion_media, bivariate univariate stats(all) /* se rechaza, no a normalidad bivariada */
mvtest normality  perfiles_2 oportunidad_formacion_posmedia, bivariate univariate stats(all) /* se rechaza, no a normalidad bivariada */
mvtest normality  perfiles_3 oportunidad_empleo, bivariate univariate stats(all) /* se rechaza, no a normalidad bivariada */
* Se obtiene el coeficiente de Pearson como punto de comparación
pwcorr perfiles_1 oportunidad_formacion_media, obs sig /* Correlación pequeña y no significativa */
pwcorr perfiles_2 oportunidad_formacion_posmedia, obs sig /* Correlación  -0,2964 y signficacancia  0,0048 */
pwcorr perfiles_3 oportunidad_empleo, obs sig /* Correlación   0,2049 y signficacancia  0,0541 */

* Se elige realizar y reportar el coeficiente de correlación de Spearman, el cual es robusto a valores atípicos, relaciones no lineales y no normales, mientras exista monotonicidad.

spearman total_oferta oy, stats(obs p) /* Correlación    -0,0002 y signficacancia  0,9988 */
spearman total_oferta nini, stats(obs p) /* Correlación   -0,0381 y signficacancia   0,7231 */

spearman perfiles_1 oportunidad_formacion_media, stats(obs p) /* Correlación   0,0735 y signficacancia  0,4934 */
spearman perfiles_2 oportunidad_formacion_posmedia, stats(obs p) /* Correlación   -0,3221 y signficacancia  0,0021 */
spearman perfiles_3 oportunidad_empleo, stats(obs p) /* Correlación   0,1978 y signficacancia   0,0631 */

spearman perfiles_1 oportunidad_media_acceso, stats(obs p) /* Correlación   -0,0494 y signficacancia   0,6454 */
spearman perfiles_2 oportunidad_posmedia_acceso, stats(obs p) /* Correlación   -0,3407 y signficacancia   0,0011 */
spearman perfiles_3 oportunidad_empleo_acceso, stats(obs p) /* Correlación   0,1273 y signficacancia  0,2344 */

spearman perfiles_1 oportunidad_media_com, stats(obs p) /* Correlación   0,3242 y signficacancia  0,0019 */
spearman perfiles_2 oportunidad_posmedia_com , stats(obs p) /* Correlación   0,1466 y signficacancia  0,1704 */
spearman perfiles_3 oportunidad_empleo_com , stats(obs p) /* Correlación   0,1944 y signficacancia  0,0679 */

*Se hace un análisis por proporciones con los datos poblacionales incluídos a nivel de UPZ. 

gen oy_pob = oy/POB_2018

gen nini_pob = nini/POB_2018

gen perfil1_pob = perfiles_1/POB_2018

gen perfil2_pob = perfiles_2/POB_2018

gen perfil3_pob = perfiles_3/POB_2018

gen oferta_pob = total_oferta/POB_2018

gen ofertamediaacceso_pob =  oportunidad_media_acceso /POB_2018

gen ofertaposmediaacceso_pob =  oportunidad_posmedia_acceso /POB_2018

gen ofertaempleoacceso_pob =  oportunidad_empleo_acceso /POB_2018

gen ofertamedia_pob =  oportunidad_formacion_media /POB_2018

gen ofertaposmedia_pob =  oportunidad_formacion_posmedia /POB_2018

gen ofertaempleo_pob =  oportunidad_empleo /POB_2018

spearman nini_pob oferta_pob, stats(obs p) /* Correlación   0,0404 y signficacancia  0,7072 */
spearman oy_pob oferta_pob, stats(obs p) /* Correlación  0,1451 y signficacancia  0,1749 */

spearman perfil1_pob ofertamedia_pob, stats(obs p) /* Correlación   0,0783 y signficacancia  0,4657 */
spearman perfil2_pob ofertaposmedia_pob, stats(obs p) /* Correlación   -0,2603 y signficacancia  0,0138 */
spearman perfil3_pob ofertaempleo_pob, stats(obs p) /* Correlación   -0,1546 y signficacancia   0,1479 */

spearman perfil1_pob ofertamediaacceso_pob, stats(obs p) /* Correlación   -0,0568 y signficacancia  0,5972 */
spearman perfil2_pob ofertaposmediaacceso_pob, stats(obs p) /* Correlación   -0,2595 y signficacancia  0,0141 */
spearman perfil3_pob ofertaempleoacceso_pob, stats(obs p) /* Correlación   -0,0595 y signficacancia  0,5797 */

restore

*** Análisas por Localidad ****
preserve 
* Se realiza el colapso de las variables de interés a nivel de localidad

collapse (count) edad_1 edad_2 edad_3 edad_4 edad_5 perfiles_1 perfiles_2 perfiles_3 nini oy perfil1_hombre perfil2_hombr perfil3_hombre perfil1_mujer perfil2_mujer perfil3_mujer, by(LOCALIDAD)

* Se une la información con las otras bases de datos
merge m:1 LOCALIDAD using "$path\oferta_colapsada_LOCALIDAD.dta", gen (m_oferta)
merge m:1 LOCALIDAD using "$path\población_2018_LOCALIDAD.dta", gen (m_poblacion)

* Se eliminan las observaciones que no tienen localidad
keep if LOCALIDAD != ""
* Se realizan gráficos de dispersión para conocer la tendencia lineal de los datos y comenzar el análisis gráfico. Este se hace entre los perfiles creados y los tipos de oportunidades, según hipótesis de interés.
twoway (scatter perfiles_1 oportunidad_formacion_media) (lfit perfiles_1 oportunidad_formacion_media) (lowess perfiles_1 oportunidad_formacion_media), legend(position(6))   ytitle(variable 1) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) xtitle(, size(relative3p5) color(gs4)) xlabel(#7, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) legend(size(relative3)color(gs2)) legend(on order(1 "Observado" 2 "Lineal" 3 "Local") size(relative3) color(gs2))  saving("$graphs\gráfico de dispersión perfiles 1 y oportundiades de formación media localidad", replace) nodraw


twoway (scatter perfiles_2 oportunidad_formacion_posmedia) (lfit perfiles_2 oportunidad_formacion_posmedia) (lowess perfiles_2 oportunidad_formacion_posmedia), legend(position(6))   ytitle(variable 1) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) xtitle(, size(relative3p5) color(gs4)) xlabel(#7, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) legend(size(relative3)color(gs2)) legend(on order(1 "Observado" 2 "Lineal" 3 "Local") size(relative3) color(gs2)) saving("$graphs\gráfico de dispersión perfiles 2 y oportundiades de formación posmedia localidad", replace) nodraw

twoway (scatter perfiles_3 oportunidad_empleo) (lfit perfiles_3 oportunidad_empleo) (lowess perfiles_3 oportunidad_empleo), legend(position(6))   ytitle(variable 1) ytitle(, size(relative3p5) color(gs4)) ylabel(, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) xtitle(, size(relative3p5) color(gs4)) xlabel(#7, labels labsize(relative4) labcolor(gs4) grid glwidth(medium) glcolor(gs11) glpattern(shortdash)) legend(size(relative3)color(gs2)) legend(on order(1 "Observado" 2 "Lineal" 3 "Local") size(relative3) color(gs2)) saving("$graphs\gráfico de dispersión perfiles 3 y oportundiades de empelo localidad", replace) nodraw

* Se comprueba normalidad bivariada de las variables de iterés para comprobar la idoneidad de aplicar el coeficiente de Pearson. Se encuentra que no hay normalidad bivariada para la mayoría de las relaciones de interés. Además, las relaciones no son claramente lineales por los gráficos realizados y se encuentran valores atípicos. Por tanto, no se aconseja el uso del coeficiente de Pearson. 
mvtest normality  perfiles_1 oportunidad_formacion_media, bivariate univariate stats(all) /* se rechaza, no a normalidad bivariada */
mvtest normality  perfiles_2 oportunidad_formacion_posmedia, bivariate univariate stats(all) /* no se rechaza al 5 % , hay normalidad bivariada */
mvtest normality  perfiles_3 oportunidad_empleo, bivariate univariate stats(all) /* no se rechaza al 5 % , hay normalidad bivariada */

* Se obtiene el coeficiente de Pearson como punto de comparación
pwcorr perfiles_1 oportunidad_formacion_media, obs sig  /* Correlación   0,5191 y signficacancia  0,0190 */
pwcorr perfiles_2 oportunidad_formacion_posmedia, obs sig /* Correlación   -0,1094 y signficacancia   0,6461 */
pwcorr perfiles_3 oportunidad_empleo, obs sig /* Correlación   0,5302 y signficacancia  0,0162 */

* Se elige realizar y reportar el coeficiente de correlación de Spearman, el cual es robusto a valores atípicos, relaciones no lineales y no normales, mientras exista monotonicidad.

spearman total_oferta oy, stats(obs p) /* Correlación    0,8361 y signficacancia  0,0000 */
spearman total_oferta nini, stats(obs p) /* Correlación    0,8226 y signficacancia  0,0000 */

spearman perfiles_1 oportunidad_formacion_media, stats(obs p) /* Correlación   0,7449 y signficacancia   0,0002 */
spearman perfiles_2 oportunidad_formacion_posmedia, stats(obs p) /* Correlación   -0,1964 y signficacancia  0,4066 */
spearman perfiles_3 oportunidad_empleo, stats(obs p) /* Correlación   0,5447 y signficacancia  0,0130 */

spearman perfiles_1 oportunidad_media_acceso, stats(obs p) /* Correlación   0,6629 y signficacancia  0,0014 */
spearman perfiles_2 oportunidad_posmedia_acceso, stats(obs p) /* Correlación   -0,2031 y signficacancia  0,3905 */
spearman perfiles_3 oportunidad_empleo_acceso, stats(obs p) /* Correlación   0,3933 y signficacancia  0,0863 */

spearman perfiles_1 oportunidad_media_com, stats(obs p) /* Correlación   0,8029 y signficacancia  0,0000 */
spearman perfiles_2 oportunidad_posmedia_com , stats(obs p) /* Correlación   0,4556 y signficacancia   0,0435 */
spearman perfiles_3 oportunidad_empleo_com , stats(obs p) /* Correlación    0,5983 y signficacancia  0,0053 */

*Se hace un análisis por proporciones con los datos poblacionales incluídos a nivel de localidad. 

gen oy_pob = oy/POB_2018

gen nini_pob = nini/POB_2018

gen perfil1_pob = perfiles_1/POB_2018

gen perfil2_pob = perfiles_2/POB_2018

gen perfil3_pob = perfiles_3/POB_2018

gen oferta_pob = total_oferta/POB_2018

gen ofertamediaacceso_pob =  oportunidad_media_acceso /POB_2018

gen ofertaposmediaacceso_pob =  oportunidad_posmedia_acceso /POB_2018

gen ofertaempleoacceso_pob =  oportunidad_empleo_acceso /POB_2018

gen ofertamedia_pob =  oportunidad_formacion_media /POB_2018

gen ofertaposmedia_pob =  oportunidad_formacion_posmedia /POB_2018

gen ofertaempleo_pob =  oportunidad_empleo /POB_2018

spearman nini_pob oferta_pob, stats(obs p)/* Correlación 0,4105 y signficacancia   0,0808 */
spearman oy_pob oferta_pob, stats(obs p) /* Correlación 0,5526 y signficacancia  0,0141 */

spearman perfil1_pob ofertamedia_pob, stats(obs p) /* Correlación  0,4842 y signficacancia  0,0357 */
spearman perfil2_pob ofertaposmedia_pob, stats(obs p) /* Correlación 0,2228 y signficacancia   0,3592 */
spearman perfil3_pob ofertaempleo_pob, stats(obs p) /* Correlación 0,2281 y signficacancia   0,3477 */

spearman perfil1_pob ofertamediaacceso_pob, stats(obs p) /* Correlación 0,1263 y signficacancia  0,6064 */
spearman perfil2_pob ofertaposmediaacceso_pob, stats(obs p) /* Correlación 0,2193 y signficacancia   0,3670 */
spearman perfil3_pob ofertaempleoacceso_pob, stats(obs p) /* Correlación -0,0835 y signficacancia  0,7341 */











