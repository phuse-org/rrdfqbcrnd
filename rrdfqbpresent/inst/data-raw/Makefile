
HTMLS=two-dim-representation-of-cube.html

# List of files with .md extension
MDS= $(shell echo "${HTMLS}" | sed -e "s/\.html/\.md/g" )
PDFS= $(shell echo "${HTMLS}" | sed -e "s/\.html/\.pdf/g" )


FORDOC= ${HTMLS} ${MDS} ${PDFS}

TARGETS=${FORDOC}

RMD2HTML=$(R_HOME)/bin/Rscript -e "rmarkdown::render('$<','all')"


all: ${TARGETS} cleantemp

clean: 
	rm -f ${TARGETS}

cleantemp:
	rm -f ../extdata/sample-rdf/fordot.ttl ../extdata/sample-rdf/fordot.dot
	rm -f ../extdata/sample-rdf/graph.png  ../extdata/sample-rdf/graph.pdf

installDoc:
	# mkdir -p ../doc/figure
	cp ${FORDOC} ../doc
	# cp figure/* ../doc/figure


two-dim-representation-of-cube.html two-dim-representation-of-cube.pdf two-dim-representation-of-cube.md: two-dim-representation-of-cube.Rmd
	${RMD2HTML}
