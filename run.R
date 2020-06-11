setwd("/home/isin/Undergrad/Spring20/ekoloji/PopulasyonBuyumesi")

library(shiny)
library(devtools)
library(rsconnect)

runApp("SimuleEt")
runApp("SimuleEt", display.mode = "showcase")

rsconnect::setAccountInfo(name='isinaltinkaya',
                          token='E76733D03F7916D89BE416209D7D9022',
                          secret='E8b2lcAzSC0FeMMxqMnoXgN569w+SaSQsPZGUNkr')

deployApp("SimuleEt")