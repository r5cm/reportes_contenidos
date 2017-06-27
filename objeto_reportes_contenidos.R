# DESCARGAR INFORMACIÓN DE OBJETOS ----------------------------------------

## Login a Salesforce
library(RForcecom)
username <- "admin@andes.org"
password <- "admgf2017*XQWRiDpPU6NzJC9Cmm185FF2"
instanceURL <- "https://taroworks-8629.cloudforce.com/"
apiVersion <- "36.0"
session <- rforcecom.login(username, password, instanceURL, apiVersion)

## Información de objetos de contenidos
objetosCont <- c("Menu__c", "Menu_item__c", "Search_log__c")
num.objetosCont <- length(objetosCont)

for(i in 1:num.objetosCont) {
  assign(objetosCont[i], 
         rforcecom.getObjectDescription(session, objetosCont[i]))
}

## Datos de objetos
# Menu y menu items: https://taroworks-8629.cloudforce.com/00O36000007E0d8


# INCLUIR DELIMITADOR EN QUERIES EXISTENTES -------------------------------


## Descargar queries
fields <- c("Id", "Query__c")
queries.1 <- rforcecom.retrieve(session, "Search_Log__c", fields)

## Descargar contenidos


# SEPARAR NIVELES Y SUBIR A NUEVO OBJETO ----------------------------------


