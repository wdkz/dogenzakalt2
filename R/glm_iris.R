#glm_iris
dat <- read.csv("../../data/iris.csv")
library(caret)
glm_mdl <- train(x      = dat[51:150,3:6], 
                 y      = droplevels(dat[51:150,2]), 
                 method = "glm", 
                 family = "binomial")
varImp(glm_mdl)
summary(glm_mdl)

library(VGAM)
vglm_mdl <- vglm(Species ~ ., data=dat[,-1], family="multinomial")
vglm_mdl
