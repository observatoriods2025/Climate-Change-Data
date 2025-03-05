
# Cargar paquetes
paquetes <- c('tidyverse', 'ggplot2', 'readxl', 'tidyr', 'dplyr', 'forecast', 'data.table',
              'rugarch', 'strucchange', 'dynlm', 'coefplot', 'modelsummary', 'MatchIt',
              'cobalt', 'rbounds', 'scales', 'tseries', 'zoo', 'janitor', 'lubridate',
              'openxlsx', 'Matching', 'stargazer', 'tidyquant', 'car', 'quantmod', 'MSwM',
              'arm', 'broom', 'Ecdat', 'vars', 'MASS', 'urca', 'tsDyn', 'haven', 'tsutils',
              'dyn', 'mFilter', 'anytime', 'astsa', 'xts', 'foreign', 'timsac',
              'lmtest', 'twang', 'shiny', 'shinydashboard', 'flexdashboard', 'plotly', 'collapse',
              'bsicons', 'bslib', 'DT', 'rsconnect', 'shinytest2', 'treemapify', 'packrat',
              'testthat', 'shinyWidgets', 'httr', 'jsonlite')

paquetes_faltantes <- paquetes[!(paquetes %in% installed.packages()[,"Package"])]
if(length(paquetes_faltantes)) install.packages(paquetes_faltantes)
lapply(paquetes, require, character.only = TRUE)

# Definir UI
ui <- dashboardPage(
  dashboardHeader(
    title = span("Centro de Datos Climáticos", style = "white-space: normal; font-size: 18px;"),
    titleWidth = 300,
    tags$li(class = "dropdown", tags$a(href = "https://github.com/", icon("github"), title = "GitHub")),
    tags$li(class = "dropdown", tags$a(href = "https://www.youtube.com/", icon("youtube"), title = "YouTube")),
    tags$li(class = "dropdown", tags$a(href = "https://www.linkedin.com/", icon("linkedin"), title = "LinkedIn")),
    
    tags$li(
      class = "dropdown",
      tags$img(src = "Captura_logo_observatorio_png.png", height = "45px", style = "margin-top: 5px; margin-right: 15px;")
    ),
    
    # Contador de visitas como infoBox
    tags$li(
      class = "dropdown",
      infoBoxOutput("visitBox", width = NULL)  # Aquí se mostrará el contador
    )
  ),
  
  dashboardSidebar(
    # Agregar los logos en la parte superior del sidebar
    tags$div(
      style = "position: absolute; bottom: 45px; left: 50%; transform: translateX(-50%); text-align: center;",
      tags$img(src = "logo.png", height = "70px"),  # Primer logo
      tags$br(),  # Salto de línea
      tags$img(src = "Captura_logo_observatorio_png.png", height = "70px")  # Segundo logo
    ),
    
    sidebarMenu(
      menuItem("Introducción", tabName = "intro"),
      menuItem("Estadísticas Descriptivas", tabName = "estadisticas"),
      menuItem("Indicadores Climáticos", tabName = "indicadores",
               menuItem("Brasil", tabName = "brasil",  # Usar menuItem para el país
                        menuSubItem("Página 1", tabName = "brasil_pag1"),  # Subpáginas
                        menuSubItem("Página 2", tabName = "brasil_pag2")),
               menuItem("Chile", tabName = "chile",
                        menuSubItem("Página 1", tabName = "chile_pag1"),
                        menuSubItem("Página 2", tabName = "chile_pag2")),
               menuItem("Colombia", tabName = "colombia",
                        menuSubItem("Página 1", tabName = "colombia_pag1"),
                        menuSubItem("Página 2", tabName = "colombia_pag2")),
               menuItem("México", tabName = "mexico",
                        menuSubItem("Página 1", tabName = "mexico_pag1"),
                        menuSubItem("Página 2", tabName = "mexico_pag2")),
               menuItem("Uruguay", tabName = "uruguay",
                        menuSubItem("Página 1", tabName = "uruguay_pag1"),
                        menuSubItem("Página 2", tabName = "uruguay_pag2"))),
      menuItem("Glosario", tabName = "glosario")
    )
  ),
  
  dashboardBody(
    # Estilos personalizados y contenido
    tags$head(tags$style(HTML("
      .compact-info-box {
        margin-bottom: 0.1em !important; /* Reducir espacio entre infoBox */
      }
      .compact-column {
        padding-left: 0.1em !important; /* Reducir espacio entre columnas */
        padding-right: 0.1em !important;
      }
      .compact-box {
        margin-bottom: 0.1em !important; /* Reducir espacio entre cajas */
        padding: 0.1em !important;
      }
      
      .intro-text {
        font-size: 1.0vw;
        text-align: justify;
      }
      
      .skin-blue .main-header .navbar {
        background-color: #004d47 !important;
      }
      .skin-blue .main-header .logo {
        background-color: #004d47 !important;
      }
      
      .info-box {
        background-color: white !important;
        border: 1px solid #ddd !important;
        color: black !important;
        text-transform: none !important;
      }
      .info-box .info-box-text {
        font-size: 18px !important;
        color: black !important;
        text-transform: none !important;
      }
      .info-box .info-box-number {
        font-size: 25px !important;
        font-weight: bold;
        color: black !important;
        text-transform: none !important;
      }
      .info-box-icon {
        color: black !important;
        font-size: 40px !important;
        text-transform: none !important;
      }
    "))),
    
    tabItems(
      # Introducción
      tabItem(tabName = "intro",
              box(width = 14,
                  h2(""),
                  p(class = "intro-text", "El Observatorio de Desarrollo Sostenible (ODS) de la Fundación Universitaria Los Libertadores (FULL) se enfoca en investigar el desarrollo sostenible, especialmente en el contexto del cambio climático. Hemos creado un dashboard interactivo que permite visualizar la evolución climática de Colombia (CO) en comparación con otros países de América Latina, como Chile (CI), Brasil (BR), Uruguay (UY) y México (MX) entre 2021 hasta 2023. Mediante indicadores clave como temperatura y precipitaciones, la herramienta busca concientizar sobre la urgencia de abordar los desafíos climáticos. Además, facilita el análisis y fomenta la colaboración regional para formular políticas efectivas y promover un futuro sostenible compartido.")
              ),
              
              fluidRow(
                column(width = 3, class = "compact-column",
                       tags$div(class = "compact-info-box",
                                infoBox("Estaciones en Brasil", 793, icon = icon("compass"), color = "olive", width = 12)
                       ),
                       tags$div(class = "compact-info-box",
                                infoBox("Estaciones en Chile", 65, icon = icon("compass"), color = "olive", width = 12)
                       ),
                       tags$div(class = "compact-info-box",
                                infoBox("Estaciones en Colombia", 47, icon = icon("compass"), color = "olive", width = 12)
                       ),
                       tags$div(class = "compact-info-box",
                                infoBox("Estaciones en México", 138, icon = icon("compass"), color = "olive", width = 12)
                       ),
                       tags$div(class = "compact-info-box",
                                infoBox("Estaciones en Uruguay", 22, icon = icon("compass"), color = "olive", width = 12)
                       )
                ),
                
                column(width = 3, class = "compact-column",
                       tags$div(class = "compact-info-box",
                                infoBox("Cobertura (Estados)", 27, icon = icon("thermometer-half"), color = "olive", width = 12)
                       ),
                       tags$div(class = "compact-info-box",
                                infoBox("Cobertura (Regiones)", 16, icon = icon("thermometer-half"), color = "olive", width = 12)
                       ),
                       tags$div(class = "compact-info-box",
                                infoBox("Cobertura (Departamentos)", 31, icon = icon("thermometer-half"), color = "olive", width = 12)
                       ),
                       tags$div(class = "compact-info-box",
                                infoBox("Cobertura (Estados)", 32, icon = icon("thermometer-half"), color = "olive", width = 12)
                       ),
                       tags$div(class = "compact-info-box",
                                infoBox("Cobertura (Departamentos)", 17, icon = icon("thermometer-half"), color = "olive", width = 12)
                       )
                ),
                
                column(width = 6, class = "compact-column",
                       box(title = "Evolución de la Temperatura (C°) por semestre entre países", width = 12, class = "compact-box",
                           plotlyOutput("scatter_plot", height = "460px")
                       )
                )
              )
      ),
      
      # Estadísticas Descriptivas
      tabItem(tabName = "estadisticas",
              fluidRow(
                box(width = 12,
                    h2("Estadísticas Descriptivas"),
                    DTOutput("tabla_estadisticas")  # Tabla interactiva con DT
                )
              )
      ),
      
      # Indicadores Climáticos
      tabItem(tabName = "brasil_pag1", h2("Brasil - Página 1")),
      tabItem(tabName = "brasil_pag2", h2("Brasil - Página 2")),
      tabItem(tabName = "chile_pag1", h2("Chile - Página 1")),
      tabItem(tabName = "chile_pag2", h2("Chile - Página 2")),
      tabItem(tabName = "colombia_pag1", h2("Colombia - Página 1")),
      tabItem(tabName = "colombia_pag2", h2("Colombia - Página 2")),
      tabItem(tabName = "mexico_pag1", h2("México - Página 1")),
      tabItem(tabName = "mexico_pag2", h2("México - Página 2")),
      tabItem(tabName = "uruguay_pag1", h2("Uruguay - Página 1")),
      tabItem(tabName = "uruguay_pag2", h2("Uruguay - Página 2")),
      
      # Glosario
      tabItem(tabName = "glosario",
              fluidRow(
                box(width = 12,
                    h3("Conceptos Clave"),
                    uiOutput("glosario_text")
                )
              )
      )
    )
  )
)

# Definir servidor
server <- function(input, output, session) {
  
  output$scatter_plot <- renderPlotly({
    # Cargar los datos usando una ruta relativa
    promedios_data1 <- read_excel("Datos/promedios_data1.xlsx")
    
    # Convertir la columna 'semestre' a tipo Date
    promedios_data1 <- promedios_data1 %>%
      mutate(semestre = as.Date(semestre))
    
    # Crear gráfico con ggplot2
    climatePlot <- ggplot(promedios_data1, aes(x = semestre, y = promedio_semestral, 
                                               color = ctry, group = ctry)) +
      geom_line(linewidth = 1) +  # Se usa linewidth en vez de size
      geom_point(size = 2) +  
      scale_color_manual(values = c("BR" = "#00441b", "CI" = "#006d2c", 
                                    "CO" = "#238b45", "MX" = "#41ab5d", 
                                    "UY" = "#74c476")) +  
      labs(title = "",
           x = "Semestre",
           y = "Promedio de Temperatura (°C)",
           color = "País") +
      scale_x_date(date_labels = "%Y - %b", date_breaks = "6 months") + 
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 9),
            axis.text.y = element_text(size = 9),
            axis.title = element_text(size = 10),
            legend.text = element_text(size = 9),
            legend.title = element_text(size = 10))
    
    print(climatePlot)
  })
  
  # Cargar los datos de estadísticas básicas usando una ruta relativa
  estadisticas_basicas <- reactive({
    read_excel("Datos/estadisticas_basicas.xlsx")
  })
  
  # Renderizar la tabla con DT
  output$tabla_estadisticas <- renderDT({
    datatable(estadisticas_basicas(), 
              options = list(pageLength = 12),  # Mostrar 12 filas por página
              rownames = FALSE)  # No mostrar nombres de filas
  })
  
}

# Ejecutar la aplicación
shinyApp(ui = ui, server = server)