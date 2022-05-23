# SerializadorDatosAFE_FPGA
En este repositorio se encuentran todos los códigos en lenguaje Python creados para el desarrollo de mi trabajo de grado. También se encuentran archivos complementarios para la implementación del sistema en la tarjeta Nexys Video, y archivos de Excel con los resultados de las pruebas del sistema.
- En la carpeta "Recepción Serial" se encuentran todos los códigos empleados para la recepción de los datos provenientes de la Nexys Video. (Uso de librería PySerial). Además, también se presenta la carpeta "Pruebas Final Sampleo". En esta se encuentran todos los archivos .csv generados para cada uno de los distintos modos de operación, y frecuencias de submuestreo que presenta el diseño. En los mismos también se encuentran las gráficas de los datos para cada canal según este modo de operación, empleadas para la obtención de errores relativos en el trabajo final entregado. El resto de carpetas hace alusión a los primeros resultados que se generaron, que presentaban anomalías, y que llevaron a la necesidad de implementar un sistema de verificación para el diseño.
- En la carpeta "FullDesignWriteCounter" se encuentran los códigos construidos para la generación del sistema de adquisición y serialización. Se presentan tanto el primer diseño definitivo ("Main.py"), como la adición de los submuestreadores ("MainUnderSampler.py"), la adición posterior de la verificación de escrituras sobre la memoria ("MainWriteCounter.py"); y el diseño definitivo que combina tanto dicha verifiación de memoria como los submuestreadores ("MainWriteUnder.py"), siendo este último el que se empleó para construir los archivos que se encuentran en la carpeta "build" (construcción de síntesis, implementación y Bitstream en Vivado), los cuales fueron implementados/programados en la tarjeta Nexys Video. La carpeta "cores" contiene aquellos submódulos que conforman el módulo top principal. La carpeta "platforms" incluye el código en migen de las Constraints de la Nexys Video.
- La carpeta "SERDES_EM" contiene los primeros códigos implementados en VHDL que se encargaban de la adquisición de los datos provenientes del AFE5808A, y su alineación con los relojes Bit Clock y Frame Clock. Estos fueron psoteriormente adaptados y adecuados a Migen. A su vez, la carpeta "TesisVHDLAdquisition" contiene una version similar a esta
- La carpeta "FIFO" contiene los primeros acercamientos hechos para las memorias FIFO en configuración cascada en VHDL, posteriormente implementada en Migen en el código "MultiFIFO.py", además de las máquians de estado que la controlarían.
