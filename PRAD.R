#PRAD
clin <- GDCquery_clinic("TCGA-PRAD", type = "clinical", save.csv = TRUE)
sub_clin <- subset(clin, select = c("submitter_id", 
                                    "gender", "age_at_index", "race", "ethnicity", 
                                    "cigarettes_per_day", "years_smoked","alcohol_history", 
                                    "alcohol_intensity"))

#Somatic Mutations:
query1 <- GDCquery( project = "TCGA-PRAD", 
                    data.category = "Simple Nucleotide Variation", 
                    data.type = "Masked Somatic Mutation", legacy=F)

GDCdownload(query1)

muts <- GDCprepare(query1)

muts <- subset(muts, select = c( "Hugo_Symbol", "Chromosome", "Start_Position", 
                                 "End_Position", "Variant_Classification",
                                 "Variant_Type", "Tumor_Sample_Barcode", "Matched_Norm_Sample_Barcode",
                                 "Mutation_Status", "HGVSp"))


muts$submitter_id <- substr(muts$Tumor_Sample_Barcode, 1, 12)

mut_data <- merge(muts, sub_clin, by = "submitter_id", all = T)

mut_data$cancer_level <- NA

mut_data <- mut_data[, c(1,2,3,4,5,6,7,8,9,10,11,20,12,13,14,15,16,17,18,19)]

names(mut_data)[1] <- 'sample_id'
names(mut_data)[2] <- 'GeneSymbol'

write.csv(mut_data,"PRAD_Mut.csv")
