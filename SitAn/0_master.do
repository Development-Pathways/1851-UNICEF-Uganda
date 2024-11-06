*** This is the master do file of the UCLDS2019

** This will run all necessary do files to clean the raw data and construct
** variables

cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/"

* 1 - Run the hhid.do file which creates unique household id across listing and extended data tempfiles
run "scripts/hhid.do"

* 2 - Run the listing.do file which cleans the roster and listing datafiles from the screening questionnaire
run "scripts/listing.do"

* 3 - Run the extended.do file which cleans the roster and datafiles from the extended questionnaire
run "scripts/extended.do"

* 4 - Combine listing and extended datasets
run "scripts/uclds2019.do"
