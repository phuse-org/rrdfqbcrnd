RMDS= CubeStructureMetaDataFigures.Rmd

# List of files with .md extension
MDS= $(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.md/g" ) 
PDFS= $(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.pdf/g" )
HTMLS= $(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.html/g" ) 


# FORDOC= ${HTMLS} ${MDS} ${PDFS}
FORDOC= ${HTMLS}

TARGETS=${FORDOC} 

RMD2HTML=$(R_HOME)/bin/Rscript -e "rmarkdown::render('$<','all')"

all: ${TARGETS} ${FORDOC} cleantemp

clean: 
	rm -f ${TARGETS} highlight.css;
	cd ../doc; rm -rf ${FORDOC} 

cleantemp:

installDoc:
	# mkdir -p ../doc/figure
	cp ${FORDOC} ../doc
	# cp figure/* ../doc/figure

CubeStructureMetaDataFigures.html: CubeStructureMetaDataFigures.Rmd
	${RMD2HTML}

