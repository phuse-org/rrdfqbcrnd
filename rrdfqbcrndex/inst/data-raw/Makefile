RMDS= populate-sample-xpt.Rmd  create-ADSL-ttl.Rmd create-ADAE-ttl.Rmd \
create-ae-table-as-csv.Rmd  create-dm-table-as-csv.Rmd \
create-qb-examples-as-ttl.Rmd \
use-demo-ttl.Rmd  \
using-arq.Rmd using-arq-graphical-display.Rmd using-arq-qb.Rmd \
rdf-gotchas.Rmd \
SPARQL-scripts-for-qb.Rmd \
using-python.Rmd \
overview-prefixes-for-SPARQL.Rmd \
using-NoSPA-RDF-Data-Cube-Validator.Rmd


# does not work package-overview.Rmd
# does not work reporting-process.Rmd 

# List of files with .md extension
MDS= $(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.md/g" ) 
PDFS= $(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.pdf/g" )
HTMLS= $(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.html/g" ) reporting-process.html

ADSLTTL=../extdata/sample-rdf/adsl-map.ttl ../extdata/sample-rdf/adsl.ttl
ADAETTL=../extdata/sample-rdf/adae-map.ttl ../extdata/sample-rdf/adae.ttl
QBTTLS=../extdata/sample-rdf/DC-AE-sample.ttl ../extdata/sample-rdf/DC-DM-sample.ttl ../extdata/sample-rdf/DC-DEMO-sample.ttl

TTLS=${ADSLTTL} ${ADAETTL} ${QBTTLS}

ADAEXPT=../extdata/sample-xpt/adae.xpt
ADSLXPT=../extdata/sample-xpt/adsl.xpt

CSVAE=../extdata/sample-cfg/ae.aedecod.AR.csv ../extdata/sample-cfg/ae.aesoc.AR.csv ../extdata/sample-cfg/ae.AR.csv
CSVDM=../extdata/sample-cfg/dm.AR.csv
CSVDEMO=../extdata/sample-cfg/demo.AR.csv ../extdata/sample-cfg/DEMO-Components.csv

XPTS= ${ADAEXPT} ${ADDMXPT}

# ${CSVDEMO} is created by a SAS program outside the makefile

CSVS= ${CSVAE} ${CSVDM} 


FORDOC= ${HTMLS} ${MDS} ${PDFS}

TARGETS=${XPTS} ${TTLS} ${CSVS} ${FORDOC} 

RMD2HTML=$(R_HOME)/bin/Rscript -e "rmarkdown::render('$<','all')"

all: ${TARGETS} ${FORDOC} cleantemp

clean: 
	rm -f ${TARGETS} highlight.css;
	cd ../doc; rm -rf ${FORDOC} 

cleantemp:
	rm -f ../extdata/sample-rdf/fordot.ttl ../extdata/sample-rdf/fordot.dot
	rm -f ../extdata/sample-rdf/graph.png  ../extdata/sample-rdf/graph.pdf

ds-ttl: ${ADSLTTL} ${ADAETTL}

qb-ttl: ${QBTTLS}

installDoc:
	mkdir -p ../doc/figure
	cp ${FORDOC} ../doc
	cp figure/* ../doc/figure

${ADAEXPT} ${ADSLXPT} populate-sample-xpt.html populate-sample-xpt.pdf populate-sample-xpt.md: populate-sample-xpt.Rmd
	${RMD2HTML}

${ADSLTTL} create-ADSL-ttl.html create-ADSL-ttl.pdf create-ADSL-ttl.md: create-ADSL-ttl.Rmd ${ADSLXPT}
	${RMD2HTML}

${ADAETTL} create-ADAE-ttl.html create-ADAE-ttl.pdf create-ADAE-ttl.md: create-ADAE-ttl.Rmd ${ADAEXPT}
	${RMD2HTML}

${CSVAE} create-ae-table-as-csv.html create-ae-table-as-csv.pdf create-ae-table-as-csv.md: create-ae-table-as-csv.Rmd ${ADAEXPT} 
	${RMD2HTML}

${CSVDM} create-dm-table-as-csv.html create-dm-table-as-csv.pdf create-dm-table-as-csv.md: create-dm-table-as-csv.Rmd
	${RMD2HTML}

${CSVDEMO}:

${QBTTLS} create-qb-examples-as-ttl.html create-qb-examples-as-ttl.pdf create-qb-examples-as-ttl.md: create-qb-examples-as-ttl.Rmd ${CSVAE} ${CSVDM} ${CSVDEMO}
	${RMD2HTML}

use-demo-ttl.html use-demo-ttl.pdf use-demo-ttl.md: use-demo-ttl.Rmd 
	${RMD2HTML}

using-arq.html using-arq.pdf using-arq.md: using-arq.Rmd 
	${RMD2HTML}

using-arq-graphical-display.html using-arq-graphical-display.pdf using-arq-graphical-display.md: using-arq-graphical-display.Rmd
	${RMD2HTML}
	rm -r -f using-arq-graphical-display_cache using-arq-graphical-display_files fordot.ttl fordot.dot

using-arq-qb.html using-arq-qb.pdf using-arq-qb.md: using-arq-qb.Rmd
	${RMD2HTML}

using-python.html using-python.pdf using-python.md: using-python.Rmd
	${RMD2HTML}

# no pdf
reporting-process.pdf:

reporting-process.html  reporting-process.md: reporting-process.Rmd
#	${RMD2HTML}
	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$<')"

package-overview.html package-overview.pdf package-overview.md: package-overview.Rmd
	${RMD2HTML}

rdf-gotchas.html rdf-gotchas.pdf rdf-gotchas.md: rdf-gotchas.Rmd
	${RMD2HTML}

SPARQL-scripts-for-qb.html SPARQL-scripts-for-qb.pdf SPARQL-scripts-for-qb.md: SPARQL-scripts-for-qb.Rmd
	${RMD2HTML}

things-to-note.html: things-to-note.Rmd
	${RMD2HTML}

overview-prefixes-for-SPARQL.html: overview-prefixes-for-SPARQL.Rmd
	${RMD2HTML}

using-visNetwork.html: using-visNetwork.Rmd
	${RMD2HTML}

using-NoSPA-RDF-Data-Cube-Validator.html: using-NoSPA-RDF-Data-Cube-Validator.Rmd
	${RMD2HTML}

