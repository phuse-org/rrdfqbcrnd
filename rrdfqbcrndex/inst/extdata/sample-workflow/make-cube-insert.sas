libname this ".";

proc format library=work cntlin=this.formats;
run;
    
data tablesdef;
    set this.tablesdef;
run;

data observations;
    set this.observations;
run;

data codes;
    set this.codes;
run;

%include "include_make_ttl.sas";
    
