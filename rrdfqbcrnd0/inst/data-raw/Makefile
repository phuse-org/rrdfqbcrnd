
HTMLS= codelist-procedure.html

# not possible directly from .Rmd PDFS=reporting-process.pdf

# List of files with .md extension
MDS= $(shell echo "${HTMLS}" | sed -e "s/\.html/\.md/g" )


FORDOC= ${HTMLS} ${MDS} ${PDFS}

TARGETS= ${FORDOC}

RKNIT2HTML=$(R_HOME)/bin/Rscript -e "knitr::knit2html('$<')"
RKNIT2PDF=$(R_HOME)/bin/Rscript -e "knitr::knit2pdf('$<')"
RKNIT2MD=$(R_HOME)/bin/Rscript -e "knitr::knit('$<')"

RMD2HTML=$(R_HOME)/bin/Rscript -e "rmarkdown::render('$<','all')"


all: ${TARGETS}

clean: 
	rm -f ${TARGETS} 
	cd ../doc; rm -f ${FORDOC}

installDoc:
	mkdir -p ../doc/figure
	cp ${FORDOC} ../doc
	cp figure/* ../doc/figure

codelist-procedure.html codelist-procedure.pdf codelist-procedure.md: codelist-procedure.Rmd 
	${RMD2HTML}

# %.pdf: %.Rnw
# 	${RKNIT2PDF}
#
# %.html: %.Rmd
#	${RKNIT2HTML}

# # not clever rule - also creates HTML version
# %.pdf: %.Rmd
#	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','pdf_document')"
#	mv -f $*.pdf ../doc

# %.html: %.Rmd
# 	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','html_document')"
# 	mv -f $*.html ../doc
