
TARGETS=first-cube.md howto-create-vignette.md

all: ${TARGETS}

clean:
	rm -f ${TARGETS}

%.pdf: %.Rnw
	$(R_HOME)/bin/Rscript -e "knitr::knit2pdf('$*.Rnw')"

# not clever rule - also creates HTML version
# disabled 2015-09-22 MJA - does not work
# %.pdf: %.Rmd
# 	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','pdf_document')"

%.md: %.Rmd
	$(R_HOME)/bin/Rscript -e "knitr::knit('$*.Rmd')"

%.html: %.Rmd
	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','html_document')"

