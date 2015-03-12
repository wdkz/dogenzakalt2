#rf_titanic
dat <- read.csv("../../data/titanic3.1.csv")
dat$survived <- as.factor(dat$survived)
dat$sex <- as.factor(dat$sex)
dat$pclass <- as.factor(dat$pclass)
dat$sibsp <- as.factor(dat$sibsp)
dat$parch <- as.factor(dat$parch)
dat$embarked <- as.factor(dat$embarked)
library(randomForest)
rf_mdl <- randomForest(survived ~ sex + pclass + age + sibsp + parch + embarked, dat,na.action = na.omit)
rf_mdl$confusion
varImpPlot(rf_mdl)
