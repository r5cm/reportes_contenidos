# Login a Salesforce
library(RForcecom)
username <- "admin@andes.org"
password <- "admgf2017#XQWRiDpPU6NzJC9Cmm185FF2"
session <- rforcecom.login(username, password)

# Descargar datos de Menu
menu <- rforcecom.getObjectDescription(session, "Menu__c")
menu.campos <- menu$name
menu.campos
menu <- rforcecom.retrieve(session, "Menu__c", menu.campos)

#Eliminar los puntos
menu$Label__c <- gsub(".", "", menu$Label__c, fixed = TRUE)

#Crear vector de puntos
punto <- c(".")

#Combinar columna nombre con vector de puntos
menu$Label__c <- paste(menu$Label__c, punto, sep = "")

#Ingresar a SF con el password token
username <- "admin@andes.org"
password <- "admgf2017#XQWRiDpPU6NzJC9Cmm185FF2"
instanceURL <- "https://taroworks-8629.cloudforce.com/"
apiVersion <- "36.0"
session <- rforcecom.login(username, password, instanceURL, apiVersion)

# run an insert job into the Account object
library(dplyr)
menu.id <- select(menu, Id, Label__c)
job_info <- rforcecom.createBulkJob(session, 
                                    operation='update', 
                                    object='Menu__c')

# split into batch sizes of 500 (2 batches for our 1000 row sample dataset)
batches_info <- rforcecom.createBulkBatch(session, 
                                          jobId=job_info$id, 
                                          menu.id, 
                                          multiBatch = TRUE, 
                                          batchSize=500)

# check on status of each batch
batches_status <- lapply(batches_info, 
                         FUN=function(x){
                               rforcecom.checkBatchStatus(session, 
                                                          jobId=x$jobId, 
                                                          batchId=x$id)
                         })
# get details on each batch
batches_detail <- lapply(batches_info, 
                         FUN=function(x){
                               rforcecom.getBatchDetails(session, 
                                                         jobId=x$jobId, 
                                                         batchId=x$id)
                         })

#Probar que los registros cargaron existosamente
menu.vf <- rforcecom.retrieve(session, "Menu__c", menu.campos)

# Descargar datos de Menu items
menu_items <- rforcecom.getObjectDescription(session, "Menu_Item__c")
menu_items.campos <- menu_items$name
menu_items.campos
menu_items <- rforcecom.retrieve(session, "Menu_Item__c", 
                                 menu_items.campos)

#Eliminar los puntos
menu_items$Label__c <- gsub(".", "", menu_items$Label__c, fixed = TRUE)

#Combinar columna nombre con vector de puntos
menu_items$Label__c <- paste(menu_items$Label__c, punto, sep = "")

#Ingresar a SF con el password token
username <- "admin@andes.org"
password <- "admgf2017#XQWRiDpPU6NzJC9Cmm185FF2"
instanceURL <- "https://taroworks-8629.cloudforce.com/"
apiVersion <- "36.0"
session <- rforcecom.login(username, password, instanceURL, apiVersion)

# run an insert job into the Account object
menu_items.id <- select(menu_items, Id, Label__c)
job_info <- rforcecom.createBulkJob(session, 
                                    operation='update', 
                                    object='Menu_Item__c')

# split into batch sizes of 500 (2 batches for our 1000 row sample dataset)
batches_info <- rforcecom.createBulkBatch(session, 
                                          jobId=job_info$id, 
                                          menu_items.id, 
                                          multiBatch = TRUE, 
                                          batchSize=500)

# check on status of each batch
batches_status <- lapply(batches_info, 
                         FUN=function(x){
                               rforcecom.checkBatchStatus(session, 
                                                          jobId=x$jobId, 
                                                          batchId=x$id)
                         })
# get details on each batch
batches_detail <- lapply(batches_info, 
                         FUN=function(x){
                               rforcecom.getBatchDetails(session, 
                                                         jobId=x$jobId, 
                                                         batchId=x$id)
                         })

menu_items.vf <- rforcecom.retrieve(session, "Menu_Item__c", menu_items.campos)

