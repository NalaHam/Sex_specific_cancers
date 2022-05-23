BRCA_Mut$Project <- "TCGA-BRAC"
CESC_Mut$Project <- "TCGA-CESC"
OV_Mut$Project <- "TCGA-OV"
PRAD_Mut$Project <- "TCGA-PRAD"
TGCT_Mut$Project <- "TCGA-TGCT"
UCS_Mut$Project <- "TCGA-UCS"
UCEC_Mut$Project <- "TCGA-UCEC"

sex_cancers <- rbind(BRCA_Mut, CESC_Mut, OV_Mut, PRAD_Mut, TGCT_Mut, UCS_Mut, UCEC_Mut ) #combine mut data

sex_cancers <- subset(sex_cancers, select = -X)

sex_cancers <- sex_cancers[, c(21,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)] #reorder so that project is first column

write.csv(sex_cancers,"sex_cancers.csv")

sex_cancers$Project <- sub('AC', 'CA', sex_cancers$Project) #fix line 1 mistake

unique(sex_cancers$Project)
