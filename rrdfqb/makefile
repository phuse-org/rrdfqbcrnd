PACKAGENAME:=$(shell gawk 'BEGIN { FS=": *" } ; /^Package:/{print $$2}' DESCRIPTION)
PACKAGEVERSION:=$(shell gawk 'BEGIN { FS=": *" } ; /^Version:/{print $$2}' DESCRIPTION)
RPACKAGE=${PACKAGENAME}_${PACKAGEVERSION}.tar.gz

JAVATARGETS=
VIGNETTETARGETS= \
./vignettes/check-ic.html ./vignettes/check-ic.md \
./vignettes/explore-cube-vocabulary.html ./vignettes/explore-cube-vocabulary.md \
./vignettes/qb-sparql-queries.html ./vignettes/qb-sparql-queries.md
TARGETS=../${RPACKAGE} ${JAVATARGETS} ${VIGNETTETARGETS}

all: createRD data-raw rbuildforce install-rpackage-from-dir rbuild vignettedoc

clean:
	(cd inst/data-raw; make clean)
	(cd vignettes; make clean)
	rm -f ${TARGETS}

cleantempemacs:
	rm -v -f .#* */.#* */*/.#* */#*# */*/*/.#* */*/*/#*#

install-rpackage-from-dir: ../${RPACKAGE}
	$(R_HOME)/bin/Rscript -e 'library(devtools); install_local("../${RPACKAGE}")'

rbuildforce: ../${RPACKAGE}

# checking package
# see http://cran.r-project.org/doc/manuals/r-release/R-exts.html#Checking-packages
# see http://stackoverflow.com/questions/15324705/should-there-be-a-package-subfolder-in-a-github-package-repo?lq=1
# removing --as-cran - ma 2015-11-25
rcheck: 
	cd ..; R CMD check  ${PACKAGENAME}*.tar.gz

rbuild: 
	cd ..; R CMD build  ${PACKAGENAME}

../${RPACKAGE}:
	cd ..; R CMD build --force ${PACKAGENAME}

createRD:
	$(R_HOME)/bin/Rscript -e "library(devtools); library(rrdfancillary); devtools::document()"

data-raw:
	(cd inst/data-raw; make all; make installDoc)

java: ${JAVATARGETS}

${JAVATARGETS}:
	(cd java; make all)

# Only run this after the package is installed in the overall R library
# The vignettes uses the packages, and this should be the most recent version
# The vignettes document should be extracted from the package
vignettedoc:
	(cd vignettes; make all)


# To start fuseki endpoint - should be a script. 
# Problem that location is configuration dependent
# export CDISCRDF_HOME=~/projects/phrmwg-cdisc
# export FUSEKI_HOME=/opt/jena-fuseki-1.1.1;
# cd  ${CDISCRDF_HOME}
# ${FUSEKI_HOME}/fuseki-server --pages=${FUSEKI_HOME}/pages --update --loc=tdb /cdisc

