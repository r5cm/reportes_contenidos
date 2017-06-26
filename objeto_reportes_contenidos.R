
# ARREGLAR DATOS SIN DELIMITADOR ----------------------------------------------------


# Descargar queries de Salesforce

## Login a Salesforce
library(RForcecom)
username <- "admin@andes.org"
password <- "admgf2017*XQWRiDpPU6NzJC9Cmm185FF2"
instanceURL <- "https://taroworks-8629.cloudforce.com/"
apiVersion <- "36.0"
session <- rforcecom.login(username, password, instanceURL, apiVersion)

## Descargar datos
fields <- c("Id", "Query__c")
queries.1 <- rforcecom.retrieve(session, "Search_Log__c", fields)



# INCLUIR DELIMITADORES EN CONTENIDOS SUBIDOS ---------------------------------------



# Incluir separador de niveles en queries



# Descargar Contenidos


# Agregar sperador al final de todos los registros (menos último nivel)