
RMDS=check-cube.Rmd sql-for-check-cube.Rmd
MDS=$(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.md/g") 
PDFS=$(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.pdf/g" )
HTMLS=$(shell echo "${RMDS}" | sed -e "s/\.Rmd/\.html/g" )

TARGETS=${MDS} ${PDFS} ${HTMLS}

all: ${TARGETS}

clean:
	rm -f ${TARGETS}

%.pdf: %.Rmd
	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','pdf_document')"

%.pdf: %.Rnw
	$(R_HOME)/bin/Rscript -e "knitr::knit2pdf('$*.Rnw')"

%.md: %.Rmd
	$(R_HOME)/bin/Rscript -e "knitr::knit('$*.Rmd')"

%.html: %.Rmd
	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','html_document')"

