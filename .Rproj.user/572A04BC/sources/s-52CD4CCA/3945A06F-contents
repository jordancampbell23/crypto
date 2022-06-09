mod_volatility_ui <- function(id) {
    ns <- NS(id)

    tagList(

      fluidRow(
        
        column(4,
               
               div(
                 style = "padding-left: 20px;",
                 align = "left",
                 shinyWidgets::pickerInput(
                   ns("asset"),
                   label = "Select State Plan(s):",
                   choices = unique(coin_hist2$name),
                   options = list(
                     `actions-box` = T,
                     `live-search` = T
                   ),
                   multiple = T,
                   width = "100%",
                   selected = unique(coin_hist2$name)
                 )
               )
        ),
        
        column(4),
        
        column(4,
               div(
                 style = "margin: 10px;",
                 shinyWidgets::chooseSliderSkin("Flat"),
                 shinyWidgets::setSliderColor(c("LightSlateGray", "LightSlateGray"), c(1, 2)),
                 div(
                   style = "margin: 0px",
                   sliderInput(ns("rolling_avg"),
                               label = "Rolling Average:",
                               min = 1,
                               max = 300,
                               post = " days",
                               value = 10,
                               sep = "")
                 ))
        )
      ),
      
      fluidRow(
        style = "margin: 0; height: 46%",
        
        column(
          width = 12,
          style = "height: 100%; padding-top: -30px",
          data_card(
            shinycssloaders::withSpinner(echarts4rOutput(ns("chart_1"), height = "65vh"))
          )
        )
      )
    )
}

mod_volatility_server <- function(id) {
    server <- function(input, output, session) {
        ns <- session$ns

        ##Plot UAL
        output$chart_1 <- renderEcharts4r({
          
          df_daily <- coin_hist2 |>
            select(date, name, close) |>
            filter(name %in% input$asset) |>
            group_by(name) |>
            arrange(date, .by_group = T) |>
            mutate(close=rollapply(close, input$rolling_avg, mean,align='right',fill=NA)) |>
            mutate(pct_change = (close/lead(close) - 1))
          
          df_daily |>
            group_by(name) |>
            e_charts(date) |>
            e_line(pct_change, symbol = "none", lineStyle = list(width = 3)) |>
            e_y_axis(axisLabel = list(fontSize = 14),
                     formatter = echarts4r::e_axis_formatter(style = "percent",
                                                             digits = 0)) |>
            e_theme_custom("echarts_theme.json") |>
            e_tooltip(trigger = "axis", e_tooltip_pointer_formatter(style = "percent", digits = 1)) |>
            e_legend(orient = 'vertical',
                     type = 'scroll',
                     textStyle = list(fontSize = 14),
                     left = "0%",
                     top = "10%",
                     selector = list(
                       list(type = 'inverse', title = 'Invert Selection'),
                       list(type = 'all', title = 'Reset')
                     )) |>
            e_theme_custom("echarts_theme.json") |>
            e_grid(left = "22%")
          
        })
          
          
      
        
    }
    moduleServer(id, server)
}