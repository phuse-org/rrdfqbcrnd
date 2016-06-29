# Setup for developing

The recommended approach is to get a copy of the package either by
using git to clone the repository from
(https://github.com/MarcJAndersen/rrdfqbcrnd0), or to obtain the
package as a zip file, for example by downloading from GitHub
(https://github.com/MarcJAndersen/rrdfqbcrnd0/archive/master.zip). Then
extract the zip file to a directory of your choosing, and go to the
subdirectory of rrdfqncrnd0 also named rrdfqncrnd0 and open the
rrdfqbcrnd0.Rproj file.

# Developing


Here are the commands I use for developing. 

```r
library(knitr)
library(devtools)
devtools::load_all()
```

Please note: in R-studio if the Knit function is used, then when a
library(rrdfqbcrnd0) command is issued as in all vignettes, then the
current version of the R-package installed will be used. This may be
different from development packages, but the vignette is the
development package version. So, it is recommend to install the
package first, for example using devtools::install().

The next commands are most often used when checking the building of
the package or making a installation of the package from the
source. The makefile is intented to be the way to build the package
(make rbuild).

```r
## If documentation provided by files in R directory have changed
devtools::document()
## build, without vignettes
devtools::build(vignettes=FALSE)

## If needed, build the vignettes - takes time and may need other programs to be installed
devtools::build_vignettes()
## Run the tests
devtools::test()
## Check if the package is valid
devtools::check()
## Install the package
devtools::install()
## 
```

TIP: For starting directory for the R process in use the directory
this file resides in. The other examples may depend on this, and
enables devtools::load_all() to load the package.

TIP: To single step line by line use ESS in emacs. 

TIP: To single step line by line use rstudio 

TIP: In Rstudio I open development.md (this file) and execute code lines one by one.

The [ggplot2 development](http://cran.r-project.org/web/packages/ggplot2/vignettes/development.html)
webpage also provides suggestions for development strategies.

## Commands used for developing

### Creating vignettes

The command below creates the vignette my-vignette.Rmd.

```
devtools::use_vignette("my-vignette")
```
 
### Setup test directories

The command below creates the test directories for the testhat environment.

```
devtools::use_testthat() 
```
 
### Setup data-raw directory

The command below creates the data-raw directories for the reproducing the datasets environment.

```
devtools::use_data_raw() 
```

In a script to actually add a data set _foo_ use:
```
devtools::use_data(foo) 
```
 
## Makefile in root directory

The makefile in the root directory is used for keeping track of the tasks to do before releasing the package. It would make sense to split the file into several makefiles going into the applicable subdirectories - that will be done when it is agreed on how to do it.

