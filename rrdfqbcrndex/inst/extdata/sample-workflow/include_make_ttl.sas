data tablesdefx;
    set tablesdef;
    IRIdsd= cats("ds", ":", cat("dsd", "-", upcase(tablename)));
run;    

proc sort data=codes;
    by nameorder name ordernumber codedvalue;
run;

data codesx;
    set codes(rename=(datatype=datatype_codedvalue));
    IRIname= cats("crnd-dimension", ":", lowcase(name));
    IRIcodelist= cats("code", ":", lowcase(name));
    IRIcodeClasslist= cats("code", ":", propcase(name));
    select;
    when (datatype_codedvalue="character") do;
    IRIcodedvalue=cats("code", ":", lowcase(name),"-", translate(strip(codedvalue),"_", " ","_","<","_",">"));
    end;
    when (datatype_codedvalue="numeric") do;
    IRIcodedvalue=cats("code", ":", lowcase(name),"-", strip(codedvaluen) );
    end;
    end;
run;

proc print data=codesx;
run;

/* Could also store triples in a hash - would be more flexible */
data ttltemplate;
    length subject property object $200 language $3 datatype $100;
    keep subject property object language datatype;
    call missing(subject, property, object, language, datatype);
    delete;
ruN;


%let classvarlist=ITTFL SEX AGEGR1 ETHNIC TRT01AN;
%let classvarlistc=ITTFL SEX AGEGR1 ETHNIC;
%let classvarlistn=TRT01AN;

data observations_ttl;
    if 0 then do;
        set codesx;
        set ttltemplate; 
        end;
    
    set observations nobs=nobs;

    if _n_=1 then do;
        declare hash cval(dataset: "codesx(keep=name codedvalue codedvaluen IRIname IRIcodedvalue)");
        rc= cval.definekey( "name", "codedvalue", "codedvaluen" );
        rc= cval.definedata(ALL:'YES' );
        rc= cval.definedone( );

        retain obsfmt " ";
        length obsfmt $32;
        obsfmt= "Z" || length(strip(put(nobs,f32.))) || ".";
        putlog obsfmt=;
        end;

    length IRIobs $200;
    IRIobs= cats("ds", ":", "obs", putn( _n_, obsfmt ));
    subject=IRIobs;
    property="a";
    object="qb:Observation";
    output;
    
    array resdimc(*) &classvarlistc. procedure factor denominator;
    array resdimn(*) &classvarlistn. ;
    do j=1 to dim(resdimc);
    subject=IRIobs;
    rc= cval.find(key: lowcase(vname(resdimc(j))), key: ifc( missing(resdimc(j)) ,"_ALL_",resdimc(j)), key: . );
    if rc ne 0 then do;
        abort cancel;
        end;
    
    property=IRIcodelist;
    object="qb:Observation";
    output;
        end;
    do j=1 to dim(resdimn);
    rc= cval.find(key: lowcase(vname(resdimn(j))), key: " ", key: resdimn(j) );
    if rc ne 0 then do;
        abort cancel;
        end;
        subject=IRIcodedvalue;
        end;
run;

endsas;

/* Instead of splitting codesx into pieces include_tabulate_to_qb.sas could do that */
data dimensions;
    if _n_=1 then do;
        set tablesdefx;
    end;
    set codesx;
    by nameorder name ordernumber codedvalue;
    if first.name;
    keep nameorder name namelabel;
    keep IRIname IRIcodelist IRIcodedvalue;
    keep IRIdsd;
    keep dccsname;
    dccsname=cats("dccs", ":", lowcase(name));
    
run;

data dimensions_ttl;
    if 0 then do; set ttltemplate; end;
    set dimensions;
    subject= dccsname;
    property= "a";
    object="qb:ComponentSpecification";
    language=" ";
    datatype=" ";
    output;
    property="rdf:label";
    object=namelabel;
    language=" ";
    datatype="xsd:string";
    output;
    property="qb:dimension";
    object= IRIcodelist;
    language=" ";
    datatype=" ";
    output;
    subject=IRIdsd;
    property="qb:component";
    object= dccsname;
    language=" ";
    datatype=" ";
    output;
run;

data codelists_ttl;
    if 0 then do; set ttltemplate; end;
    set dimensions; /* assuming all dimensions have codelists */
    subject= IRIcodelist;
    property= "a";
    object="skos:ConceptScheme";
    language=" ";
    datatype=" ";
    output;
    property="rdf:label";
    object=catx(" ", "Codelist scheme:", lowcase(name));
    language="en";
    datatype=" ";
    output;
    property="skos:note";
    object=catx(" ", "Specifies the", lowcase(name), "for each observation, group of obs. or all categories (_ALL_)" );
    language="en";
    datatype=" ";
    output;
    property="skos:prefLabel"; object=catx(" ", "Codelist scheme:", lowcase(name) );
    language="en";
    datatype=" ";
    output;
    /* ToDo(mja): add qb:codelist */
run;

data codelistvalues_ttl;
    if 0 then do; set ttltemplate; end;
    set codesx;
    subject= IRIcodedvalue;
    property= "a";
    object= IRIcodeCLasslist;
    language=" ";
    datatype=" ";
    output;
    object= "skos:Concept" ;
    language=" ";
    datatype=" ";
    output;
    poperty="rdfs:comment";
    object="Coded values from data source. No reconciliation against another source" ;
    language="en";
    datatype=" ";
    output;
    property="skos:prefLabel";
    object=decode;
    datatype="xsd:string";
    output;
    property="skos:topConceptOf";
    object=IRIcodelist;
    datatype=" ";
    output;
run;

data dsd_ttl;
    if 0 then do; set ttltemplate; end;
    set tablesdefx;
    subject=IRIdsd;
    property= "a";
    object= "qb:DataStructureDefinition";
    language=" ";
    datatype=" ";
    output;
run;

data prefixes;
   length prefixname URIstemp $200;
    dspart="demot";
    
prefixname= "dccs"; URIstemp= "http://www.example.org/dc/demo/dccs/"; output; 
prefixname= "sdtms-1-3"; URIstemp= "http://rdf.cdisc.org/sdtm-1-3/schema#"; output; 
prefixname= "code"; URIstemp= "http://www.example.org/dc/code/"; output; 
prefixname= "adam-2-1"; URIstemp= "http://rdf.cdisc.org/std/adam-2-1#"; output; 
prefixname= "owl"; URIstemp= "http://www.w3.org/2002/07/owl#"; output; 
prefixname= "xsd"; URIstemp= "http://www.w3.org/2001/XMLSchema#"; output; 
prefixname= "skos"; URIstemp= "http://www.w3.org/2004/02/skos/core#"; output; 
prefixname= "cdash-1-1"; URIstemp= "http://rdf.cdisc.org/std/cdash-1-1#"; output; 
prefixname= "sdtm-1-3"; URIstemp= "http://rdf.cdisc.org/std/sdtm-1-3#"; output; 
prefixname= "rdfs"; URIstemp= "http://www.w3.org/2000/01/rdf-schema#"; output; 
prefixname= "adamvr-1-2"; URIstemp= "http://rdf.cdisc.org/std/adamvr-1-2#"; output; 
prefixname= "crnd-attribute"; URIstemp= "http://www.example.org/dc/attribute#"; output; 
prefixname= "sdtm-1-2"; URIstemp= "http://rdf.cdisc.org/std/sdtm-1-2#"; output; 
prefixname= "sdtmct"; URIstemp= "http://rdf.cdisc.org/sdtm-terminology#"; output; 
prefixname= "qb"; URIstemp= "http://purl.org/linked-data/cube#"; output; 
prefixname= "mms"; URIstemp= "http://rdf.cdisc.org/mms#"; output; 
prefixname= "crnd-dimension"; URIstemp= "http://www.example.org/dc/dimension#"; output; 
prefixname= "dct"; URIstemp= "http://purl.org/dc/terms/"; output; 
prefixname= "cdiscs"; URIstemp= "http://rdf.cdisc.org/std/schema#"; output; 
prefixname= "dcat"; URIstemp= "http://www.w3.org/ns/dcat#"; output; 
prefixname= "cdashct"; URIstemp= "http://rdf.cdisc.org/cdash-terminology#"; output; 
prefixname= "prov"; URIstemp= "http://www.w3.org/ns/prov#"; output; 
prefixname= "sdtmig-3-1-3"; URIstemp= "http://rdf.cdisc.org/std/sdtmig-3-1-3#"; output; 
prefixname= "adamig-1-0"; URIstemp= "http://rdf.cdisc.org/std/adamig-1-0#"; output; 
prefixname= "crnd-measure"; URIstemp= "http://www.example.org/dc/measure#"; output; 
prefixname= "cts"; URIstemp= "http://rdf.cdisc.org/ct/schema#"; output; 
prefixname= "pav"; URIstemp= "http://purl.org/pav"; output; 
prefixname= "sdtmig-3-1-2"; URIstemp= "http://rdf.cdisc.org/std/sdtmig-3-1-2#"; output; 
prefixname= "sendig-3-0"; URIstemp= "http://rdf.cdisc.org/std/sendig-3-0#"; output; 
prefixname= "rdf"; URIstemp= "http://www.w3.org/1999/02/22-rdf-syntax-ns#"; output; 
prefixname= "adamct"; URIstemp= "http://rdf.cdisc.org/adam-terminology#"; output; 
prefixname= "sendct"; URIstemp= "http://rdf.cdisc.org/send-terminology#"; output; 
prefixname= "rrdfqbcrnd0"; URIstemp= "http://www.example.org/rrdfqbcrnd0/"; output; 
prefixname= "dc"; URIstemp= "http://purl.org/dc/elements/1.1/"; output; 

prefixname= "ds"; URIstemp= cats("http://www.example.org/dc/", DSpart, "/ds/"); output; 

run;

filename ru "insert-stmts.ru";

data prefixesx;
    set prefixes;
    file ru;
    put "prefix " prefixname : +(-1) ":" " " "<" URIstemp : +(-1) ">";
run;


data ttl;
    set dsd_ttl dimensions_ttl codelists_ttl codelistvalues_ttl 
        observations_ttl
        end=AllDone;
    file ru mod;
    if _n_=1 then do;
        put "INSERT DATA";
        put "{";
        end;
    select;
    when(not missing(language)) do;
    objectrepr=cats(quote(strip(object)),"@",language);
    end;
    when(not missing(datatype)) do;
    objectrepr=cats(quote(strip(object)),"^^",datatype);
    end;
    otherwise do;
    objectrepr= object;
    end;
    end;
    put subject : property : objectrepr ".";
    if alldone then do;
        put "}";
        end;
run;

