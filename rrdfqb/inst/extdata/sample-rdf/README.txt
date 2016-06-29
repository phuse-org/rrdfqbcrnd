Using Fusiki to do the update

    FUSEKI_HOME=/opt/apache-jena-fuseki-2.3.1/
    (${FUSEKI_HOME}fuseki-server --mem --update /ex2) &

ToDo: add storing PID in file (`echo $$ > fuseki.pid; `), and redirecting output from fuseki.

will re-use configuration files - so be sure of the contents of the run directory.

To load, normalize phase 1, normalize phase 2, and finally dump the graph
    ${FUSEKI_HOME}bin/s-put http://localhost:3030/ex2/data default ../sample-rdf/example.ttl
    ${FUSEKI_HOME}bin/s-update --server=http://localhost:3030/ex2/update --update=../cube-vocabulary-rdf/normalize-algorithm-phase-1.ru 
    ${FUSEKI_HOME}bin/s-update --server=http://localhost:3030/ex2/update --update=../cube-vocabulary-rdf/normalize-algorithm-phase-2.ru 
    ${FUSEKI_HOME}bin/s-get http://localhost:3030/ex2/get default  > ../sample-rdf/example-normalize.ttl


================================================================

# does work with jena 2.13
/opt/apache-jena-2.13.0/arq --desc=jena-assambler.ttl  "select * where {?s ?p ?o} limit 10"
/opt/apache-jena-2.13.0/bin/update --desc=jena-assambler.ttl --update=normalize-algorithm-phase-1.ru --dump
/opt/apache-jena-2.13.0/update --desc=jena-assambler.ttl --update=normalize-algorithm-phase-2.ru --verbose --debug



# does not work with jena 3.0.0
/opt/apache-jena-3.0.0/bin/tdbloader --loc=DB example.ttl 
arq --desc=tdb-assembler.ttl  "select * where {?s ?p ?o} limit 10"



================

Creates setup 
[ma@s107 sample-rdf]$ (FUSEKI_HOME=/opt/apache-jena-fuseki-2.3.0 /opt/apache-jena-fuseki-2.3.0/fuseki-server )
[2015-12-28 23:58:57] Server     INFO  Fuseki 2.3.0 2015-07-25T17:11:28+0000
[2015-12-28 23:58:57] Config     INFO  FUSEKI_HOME=/opt/apache-jena-fuseki-2.3.0
[2015-12-28 23:58:57] Config     INFO  FUSEKI_BASE=/home/ma/projects/R-projects/rrdfqbcrnd0/rrdfqb/inst/extdata/sample-rdf/run
[2015-12-28 23:58:57] Servlet    INFO  Initializing Shiro environment
[2015-12-28 23:58:57] Config     INFO  Shiro file: file:///home/ma/projects/R-projects/rrdfqbcrnd0/rrdfqb/inst/extdata/sample-rdf/run/shiro.ini
[2015-12-28 23:58:58] Server     INFO  Started 2015/12/28 23:58:58 CET on port 3030

In directory run/configuration add configuration for ex endpoint using the filename run/configuration/ex.ttl as:
=================================================
@prefix :        <#> .
@prefix fuseki:  <http://jena.apache.org/fuseki#> .
@prefix rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> .
@prefix tdb:     <http://jena.hpl.hp.com/2008/tdb#> .
@prefix ja:      <http://jena.hpl.hp.com/2005/11/Assembler#> .

## ---------------------------------------------------------------
## Updatable TDB dataset with all services enabled.

<#service_tdb_all> rdf:type fuseki:Service ;
    rdfs:label                      "TDB ex" ;
    fuseki:name                     "ex" ;
    fuseki:serviceQuery             "query" ;
    fuseki:serviceQuery             "sparql" ;
    fuseki:serviceUpdate            "update" ;
    fuseki:serviceUpload            "upload" ;
    fuseki:serviceReadWriteGraphStore      "data" ;
    # A separate read-only graph store endpoint:
    fuseki:serviceReadGraphStore       "get" ;
    fuseki:dataset           <#tdb_dataset_readwrite> ;
    
    .

<#tdb_dataset_readwrite> rdf:type      tdb:DatasetTDB ;
    tdb:location "run/databases/ex" ;
    ##ja:context [ ja:cxtName "arq:queryTimeout" ;  ja:cxtValue "3000" ] ;
    ##tdb:unionDefaultGraph true ;
    .
=================================================


Note - all files in run/configuration/ are read - so do not leave backup files in the directory.

Start again:

(FUSEKI_HOME=/opt/apache-jena-fuseki-2.3.0 /opt/apache-jena-fuseki-2.3.0/fuseki-server )

To run update query


(FUSEKI_HOME=/opt/apache-jena-fuseki-2.3.0 /opt/apache-jena-fuseki-2.3.0/bin/s-update --server=http://localhost:3030/ex/update --update=normalize-algorithm-phase-1.ru )
(FUSEKI_HOME=/opt/apache-jena-fuseki-2.3.0 /opt/apache-jena-fuseki-2.3.0/bin/s-update --server=http://localhost:3030/ex/update --update=normalize-algorithm-phase-2.ru )

To dump the graph
(FUSEKI_HOME=/opt/apache-jena-fuseki-2.3.0 /opt/apache-jena-fuseki-2.3.0/bin/s-get http://localhost:3030/ex/get default )


================================================================

