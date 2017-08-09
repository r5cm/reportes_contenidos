# DESCARGAR INFORMACIÓN DE OBJETOS ----------------------------------------

# Login a Salesforce
library(RForcecom)
username <- "admin@andes.org"
password <- "admgf2017#XQWRiDpPU6NzJC9Cmm185FF2"
instanceURL <- "https://taroworks-8629.cloudforce.com/"
apiVersion <- "36.0"
session <- rforcecom.login(username, password, instanceURL, apiVersion)

# Información de objetos de contenidos
objetosCont <- c("Menu__c", "Menu_item__c", "Search_log__c")
num.objetosCont <- length(objetosCont)

for(i in 1:num.objetosCont) {
      assign(paste("md.", objetosCont[i], sep = ""),
             rforcecom.getObjectDescription(session, objetosCont[i]))
}

# Datos de objetos de contenidos
menu <- rforcecom.retrieve(session, objetosCont[1], md.Menu__c$name)
menu_item <- rforcecom.retrieve(session, objetosCont[2], md.Menu_item__c$name)
search_log <- rforcecom.retrieve(session, objetosCont[3], md.Search_log__c$name)




# Corregir queries con caracteres especiales ------------------------------


# Eliminar el punto de todos los menus y menu items
menu$Label__c <- gsub(".", "", menu$Label__c, fixed = TRUE)
menu_item$Label__c <- gsub(".", "", menu_item$Label__c, fixed = TRUE)

# Crear lista con menus y menu items
temas <- c(menu$Label__c, menu_item$Label__c)

# Contar registros con caracteres especiales
table(grepl("\uFFFD", search_log$Query__c))

# Crear lista con forma correcta e incorrecta
correctas <- read.csv("palabras_correctas.csv")

# Utilizar lista anterior para corregir queries
search_log$Query__c <- gsub("�", "<U+FFFD>", search_log$Query__c)

for (i in 1:nrow(search_log)) {
      for(j in 1:nrow(correctas)) {
            search_log$Query__c[i] <- gsub(correctas[j, 1],
                                           correctas[j, 2],
                                           search_log$Query__c[i],
                                           fixed = TRUE)
      }
}



# Separar queries en columnas ---------------------------------------------

x <- vector(mode = "list", length = nrow(search_log))
temas.unicos <- unique(temas)

for (i in seq_along(search_log$Query__c)) {
      for(j in seq_along(temas.unicos)) {         
            if(grepl(temas.unicos[j], search_log$Query__c[i])) {
                  x[[i]][[length(x[[i]]) + 1]] <- temas.unicos[j]
            }
      }
}

# ESTO HAY QUE REVISARLO BIEN PORQUE EL PRIMER QUERY ESTÁ DANDO
# DIFERENTE AL PRIMER ELEMENTO DE LA LISTA

i <- 1
j <- 190






