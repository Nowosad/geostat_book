wiosna <- read.csv("data/Wolin_TPZ_wiosna_pop.csv")
tablica <- unique(wiosna[c(7,8)])
tablica

replacer <- function(df, second_var, tablica){
    for (value in tablica[, "CLC06"]){
        df[, second_var][df[, "CLC06"] == value] <- tablica[tablica$CLC06== value, ][,2]
    }
    return(df)
}

lato <- read.csv("data/Wolin_TPZ_p_lato_pop.csv")
lato2 <- replacer(df=lato, second_var = "CLC06_pLato", tablica)

lato_los <- read.csv("data/Wolin_TPZ_p_lato_750los.csv")
lato_los2 <- replacer(df=lato_los, second_var = "CLC06_p_lato", tablica)

lato_pref <- read.csv("data/Wolin_TPZ_p_lato_754pref.csv")
lato_pref2 <- replacer(df=lato_pref, second_var = "CLC06_p_lato", tablica)

write.csv(lato2, file="data/Wolin_TPZ_p_lato_popN.csv", row.names = FALSE)
write.csv(lato_los2, file="data/Wolin_TPZ_p_lato_750losN.csv", row.names = FALSE)
write.csv(lato_pref2, file="data/Wolin_TPZ_p_lato_754prefN.csv", row.names = FALSE)