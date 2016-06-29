PACKAGENAME:=$(shell gawk 'BEGIN { FS=": *" } ; /^Package:/{print $$2}' DESCRIPTION)
PACKAGEVERSION:=$(shell gawk 'BEGIN { FS=": *" } ; /^Version:/{print $$2}' DESCRIPTION)
RPACKAGE=${PACKAGENAME}_${PACKAGEVERSION}.tar.gz

JAVATARGETS=./java/bin/com/github/marcjandersen/rrdfancillary/RJenaHelper2.class ./inst/java/rrdfancillary.jar
VIGNETTETARGETS=./vignettes/do-update.html ./vignettes/do-update.md
TARGETS=../${RPACKAGE} ${JAVATARGETS} ${VIGNETTETARGETS}


all: createRD java data-raw rbuildforce rbuild vignettedoc

clean: 
	rm -f ${TARGETS}

cleantempemacs:
	rm -v -f .#* */.#* */*/.#* */#*# */*/*/.#* */*/*/#*#


install-rpackage-from-dir: ${RPACKAGE}
	$(R_HOME)/bin/Rscript -e 'library(devtools); install_local("../${RPACKAGE}")'

rbuildforce: ${RPACKAGE}

# checking package
# see http://cran.r-project.org/doc/manuals/r-release/R-exts.html#Checking-packages
# see http://stackoverflow.com/questions/15324705/should-there-be-a-package-subfolder-in-a-github-package-repo?lq=1
# removing --as-cran - ma 2015-11-25
rcheck: 
	cd ..; R CMD check  ${RPACKAGE}

rbuild: 
	cd ..; R CMD build  ${PACKAGENAME}

${RPACKAGE}:
	cd ..; R CMD build --force ${PACKAGENAME}

createRD:
	$(R_HOME)/bin/Rscript -e "library(devtools); devtools::document()"


data-raw:
	echo Nothing

java: ${JAVATARGETS}

${JAVATARGETS}:
	(cd java; make all)

# Only run this after the package is installed in the overall R library
# The vignettes uses the packages, and this should be the most recent version
# The vignettes document should be extracted from the package
vignettedoc: ${VIGNETTETARGETS}

${VIGNETTETARGETS}: 
	(cd vignettes; make all)


# To start fuseki endpoint - should be a script. 
# Problem that location is configuration dependent
# export CDISCRDF_HOME=~/projects/phrmwg-cdisc
# export FUSEKI_HOME=/opt/jena-fuseki-1.1.1;
# cd  ${CDISCRDF_HOME}
# ${FUSEKI_HOME}/fuseki-server --pages=${FUSEKI_HOME}/pages --update --loc=tdb /cdisc

