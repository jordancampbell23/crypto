library(shiny)
library(shinyBS)
library(shinyWidgets)
library(echarts4r)
library(tidyverse)
library(reactable)
library(shinycssloaders)
library(readr)
library(zoo)

#-------------------------------Data Prep----------------------------------------
coin_hist2 <- read_csv("data/coin_hist2.csv") |>
  as.data.frame() |>
  select(-timestamp)

#---------------------------FUNCTIONS & SETTINGS--------------------------------
options(spinner.color = "#ff6633", spinner.size = 1, spinner.type = 8)
source("utilities/utilities.R")

#--------------------------------MODULES----------------------------------------
source("modules/mod_volatility.R")

