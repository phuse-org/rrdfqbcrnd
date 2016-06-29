PACKAGENAME:=$(shell gawk 'BEGIN { FS=": *" } ; /^Package:/{print $$2}' DESCRIPTION)
PACKAGEVERSION:=$(shell gawk 'BEGIN { FS=": *" } ; /^Version:/{print $$2}' DESCRIPTION)
RPACKAGE=${PACKAGENAME}_${PACKAGEVERSION}.tar.gz

JAVATARGETS=
VIGNETTETARGETS=
TARGETS=../${RPACKAGE} ${JAVATARGETS} ${VIGNETTETARGETS}

all: createRD data-raw rbuildforce install-rpackage-from-dir rbuild 

clean:
	(cd inst/data-raw; make clean)
	(cd vignettes; make clean)
	rm -f ${TARGETS}

cleantempemacs:
	rm -v -f .#* */.#* */*/.#* */#*# */*/*/.#* */*/*/#*#

install-rpackage-from-dir: 
	$(R_HOME)/bin/Rscript -e 'library(devtools); install_local("../${RPACKAGE}")'

rbuildforce: 
	cd ..; R CMD build --force --no-build-vignettes  ${PACKAGENAME}

# rbuildforce: ${RPACKAGE}


# checking package
# see http://cran.r-project.org/doc/manuals/r-release/R-exts.html#Checking-packages
# see http://stackoverflow.com/questions/15324705/should-there-be-a-package-subfolder-in-a-github-package-repo?lq=1
# removing --as-cran - ma 2015-11-25
rcheck: 
	cd ..; R CMD check  ${RPACKAGE}

rbuild: 
	cd ..; R CMD build  ${PACKAGENAME}

../${RPACKAGE}:
	cd ..; R CMD build --force ${PACKAGENAME}

createRD:
	$(R_HOME)/bin/Rscript -e "library(rrdfancillary); library(devtools); devtools::document()"

data-raw:
	(cd inst/data-raw; make all; make installDoc)

# Only run this after the package is installed in the overall R library
# The vignettes uses the packages, and this should be the most recent version
# Not the vignette documents are in the package
# The vignettes document should be extracted from the package

vignettedoc:
	(cd vignettes; make all)


