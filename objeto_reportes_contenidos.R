# DESCARGAR INFORMACIÓN DE OBJETOS ----------------------------------------

# Login a Salesforce
library(RForcecom)
username <- readline(prompt = "Enter username: ")
password <- readline(prompt = "Enter password: ")
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

# Contar registros con caracteres especiales
table(grepl("\UFFFD", search_log$Query__c))

# Crear lista con forma correcta e incorrecta
correctas <- read.csv("palabras_correctas.csv")

# Primera corrección: Utilizar lista anterior para corregir queries
search_log$Query__c <- gsub("�", "<U+FFFD>", search_log$Query__c)

for (i in 1:nrow(search_log)) {
      for(j in 1:nrow(correctas)) {
            search_log$Query__c[i] <- gsub(correctas[j, 1],
                                           correctas[j, 2],
                                           search_log$Query__c[i],
                                           fixed = TRUE)
      }
}

# Segunda corrección: corregir las que quedaron mal




# Separar queries en columnas ---------------------------------------------

# Crear lista con menus y menu items (e identificador de objeto)
temas <- rbind(data.frame(tipo = rep("Menu", nrow(menu)), 
                          tema = menu$Label__c),
               data.frame(tipo = rep("Menu item", nrow(menu_item)),
                          tema = menu_item$Label__c))

# Ordenar temas en niveles
nivel <- ifelse(temas$tipo == "Menu", 0,
                )

# Crear lista de temas únicos, para utilizar en regexpr
temas.unicos <- unique(temas$tema)

x <- vector(mode = "list", length = nrow(search_log))

for (i in seq_along(search_log$Query__c)) {
      for(j in seq_along(temas.unicos)) {         
            if(grepl(temas.unicos[j], search_log$Query__c[i])) {
                  x[[i]][[length(x[[i]]) + 1]] <- temas.unicos[j]
            }
      }
}

# ESTO HAY QUE REVISARLO BIEN PORQUE EL PRIMER QUERY ESTÁ DANDO
# DIFERENTE AL PRIMER ELEMENTO DE LA LISTA



# Guardar objetos
saveRDS(correctas, "correctas.rds")
saveRDS(menu, "menu.rds")
saveRDS(menu_item, "menu_item.rds")
saveRDS(queries, "queries.rds")
saveRDS(search_log, "search_log.rds")
saveRDS(temas, "temas.rds")

# Cargar objetos
correctas <- readRDS("correctas.rds")
menu <- readRDS("menu.rds")
menu_item <- readRDS("menu_item.rds")
queries <- readRDS("queries.rds")
search_log <- readRDS("search_log.rds")
temas <- readRDS("temas.rds")





