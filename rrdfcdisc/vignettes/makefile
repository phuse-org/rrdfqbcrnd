
TARGETS=CDISC-make-list.html CDISC-make-list.md CDISC-make-list.pdf
all: ${TARGETS}

clean:
	rm -f ${TARGETS}

%.pdf: %.Rnw
	$(R_HOME)/bin/Rscript -e "knitr::knit2pdf('$*.Rnw')"

%.pdf: %.Rmd
	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','pdf_document')"

%.md: %.Rmd
	$(R_HOME)/bin/Rscript -e "knitr::knit('$*.Rmd')"

%.html: %.Rmd
	$(R_HOME)/bin/Rscript -e "rmarkdown::render('$*.Rmd','html_document')"

