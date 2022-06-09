server <- function(input, output, session) {
    mod_comm <- reactiveValues(
        app_data = NULL
    )

    mod_volatility_server("volatility")
    # mod_data_server("data", mod_comm)


}