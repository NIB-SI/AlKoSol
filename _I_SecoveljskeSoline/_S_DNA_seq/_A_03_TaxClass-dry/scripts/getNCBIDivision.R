# Script for fetching NCBI Taxonomy division for a species name list 

install.packages("rentrez")

# Load the rentrez package
library(rentrez)

# List of species
species_list <- c(
  "Dunaliella salina", "Halorubrum sp. TP009", "Halorubrum lacusprofundi", 
  "Halanaerobacter jeridensis", "Halorubrum coriense", "Halorubrum sp. TP023",
  "Halorubrum trapanicum", "Halorubrum sp.", "uncultured Halobacteria archaeon",
  "Spiribacter curvatus", "Haloarcula hispanica", "Haloarcula taiwanensis",
  "Halomicrobium mukohataei", "Prosthecochloris sp. CIB 2401", "Halalkalicoccus jeotgali",
  "Halobacterium hubeiense", "Haloferax gibbonsii", "Haloquadratum walsbyi",
  "Haloarcula marismortui", "Halobacteriaceae archaeon ZS 5", "Halopenitus persicus",
  "Natronomonas pharaonis", "Halobacteroides halobius", "Hydrogenovibrio crunogenus",
  "Haloplanus natans", "uncultured haloarchaeon", "Acetohalobium arabaticum",
  "Natronomonas moolapensis", "Salinigranum sp.", "Halogeometricum borinquense",
  "Halobacterium salinarum", "Halomicroarcula sp.", "halophilic archaeon DL31",
  "uncultured Firmicutes bacterium", "Salinigranum rubrum", "Natronobacterium gregoryi",
  "Haloplanus salinus", "Halobacterium sp. GN101", "Natrinema pellirubrum",
  "Halobiforma lacisalsi", "Halopiger xanaduensis", "Haloarcula sp. CBA1115",
  "Salinarchaeum sp. Harcht Bsk1", "Haloterrigena turkmenica", "Halobacterium sp. DL1",
  "Natrinema sp. J7 2", "Rhodovulum sp. JZ3A21", "Haloferax volcanii",
  "Halorientalis sp. IM1011", "Natrialba magadii", "Haloferax mediterranei",
  "Spiribacter salinus", "Robiginitalea biformata", "Halorhabdus tiamatea",
  "uncultured euryarchaeote", "Sphingopyxis macrogoltabida", "uncultured archaeon",
  "Sagittula sp. P11", "Leisingera methylohalidivorans", "Celeribacter manganoxidans",
  "Pelagibaca abyssi", "Rhodovulum sp. P5", "Thioclava nitratireducens",
  "Dinoroseobacter shibae", "Celeribacter indicus", "Ruegeria sp. TM1040",
  "Marinovum algicola", "Sulfitobacter sp. AM1 D1", "Phaeobacter porticola",
  "Confluentimicrobium sp. EMB200 NS6", "Phaeobacter piscinae", "Rhodobacteraceae bacterium",
  "Nonlabens dokdonensis", "Epibacterium mobile", "uncultured marine bacterium",
  "Tateyamaria omphalii", "Endozoicomonas montiporae", "Roseobacter denitrificans",
  "Rhodovulum sp. SMB1", "Phaeobacter inhibens", "Roseobacter litoralis",
  "Ruegeria sp. PR1b", "Rhodopirellula baltica", "Halocynthiibacter arcticus",
  "Sulfitobacter pseudonitzschiae", "Candidatus Fluviicola riflensis",
  "Fistulifera solaris", "Gomphoneis minuta", "Bernardetia litoralis",
  "Nonlabens sp. Hel1_33_55", "Maribacter sp. 1 2014MBL MicDiv",
  "Cylindrotheca closterium", "Thalassiosira oceanica", "Solanum pennellii",
  "Paraburkholderia xenovorans", "Kryptoperidinium foliaceum", "Asterionellopsis glacialis",
  "Candidatus Amoebophilus asiaticus", "Asterionella formosa", "uncultured diatom",
  "Marivirga tractuosa", "uncultured phototrophic eukaryote", "Polaribacter reichenbachii",
  "uncultured eukaryote", "Alteromonas sp. MB 3u 76", "Lotharella oceanica",
  "Ulnaria acus", "uncultured fungus", "uncultured Verrucomicrobiales bacterium HF0010 05E02",
  "uncultured marine eukaryote"
)



# Function to fetch the full division data
fetch_full_lineage <- function(species_name) {
  search_result <- entrez_search(db = "taxonomy", term = species_name)
  if (length(search_result$ids) > 0) {
    tax_id <- search_result$ids[1]
    tax_data <- entrez_summary(db = "taxonomy", id = tax_id)
    if (!is.null(tax_data$division)) {
      division <- tax_data$division
      return(division)
    } else {
      return("N/A")
    }
  } else {
    return("N/A")
  }
}

# Create an empty dataframe to store results
taxonomy_data <- data.frame(Species = character(), division = character(), stringsAsFactors = FALSE)

# Iterate through the species list and fetch full division data
for (species in species_list) {
  division_info <- fetch_full_lineage(species)
  taxonomy_data <- rbind(taxonomy_data, data.frame(Species = species, division = division_info, stringsAsFactors = FALSE))
}

# Print the results
print(taxonomy_data)
