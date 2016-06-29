

%MACRO SetGlMacroVar(mv,default);
    %if not %symexist(this_glmvlist) %then %do;
        %global this_glmvlist;
        %let this_glmvlist=;
        %end;
    %if %sysfunc(indexw(%qupcase(&this_glmvlist),%qupcase(&mv)))=0 %then %do;
        %if %symexist(&mv) %then %do;
            /* no change */
            %*put SetGlMacroVar: &mv does not exists in this_glmvlist, but is defined as macro variable;
            %end;
        %else %do;
            %global &mv.;
            %let &mv=&default.;
            %let this_glmvlist=&this_glmvlist. &mv.;
            %end;
        %end;
    %put SetGlMacroVar: &mv.=&&&mv.;
%MEND;

%SetGlMacroVar(tabulateOutputDs,work.demo_tabulate);
%SetGlMacroVar(orderfmt,$orderfmt. );

proc contents data=&tabulateOutputDs. varnum;
run;


proc print data=&tabulateOutputDs.;
    format _all_;
run;

data tablesdef; /* well, only one table for now */
    length tablename $200;
    tablename=symget("tabulateOutputDs");
    output;
run;

/*

   Create macrovariables with the variable names.
   The macrovariables are specific for the table.
    
   Instead of having the macro variable, the processing later could be
   also done in the datastep using varname, getvarc, getvarn. Decided against this,
   as this is more complex code. The benefit would be that it could process more than
   one tbale.
   
    */
    
data _null_;
    set tablesdef;
    tableid=open(tablename,'i');
    if tableid=0 then do;
        length sysmsgtxt $200;
        sysmsgtxt=sysmsg();
        putlog "Could not open " tablename= ;
        putlog "Message: " sysmsgtxt=;
        abort cancel;
        end;
    length classvarlist classvarlistc classvarlistn resultvarlist $32000;
    classvarlist=" ";
    classvarlistc=" ";
    classvarlistn=" ";
    array cltype(0:1) classvarlistn classvarlistc;
    resultvarlist=" ";
    classvarfromposm1= varnum(tableid, "_Run_");
    classvartoposp1= varnum(tableid, "_type_");
    do i=classvarfromposm1+1 to classvartoposp1-1;
        classvarlist=catx(" ", classvarlist, varname(tableid,i));
        cltype(vartype(tableid,i)="C")=catx(" ", cltype(vartype(tableid,i)="C"), varname(tableid,i));
        end;
    resultfromposm1= varnum(tableid, "_TABLE_");
    resulttopos= attrn(tableid,'nvars');
    do i=resultfromposm1+1 to resulttopos-1;
        resultvarlist=catx(" ", resultvarlist, varname(tableid,i));
        end;
    rc=close(tableid);
    array vput(*) classvarlist classvarlistc classvarlistn resultvarlist;
    do i=1 to dim(vput);
        call symputx( vname(vput(i)), vput(i));
        end;

run;

%put classvarlist=&classvarlist.;
%put classvarlistc=&classvarlistc.;
%put classvarlistn=&classvarlistn.;
%put resultvarlist=&resultvarlist.;

data variablesdef; /* Naming inspired from define-xml */
    attrib DataType length=$32;
    attrib Label length=$32;
    attrib SASFieldName length=$32;
    attrib SASFormatName length=$32;
    attrib CodeListOID length=$32;
    attrib OriginDescription length=$32;
    
    call missing( DataType, Label, SASFieldName , SASFormatName,
        CodeListOID , OriginDescription );

delete;

run;

data codesdef;
    attrib name length=$32;
    attrib namelabel length=$200;
    attrib datatype length=$32;
    attrib codedvalue length=$32;
    attrib ordernumber length=$32;
    attrib decode  length=$200;
    call missing( name, nameorder, namelabel, datatype, codedvalue, codedvaluen, ordernumber, decode);
    delete;
run;

    
data observations;
    if 0 then do;
        set variablesdef;
        set codesdef;
        end;
    
    if _n_=1 then do;
        declare hash cval(dataset: "codesdef");
        rc= cval.definekey( "name", "codedvalue", "codedvaluen" );
        rc= cval.definedata(ALL:'YES' );
        rc= cval.definedone( );
        end;
    
    array results(*) &resultvarlist.;
    
    
    set &tabulateOutputDs. end=AllDone;
    /* add variable to dimension hash */
    /* add variable and code level to hash */
    
    keep &classvarlist.;
    keep _type_;
    denominatorpattern=_type_; /* inherit length from _type_ */
    denominatorpattern=" ";
    keep denominatorpattern;
    length procedure factor denominator $64;
    keep procedure factor denominator;
    array resdimc(*) &classvarlistc. procedure factor denominator;
    label procedure="Method for descriptive statistic";
    label factor="Names of variable for descriptive statistics";
    label denominator="Denominator for statistics";
    array resdimn(*) &classvarlistn. ;
    keep measure;
    do i=1 to dim(results);
        mn= vname(results(i));
        procedure=" ";
        factor=" ";
        denominator=" ";
        select;
        when (mn="N") do;
            procedure="COUNT"; /* COUNT to be compliant with R package ? */
            factor=" "; /* could take the same as for PCTN */
            denominator=" ";
            measure=results(i);
            end;
        when (upcase(scan(mn,1,"_")) in ("PCTN")) do;
            procedure=scan(mn,1,"_");
            denominatorpattern=scan(mn,-1,"_");
            denominator=" ";
            factor=" "; /* take the set difference of _type_ and denominatorpattern and select those classdim variables - here only one */
            if length(denominatorpattern) ne length (_type_) then do;
                putlog denominatorpattern= _type_= " does not have same length";
                end;
            do k=1 to length(denominatorpattern);
                if substr(denominatorpattern,k,1)="0" and substr(_type_,k,1)="1" then do;
                    denominator=scan(symget("classvarlist"),k," ");
                    end;
                end;
            measure=results(i);
            end;
        otherwise do;
            procedure=scan(mn,-1,"_");
            factor= substr(mn, 1, length(mn)-length(procedure)-1);
            denominator=" ";
            measure=results(i);
            end;
        end;
    

 /* not ideal - STD is undefined for n=2, and would like to have it in the results */
 /* one approach could be to use vname(results(i)) to determine what to do and also have a flag for std being included */        
        if not missing(measure) then do;
            output;
            
            do j=1 to dim(resdimc); /* do not need to do it again for &classvarlistc. variables */
                name=lowcase(vname(resdimc(j)));
                namelabel=vlabel(resdimc(j));
                datatype= "character"; /* character in the SAS sense */
                codedvaluen= .;
                nameorder= j+dim(resdimn);
                if missing(resdimc(j)) then do;
                    codedvalue="_ALL_";
                    decode= "All";
                    ordernumber= " ";
                    end;
                else do;
                    codedvalue= resdimc(j);
                    decode= vvalue(resdimc(j));
                    if missing("&orderfmt.") then do;
                        ordernumber= " ";
                        end;
                    else do;
                        if missing(putc(name,"&orderfmt.")) or missing(codedvalue) then do;
                            ordernumber= " ";
                            end;
                        else do;  
                            ordernumber= putc(strip(codedvalue),putc(name,"&orderfmt."));
                            end;
                        end;
                    end;
                rc=cval.ref();
                end;
            
            do j=1 to dim(resdimn);
                name=lowcase(vname(resdimn(j)));
                datatype= "numeric";  /* using numeric in the SAS sense */
                nameorder= j;
                if missing(resdimn(j)) then do;
                    codedvalue="_ALL_";
                    decode= "All";
                    ordernumber= " ";
                    end;
                else do;
                    codedvalue= " ";
                    codedvaluen= resdimn(j);
                    decode= vvalue(resdimn(j));
                    if missing("&orderfmt.") then do;
                        ordernumber= " ";
                        end;
                    else do;
                        if missing(putc(name,"&orderfmt.")) or missing(codedvaluen) then do;
                            ordernumber= " ";
                            end;
                        else do;
                            ordernumber= putn(codedvaluen,putc(name,"&orderfmt.")); 
                            end;
                        end;
                    rc=cval.ref();
                    end;
                end;
            end;
        end;
    
    if alldone then do;
        cval.output(dataset: "codes");
        end;
run;

proc print data=observations;
run;

proc print data=codes;
run;

