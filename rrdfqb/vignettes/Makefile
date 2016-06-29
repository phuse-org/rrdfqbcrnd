
TARGETS=check-ic.html check-ic.md \
explore-cube-vocabulary.html explore-cube-vocabulary.md \
qb-sparql-queries.html qb-sparql-queries.md

all:  ${TARGETS}

clean:
	rm -f ${TARGETS}

# not clever rule - also creates HTML version
# disabled 2015-09-22 MJA - does not work
# %.pdf: %.Rmd
#	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','pdf_document')"

%.md: %.Rmd
	$(R_HOME)/bin/Rscript -e "knitr::knit('$*.Rmd')"

%.html: %.Rmd
	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','html_document')"

