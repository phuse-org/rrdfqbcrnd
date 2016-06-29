/*------------------------------------------------------------------------*\
** Program : demo-export-csv.sas

** Purpose : Show how to modify program from PhUSE scription group to
** generate .csv files for using with RRDFQBCRND0

** Note: Program code is from program by from Mike Carniello at
** https://code.google.com/p/phuse-scripts/source/browse/trunk/whitepapers/demographics/demo.sas

** Author: Marc Andersen (mja@statgroup.dk), 02-mar-2015
\*------------------------------------------------------------------------*/



options ls=150;
filename source url "http://phuse-scripts.googlecode.com/svn/trunk/scriptathon2014/data/adsl.xpt" ;
libname source xport ;

options mprint;

proc format;
   value $destats
     'NC'       = 'n[a]'
     'MEANC'    = 'Mean'
     'STDC'     = 'SD'
     'MEDIANC'  = 'Median'
     'Q1Q3C'    = 'Q1, Q3'
	 'MINMAXC'  = 'Min, Max'
	 'MISSINGC' = 'Missing';

   invalue destatso
     'NC'       = 0
     'MEANC'    = 1
     'STDC'     = 2
     'MEDIANC'  = 3
     'Q1Q3C'    = 4
     'MINMAXC'  = 5
     'MISSINGC' = 6
     'MIN'      =-101
     'MAX'      =-102
     'Q1'      =-103
     'Q3'      =-104
     'MEAN'    =-105
     'MEDIAN'  =-106
     'N'=-107
       'STD'=-108
       ;

    value $sexfmt
	  'N' = 'n[a]'
	  'F' = 'F'
	  'M' = 'M';

	invalue sexfmto
	  'N' = 1
	  'F' = 2
	  'M' = 3;
    
	value $agegrfmt
	  'N'     = 'n[a]'
      '<65'   = '<65'
	  '65-80' = '65-80'
	  '>80'   = '>80';

	invalue agegrfmto
	  'N'     = 1
      '<65'   = 2
	  '65-80' = 3
	  '>80'   = 4;

	value $racefmt
	  'N' = 'n[a]'
	  'WHITE' = 'White'
	  'BLACK OR AFRICAN AMERICAN' = 'Black or African American'
	  'AMERICAN INDIAN OR ALASKA NATIVE' = 'American Indian or Alaska Native';

	invalue racefmto
	  'N' = 1
	  'WHITE' = 2
	  'BLACK OR AFRICAN AMERICAN' = 3
	  'AMERICAN INDIAN OR ALASKA NATIVE' = 4;

	value $ethfmt
	  'N' = 'n[a]'
	  'NOT HISPANIC OR LATINO' = 'Not Hispanic or Latino'
	  'HISPANIC OR LATINO' = 'Hispanic or Latino';

	invalue ethfmto
	  'N' = 1
	  'NOT HISPANIC OR LATINO' = 2
	  'HISPANIC OR LATINO' = 3;
run;

%global trtn trt;
%let trtn = trt01an;
%let trt = trt01a;

data work.adsl;
   set source.adsl;

   where ittfl = 'Y';
run;

proc sort data=adsl out=treatments(keep=&trtn &trt) nodupkey;
   by &trtn;
run;

data treatments;
   set treatments;
   by &trtn;
   
   __dummytrt + 1;
run;

proc sort data=adsl;
   by &trtn;
run;

data adsl_work;
   merge adsl treatments;
   by &trtn;
run;

%global trtnum;

proc sql noprint;
   select strip(put(count(__dummytrt), best.)) into: trtnum
   from treatments;
quit;

%macro bigns;
    %local i;
  proc sql noprint;
    %do i=1 %to &trtnum;
     %global trt&i. trtname&i.;
       select count(usubjid) into: trt&i from adsl_work where __dummytrt = &i;
	   select &trt into: trtname&i from adsl_work where __dummytrt = &i;
	%end;
  quit;
%mend bigns;

%bigns;

%macro prcnt(num=,denom=,pctd=pctd,pctfmt=4.0);                               
  do;                                                                           
    length &pctd $9;                                                            
	if &num = 0 and &denom = 0 then &pctd='';
	else do;
	  if &num = 0 then &pctd = '';
      else &pctd = '(' || compress(put(100*&num/&denom,&pctfmt)) || '%)';
	end;
	&pctd = right(&pctd); 
  END;                                                                          
%mend;

%macro descrstats(indata=, outdata=, varn=, dec=, name=, ord=);
   proc sort data=&indata out=__indata;
      by __dummytrt;
   run;

   proc means data=__indata noprint;
      by __dummytrt;
	  var &varn;
	  output out=__meansres n=n mean=mean stddev=std min=min max=max q1=q1 q3=q3 median=median;
   run;

   data __meansres;
      set __meansres;
      nc = put(n,6.0);
      meanc = put(mean,6.%eval(&dec+1));
	  medianc = put(median,6.%eval(&dec+1));
	  stdc = put(std,6.%eval(&dec+1));
	  q1q3c = trim(put(q1,6.%eval(&dec+1)))||', '||trim(put(q3,6.%eval(&dec+1)));
	  minmaxc = trim(put(min,6.%eval(&dec+0)))||', '||put(max,6.%eval(&dec+0));
   run;

   proc transpose data=__meansres out=__trout prefix=col;
      id __dummytrt;
      var nc meanc stdc minmaxc q1q3c medianc; 
   run;

   proc sort data=__trout;
       by _name_;
   run;
   proc transpose data=__meansres out=__troutn prefix=coln;
      id __dummytrt;
      var n mean std min max q1 q3 median; 
   run;

   proc sort data=__troutn;
       by _name_;
   run;

    data __descrres;
      length col1-col&trtnum $50;
      merge __trout __troutn;
      by _name_;

	  length name col0 varn $200;
	  
	  col0 = put(upcase(_NAME_), $destats.);
	  ord = input(upcase(_NAME_), destatso.);
	  name = &name;
	  mainord = &ord;
          varn="&varn.";
      keep  mainord ord varn name col0 col1-col&trtnum  coln1-coln&trtnum _name_;
   run;

   data &outdata;
      set __descrres;
   run;
%mend descrstats;

%descrstats(indata=adsl_work, 
            outdata=ageres,
            varn=age,
            dec=0,
            name="Age (years)",
            ord=2);

%descrstats(indata=adsl_work, 
            outdata=weightres,
            varn=weightbl,
            dec=0,
            name="Weight (kg)",
            ord=5);

%macro freqstats(indata=, outdata=, var=, varfmt=, ordfmt=, name=, ord=);
  proc freq data = &indata noprint;
    tables &var*__dummytrt / out = __frout (drop = percent);
  run;

  proc sql noprint;
    %do i=1 %to &trtnum;
       select count(usubjid) into: denom&i from &indata where ^missing(&var) and __dummytrt = &i;
	%end;
  quit;

  proc sort data = __frout;
    by &var;
  run;

  proc transpose data = __frout out = __trout_fr (drop = _LABEL_ _NAME_ ) prefix=n;
    var count;
    id __dummytrt;
    by &var;
  run;

  data denom;
     &var = "N";
     %do i=1 %to &trtnum;
	     n&i = &&denom&i;
	 %end;
  run;

  data &outdata;
    set __trout_fr denom;
    length name col0 $200 col1-col&trtnum $50;
	%do i=1 %to &trtnum;
      if n&i = . then n&i = 0;
	  %prcnt(num=n&i,denom=&&denom&i,pctd=pct&i,pctfmt=5.1);
      col&i = put(n&i,6.0-R) || pct&i.;
      coln&i= n&i.;
      colna&i= N&i. / &&denom&i*100;
	%end;

        varn ="&var";
	name = &name;
	col0 = put(&var, $&varfmt..);
	mainord = &ord;
	ord = input(&var, &ordfmt..);
  run;

%mend freqstats;

%freqstats(indata=adsl_work,
           outdata=sexres,
           var=sex,
           varfmt=sexfmt,
		   ordfmt=sexfmto,
           name="Sex n(%)",
           ord=1);

%freqstats(indata=adsl_work,
           outdata=agegrres,
           var=agegr1,
           varfmt=agegrfmt,
		   ordfmt=agegrfmto,
           name="Age categories n(%)",
           ord=3);

%freqstats(indata=adsl_work,
           outdata=raceres,
           var=race,
           varfmt=racefmt,
		   ordfmt=racefmto,
           name="Race n(%)",
           ord=4);

%freqstats(indata=adsl_work,
           outdata=ethnicres,
           var=ethnic,
           varfmt=ethfmt,
		   ordfmt=ethfmto,
           name="Ethnicity n(%)",
           ord=5);

data report;
   set ageres weightres sexres agegrres raceres ethnicres;
run;

proc sort data=report;
    by mainord ord;
run;

options nodate nobyline nonumber nocenter
        formchar='|_---|+|---+=|-/\<>*' charcode;

/*proc printto print="&list\&prog..lst" new;
run;
title;
footnote;*/
        
%let under=%sysfunc(repeat(_,180-1));

title5 "&under";

footnote1 "&under";
footnote2 "n[a] - number of subject with non-missing data, used as denominator";

proc report data=report ls=180 ps=45 split="@"  headline headskip nocenter nowd missing spacing=2;
    where ord>0;
  column mainord name ord col0 col1 col2 col3;
  
  define mainord / order order=internal noprint;
  define ord  / order order=internal noprint;
  define name / display " " width=62 spacing=0 flow order;
  define col0 / display " " width=30 ;
  define col1 / display "&trtname1.@      (N=%qcmpres(&trt1.))" width=20;
  define col2 / display "&trtname2.@      (N=%qcmpres(&trt2.))" width=20;
  define col3 / display "&trtname3.@     (N=%qcmpres(&trt3.))" width=20;

  break after mainord / skip;
run;

/*proc printto;
run;*/

data temp.report;
    set report;
run;
libname temp list;

/*------------------------------------------------------------------------*\
** Program : report_to_rrdf.sas
** Purpose : Transfer dataset report to RRDFQBCRND excel workbook format
\*------------------------------------------------------------------------*/

options linesize=200 nocenter;

/*
proc contents data=temp.report varnum;
run;

proc print data=temp.report width=min;
*    where col0 in ( 'MIN', 'MAX', 'Q1', 'Q3', 'MEAN', 'MEDIAN', 'N', 'STD', 'NC' );
*    where ord<0 or col0 = "NC";
    var sex agegr1 race ethnic varn _name_ ord col0 coln1 colna1 coln2 colna2 coln3 colna3;
run;
*/

data forexport;
    length sex agegr1 race ethnic trt01a $200;
    set temp.report;
    keep sex agegr1 race ethnic trt01a;
    keep procedure factor;
    length procedure factor $50;
    keep unit denominator;
    length unit denominator $50;
    unit=" ";
    keep measure;
    array adim(*) sex agegr1 race ethnic;
    array meascont(*) coln1 coln2 coln3;
    array measn(*) coln1 coln2 coln3;
    array measnpct(*) colna1 colna2 colna3;
    array atrt01a(3) $50 ("Placebo" "Xanomeline Low Dose"   "Xanomeline High Dose");
    keep colno rowno cellpartno;
    format colno rowno cellpartno z5.0;
    rowno+1;
    
    do i=1 to dim(adim);
        select;
        when (adim(i)="N" and col0="n[a]") do;
        adim(i)="_NONMISS_";
        end;
        when (missing(adim(i))) do;
        adim(i)="_ALL_";
        end;
        otherwise do; 
          /* no change */
        end;
        end;
    end;

    select;
    when (ord<0) do;
        do i=1 to dim(atrt01a);
            colno=i;
            cellpartno=1;
            factor=varn;
            procedure=_name_;
            denominator=" ";
            trt01a= atrt01a(i);
            measure=meascont(i);
            output;
            end;
        end;
    when (varn in ("sex", "agegr1", "race", "ethnic")) do;
        do i=1 to dim(atrt01a);
            colno=i;
            cellpartno=1;
            factor="quantity";
            procedure="count";
            denominator=" ";
            trt01a= atrt01a(i);
            measure=measn(i);
            output;
            end;
        do i=1 to dim(atrt01a);
            colno=i;
            cellpartno=2;
            factor="proportion";
            procedure="percent";
            denominator=varn;
            trt01a= atrt01a(i);
            measure=measnpct(i);
            output;
            end;
        end;
    otherwise do;
    end;
end;
run;

/*
proc print data=forexport width=min;
run;

proc contents data=forexport varnum;
run;
*/

proc export data=forexport file="../sample-cfg/demo.AR.csv" replace;
run;

data skeletonSource1;
length compType compName codeType nciDomainValue compLabel Comment $512;
    Comment= " ";
    compType= "dimension"; compName="trt01a";    compLabel="Treatment Arm"; codeType="DATA"; nciDomainValue= " "; output;
    compType= "dimension"; compName="sex";       compLabel="Sex (Gender)"; codeType="SDTM"; nciDomainValue="C66731";output;
    compType= "dimension"; compName="saffl";     compLabel="Safety Population Flag"; codeType="DATA"; nciDomainValue= " ";output;
    compType= "dimension"; compName="procedure"; compLabel="Statistical Procedure"; codeType="DATA"; nciDomainValue= " ";output;
    compType= "dimension"; compName="factor";    compLabel="Type of procedure (quantity, proportion...)"; codeType="DATA"; nciDomainValue= " "; output;

    compType= "measure"; compName="measure";      compLabel="Value of the statistical measure"; codeType=" "; nciDomainValue=" "; output;
    compType= "attribute"; compName="unit";        compLabel="Unit of measure"; codeType=" "; nciDomainValue=" "; output;
    compType= "attribute"; compName="denominator"; compLabel="Denominator for a proportion (oskr) subset on which a statistic is based"; codeType=" "; nciDomainValue=" "; output;

/* presentation stuff */    
    compType= "attribute"; compName="colno"; compLabel="Column number for two dimensional represenation"; codeType=" "; nciDomainValue=" "; output;
    compType= "attribute"; compName="rowno"; compLabel="Row number for two dimensional represenation"; codeType=" "; nciDomainValue=" "; output;
    compType= "attribute"; compName="cellpartno"; compLabel="Position within cell given by row and column number for two dimensional represenation"; codeType=" "; nciDomainValue=" "; output;
    
run;

/* === Code below generated from .csv file as follows ==================== *\

* Program : get-DEMO-Components-orig.sas;
* Purpose : Input data set in XX-Components.csv file and generate as SAS code;

filename csvin "DEMO-Components-orig.csv";

proc import file=csvin dbms=csv out=indsn;
    delimiter= ";";
run;

proc print data=indsn;
run;

data _null_;
    if _n_=1 then do;
        retain fnsas;
        length fnsas $200;
        fnsas= cats(scan(pathname("csvin"),-2,"./\"),".sas.txt");
    end;
    file dummy filevar=fnsas;
    length line $1024;
    set indsn;
    array vn(6) compType compName codeType nciDomainValue compLabel Comment;
    if _n_=1 then do;
        line="length ";
        do i=1 to dim(vn);
            line= catx( " ", line, vname(vn(i)));
            end;
        line=catx(" ", line," $512;");
        put line :;
        end;
    
        do i=1 to dim(vn);
            line= cats(catx("= ", vname(vn(i)), quote(trim(vn(i)))),";");
            put line :;
            end;
        put "output; " /;
run;

\*  ================================================================ */

data skeletonSource2;
length compType compName codeType nciDomainValue compLabel Comment $512;
    
compType= "metadata";
compName= "obsURL";
codeType= " ";
nciDomainValue= " ";
compLabel= "https://phuse-scripts.googlecode.com/svn/trunk/scriptathon2014/data/adsl.xpt";
Comment= "obsFileName";
output; 

compType= "metadata";
compName= "obsFileName";
codeType= " ";
nciDomainValue= " ";
compLabel= "demo.AR.csv";
Comment= "obsFileName";
output; 

compType= "metadata";
compName= "dataCubeFileName";
codeType= " ";
nciDomainValue= " ";
compLabel= "DC-DEMO-R-V";
Comment= "Cube name prefix (will be appended with version number by script. --> No. Will be set in code based on domainName parameter";
output; 

compType= "metadata";
compName= "cubeVersion";
codeType= " ";
nciDomainValue= " ";
compLabel= "0.5.2";
Comment= "Version of cube with format n.n.n";
output; 

compType= "metadata";
compName= "createdBy";
codeType= " ";
nciDomainValue= " ";
compLabel= "Marc Andersen";
Comment= "Person who configures this spreadsheet and runs the creation script to create the cube";
output; 

compType= "metadata";
compName= "description";
codeType= " ";
nciDomainValue= " ";
compLabel= "Data from demo.sas program";
Comment= "Cube description";
output; 

compType= "metadata";
compName= "providedBy";
codeType= " ";
nciDomainValue= " ";
compLabel= "PhUSE Results Metadata Working Group";
Comment= " ";
output; 

compType= "metadata";
compName= "comment";
codeType= " ";
nciDomainValue= " ";
compLabel= "Example demographics table from demo.sas program";
Comment= " ";
output; 

compType= "metadata";
compName= "title";
codeType= " ";
nciDomainValue= " ";
compLabel= "Demographics Analysis Results";
Comment= " ";
output; 

compType= "metadata";
compName= "label";
codeType= " ";
nciDomainValue= " ";
compLabel= "Demographics results data set.";
Comment= " ";
output; 

compType= "metadata";
compName= "wasDerivedFrom";
codeType= " ";
nciDomainValue= " ";
compLabel= "demo.AR.csv";
Comment= "Data source (obsFileName). Set this programmtically based on name of input file!";
output; 

compType= "metadata";
compName= "domainName";
codeType= " ";
nciDomainValue= " ";
compLabel= "DEMO";
Comment= "The domain name, also part of the spreadsheet tab name";
output; 

compType= "metadata";
compName= "obsFileNameDirec";
codeType= " ";
nciDomainValue= " ";
compLabel= "!example";
Comment= "The directory containd the wasDerivedFrom file";
output; 

compType= "metadata";
compName= "dataCubeOutDirec";
codeType= " ";
nciDomainValue= " ";
compLabel= "!temporary";
Comment= " ";
output; 

run;

data skeletonSource;
    set skeletonSource1 skeletonSource2;
run;
    
proc export data=skeletonSource file="../sample-cfg/DEMO-Components.csv" replace;
run;

