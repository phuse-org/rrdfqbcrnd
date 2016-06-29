all: mk-rrdfancillary  mk-rrdfcdisc mk-rrdfqb  mk-rrdfqbcrnd0 \
      mk-rrdfqbcrndex mk-rrdfqbcrndcheck mk-rrdfqbpresent mk-rrdfqbspec

install-from-dir: install-rrdfancillary-from-dir install-rrdfcdisc-from-dir install-rrdfqb-from-dir \
    install-rrdfqbcrnd0-from-dir install-rrdfqbcrndex-from-dir install-rrdfqbcrndcheck-from-dir \
    install-rrdfqbpresent-from-dir install-rrdfqbspec-from-dir

install-rrdfancillary-from-dir:
	cd rrdfancillary; make install-rpackage-from-dir

install-rrdfcdisc-from-dir:
	cd rrdfcdisc; make install-rpackage-from-dir

install-rrdfqb-from-dir:
	cd rrdfancillary; make install-rpackage-from-dir

install-rrdfqbcrnd0-from-dir:
	cd rrdfqbcrnd0; make install-rpackage-from-dir

install-rrdfqbcrndex-from-dir:
	cd rrdfqbcrndex; make install-rpackage-from-dir

install-rrdfqbcrndcheck-from-dir:
	cd rrdfqbcrndcheck; make install-rpackage-from-dir

install-rrdfqbpresent-from-dir:
	cd rrdfqbpresent; make install-rpackage-from-dir

install-rrdfqbspec-from-dir:
	cd rrdfqbspec; make install-rpackage-from-dir

################################################################

1 mk-rrdfancillary:
	cd rrdfancillary; make
	cd rrdfancillary; make install-rpackage-from-dir

2 mk-rrdfcdisc:
	cd rrdfcdisc; make
	cd rrdfcdisc; make install-rpackage-from-dir

3 mk-rrdfqb:
	cd rrdfqb; make
	cd rrdfqb; make install-rpackage-from-dir

4 mk-rrdfqbcrnd0:
	cd rrdfqbcrnd0; make
	cd rrdfqbcrnd0; make install-rpackage-from-dir

5 mk-rrdfqbcrndex:
	cd rrdfqbcrndex; make
	cd rrdfqbcrndex; make install-rpackage-from-dir

6 mk-rrdfqbcrndcheck:
	cd rrdfqbcrndcheck; make
	cd rrdfqbcrndcheck; make install-rpackage-from-dir

7 mk-rrdfqbpresent:
	cd rrdfqbpresent; make
	cd rrdfqbpresent; make install-rpackage-from-dir

8 mk-rrdfqbspec:
	cd rrdfqbspec; make
	cd rrdfqbspec; make install-rpackage-from-dir

doc-which-packages:
	@echo "|Package            |Description|"
	@echo "|-------------------|------------|"
	@(find -name "DESCRIPTION" -exec grep "Title:" {} /dev/null \; | gawk '{ a=gensub(/^(.+)\/.+:.+: *(.+)/, "|\\1|\\2|", "g",$$0 ); print a }')
	@echo " "

doc-which-version-pakages:
	@echo "|Package            |Version|"
	@echo "|-------------------|------------|"
	@(find -name "DESCRIPTION" -exec grep "Version:" {} /dev/null \; | gawk '{ a=gensub(/^(.+)\/.+:.+: *(.+)/, "|\\1|\\2|", "g",$$0 ); print a }')
	@echo " "

doc-which-md-files:
	@echo "|Package            |File        |Description|"
	@echo "|-------------------|------------|-----------|"
	@find -path "*/inst/doc/*" -name "*.md" -and -not -name "README.md" | gawk '{ getline line < $$0; a=gensub( /^(.+)(\/inst\/doc\/)(.+).md/, "|\\1|[\\3](\\1\\2\\3.html)|", "g",$$0 ); print a, line, "|";  }'

doc-which-vignette-md-files:
	@echo "|Package            |File        |Description|"
	@echo "|-------------------|------------|-----------|"
	@find -path "*/vignettes/*" -name "*.md" -and -not -name "README.md"| \
         gawk '{ getline line < $$0; a=gensub( /^(.+)(\/vignettes\/)(.+).md/, "|\\1|[\\2](\\1\\2\\3.html)", "g",$$0 ); \
               getline line < $$0; b=gensub( /^title: "([^"]+)"/, "|\\1|", "g", line ); \
               print a, b;  }'

# make doc-which-md-files  > overview-md.md
# pandoc --from markdown_github --to html --standalone README.md > README.html
# firefox README.html 
# make doc-which-md-files | pandoc --from markdown_github --to html --standalone > mdrendered.html

# regexp in gensub correct for these files; not in general - problem with file names with more than one period
doc-which-rq-files:
	@echo "|Package            |File        |Description|"
	@echo "|-------------------|------------|-----------|"
	@find -name "*.rq" | gawk '{ getline line < $$0; a=gensub( /^([^\/]+)\/([^\/]+)\/(.+).rq/, "|\\2|[\\3](\\2/\\3.rq)", "g",$$0 ); print a, "|", line, "|";  }'


rbuild:
	cd rrdfcdisc; make rbuild
	cd rrdfancillary; make rbuild
	cd rrdfqb; make rbuild
	cd rrdfqbcrnd0; make rbuild
	cd rrdfqbcrndex; make rbuild
	cd rrdfqbpresent; make rbuild
	cd rrdfqbcrndcheck; make rbuild
	cd rrdfqbspec; make rbuild


clean:
	cd rrdfcdisc; make clean
	cd rrdfancillary; make clean
	cd rrdfqb; make clean
	cd rrdfqbcrnd0; make clean
	cd rrdfqbcrndex; make clean
	cd rrdfqbpresent; make clean
	cd rrdfqbcrndcheck; make clean
	cd rrdfqbspec; make clean
