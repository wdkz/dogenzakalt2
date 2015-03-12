#h2o.glm_airline

library(h2o)
localH2O = h2o.init( ip = "localhost", port = 54321, max_mem_size = "1g", beta = TRUE)
path <- "../../data/allyears2k.csv"
airline <- read.csv(path)
airline$Cancelled <- as.factor(airline$Cancelled)
airline$Year <- as.factor(airline$Year)
airline$Month <- as.factor(airline$Month)
airline$DayOfWeek <- as.factor(airline$DayOfWeek)

data.hex <- as.h2o(localH2O, object = airline, key="airline")
#data.hex <- h2o.uploadFile(localH2O, 
#                           path,
#                           key="airline")
#data.hex = h2o.importFile(localH2O, 
#                          path = "../../data/allyears2k.csv"
#                          )
#
xvars <- unlist( strsplit( c("Year", "Month", "DayOfWeek","Origin", "Dest", "UniqueCarrier", "Distance"), split = ',' , fixed = TRUE ) )
data.glm <- h2o.glm(x = xvars , y = "Cancelled", data = data.hex,
                   family = "binomial", nfolds = 0, standardize=TRUE, key = 'data.glm')
data.glm@model$confusion
data.rf <- h2o.randomForest(x = xvars,
                            y="Cancelled",
                            data = data.hex,
                            ntree = 500
                            )
#
air_dl <- h2o.deeplearning(x      = xvars, 
                           y      = "Cancelled",
                           data   = data.hex,
                           hidden = c(100, 100, 100, 100, 100, 100, 100),
                           variable_importances = TRUE)
par(mai=c(0.5,2.0,0.5,0.5))
barplot(sort(unlist(c(air_dl@model$varimp[1:10]))), horiz = TRUE, las=1)
library(gridExtra)
grid.table(air_dl@model$confusion)

options(scipen=4); options(digits=4)
library(gridExtra)
grid.table(summary(glm(Species ~ ., iris[1:100,], family="binomial"))$coef)

