#Import data
library(readxl)
df1=read_excel("C:\\Users\\Indrani Sengupta\\OneDrive\\Desktop\\Predictive Analytics\\Pred_Analy_MS235122.xlsx")
str(df1)

#Converting nominal variables to dummy variables
df1$Location=as.factor(df1$Location)

#MLR
model=lm(df1$`Monthly RENT`~df1$Location+df1$`Area of the Room(sqft)`+df1$`Room Sharing`)
summary(model)
#alternative 
model=lm(`Monthly RENT`~ Location +`Area of the Room(sqft)`+`Room Sharing`,data=df1)
summary(model)

#ROOM SHARING has NA values in the Regression Summary because of perfect multicollinearity.
#hence R drops it automatically from the regression  

# since the model has many LOCATION categories, we have overfitting in the model
#we use REGULARISATION to avoid overfitting
library(glmnet)
X=as.matrix(df1[,-1])
y=df1$`Monthly RENT`
set.seed(123)
# elastic
elastic_model = cv.glmnet(X, y, alpha=0.5)
best_lambda = elastic_model$lambda.min #optimal lambda 
final_elastic = glmnet(X, y, alpha=0.5, lambda=best_lambda)
coef(final_elastic)
#ridge
ridge_model <- cv.glmnet(X, y, alpha=0)  
best_lambda <- ridge_model$lambda.min #optimal lambda
final_ridge <- glmnet(X, y, alpha=0, lambda=best_lambda)
coef(final_ridge)
