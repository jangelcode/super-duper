/* Homework 5 - Question 4 */
dm "output;clear;log;clear;odsresults;clear";
options ls=75 ps=2000 formdlim='*' nodate nonumber nocenter; 

* --- data set ---;
data seizure;
 infile '/home/u58129486/Data/seizures.csv' dlm=',' firstobs=2;
 input id trt age baseline visit1-visit4;
run;

proc print;
run;

%macro univfmt;
data uniseizure (keep=id trt baseline visit cnt cell age); %* only keep the useful variables in the final data set;
 set seizure;           %* create the data set using the previously created seizure data set;   
 baseline = baseline/4; %* adjust for the number of weeks for baseline;
 %do i = 1 %to 4;       %* create two new variables, namely 'visit' and 'cnt';
  visit = &i.;          %* the ith visit;
  cnt = visit&i.;       %* the response at the ith visit;
  cell = cat(trt,visit);%* Use CAT function to create a variable to indicate the (treatment, visit) combination; 
  output;               %* create a record with the current variables in the data set;
 %end;
run;
%mend;

%univfmt; * run the univfmt macro;

data uniseizure;
 set uniseizure;
 logage = log(age);
 logbase = log(baseline); *obtain log(x);
 logcnt=log(cnt+1);       *obtain log(y) but avoid log(y=0);
run;

proc sort data=uniseizure;
 by trt visit;
run;

/* Model Building*/
/* Note that the code below shows us that both relationships appear to be linear 
although we may also consider a higher order term for logbase's relationship with logcnt.*/

ods graphics / AttrPriority=None;
proc sgplot data=uniseizure;
   styleattrs datalinepatterns=(solid);
   loess y=logcnt x=logage / group=cell;
run;

ods graphics / AttrPriority=None;
proc sgplot data=uniseizure;
   styleattrs datalinepatterns=(solid);
   loess y=logcnt x=logbase / group=cell;
run;

*ods trace on;
proc genmod data=uniseizure;
  class id trt visit; 
  model cnt = trt|visit logbase|logage|trt|visit / link=log type3 d=poisson scale=p;
  repeated subject=id(trt) / type=indep within=visit modelse;
  ods select GEEModPEst GEEFitCriteria; *Only present these results;
  ods output GEEModPEst=out1 GEEFitCriteria=out2; *create output data sets for later use;
run;
*ods trace off;

*** From OUT1, we create a macro variable &phi to store the estimated sqrt(\phi);  
***  This will be used later for selecting the error structure; 
proc sql; 
 select estimate into :phi 
 from out1 
 where parm='Scale'; 
quit; 

/*Error Structure*/
proc sql; 
 select value into :QICind 
 from out2 
 where criterion='QIC'; 
quit; 

proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|logage|trt|visit /link=log type3 d=poisson scale=&phi. noscale; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods select GEEFitCriteria; *Only present this result; 
  ods output GEEFitCriteria=out2;  *create output data sets to give the QIC; 
  title "Cov structure: AR(1)"; 
run; 

proc sql; 
 select value into :QICar1 
 from out2 
 where criterion='QIC'; 
quit; 

proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|logage|trt|visit /link=log type3 d=poisson scale=&phi. noscale; 
  repeated subject=id(trt) / type=cs within=visit; 
  ods select GEEFitCriteria;  
  ods output GEEFitCriteria=out2;  
  title "Cov structure: Exchangeable"; 
run; 
 
proc sql; 
 select value into :QICcs 
 from out2 
 where criterion='QIC'; 
quit; 
/*   */
/* proc genmod data=uniseizure;  */
/*   class id trt visit;  */
/*   model cnt= trt|visit logbase|logage|trt|visit  /link=log type3 d=poisson scale=&phi. noscale;  */
/*   repeated subject=id(trt) / type=un within=visit;  */
/*   title "Cov structure: Unstructured";  */
/* run;  */
/* title;  */

data _null_; 
 file print; 
 put "Indep.: &QICind"; 
 put "AR(1) : &QICar1"; 
 put "CS    : &QICcs"; 
run; 



/* Eliminating Terms */
*** In the next step, we reduce the mean model with backward selection and  
    by eliminating higher-order interactions first, if appropriate; 
**** Note. For each model, we also estiamte \phi using the working models to  
           have a better estimate of the standard error; 
*** We use similar methods to obtain QICu's and then compare them; 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|logage|trt|visit /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2;  
run; 
 
proc sql; 
 select value into :q1 
 from out2 
 where criterion='QICu'; 
quit; 

** no four-way interaction; 
** Note. A|B|C @2 = A B C A*B A*C B*C, i.e. up to 3-way interactions; 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|logage|trt|visit @3 /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2;  
run; 
 
proc sql; 
 select value into :q2 
 from out2 
 where criterion='QICu'; 
quit; 

** no three-way interaction; 
** Note. A|B|C @2 = A B C A*B A*C B*C, i.e. up to 2-way interactions; 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|logage|trt|visit @2 /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2;  
run; 
 
proc sql; 
 select value into :q3 
 from out2 
 where criterion='QICu'; 
quit; 

 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|trt logage|trt|visit /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2;  
run; 
 
proc sql; 
 select value into :q4 
 from out2 
 where criterion='QICu'; 
quit; 
 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|visit logage|trt|visit /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2;  
run; 
 
proc sql; 
 select value into :q5 
 from out2 
 where criterion='QICu'; 
quit; 
 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|trt|visit logage|trt /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2;  
run; 
 
proc sql; 
 select value into :q6
 from out2 
 where criterion='QICu'; 
quit; 

proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|trt|visit logage|visit /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2; *create output data sets; 
run; 
 
proc sql; 
 select value into :q7 
 from out2 
 where criterion='QICu'; 
quit; 

proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|trt|visit logage|trt|visit /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2; *create output data sets; 
run; 
 
proc sql; 
 select value into :q8 
 from out2 
 where criterion='QICu'; 
quit;
 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt visit logbase|trt logage|visit /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2; *create output data sets; 
run; 
 
proc sql; 
 select value into :q9 
 from out2 
 where criterion='QICu'; 
quit; 
 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|logage /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2; *create output data sets; 
run; 
 
proc sql; 
 select value into :q10
 from out2 
 where criterion='QICu'; 
quit; 
 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|logage|trt /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2; *create output data sets; 
run; 
 
proc sql; 
 select value into :q11
 from out2 
 where criterion='QICu'; 
quit; 

proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt|visit logbase|logage|visit /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2; *create output data sets; 
run; 
 
proc sql; 
 select value into :q12
 from out2 
 where criterion='QICu'; 
quit; 
 
proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt visit logbase|logage /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2; *create output data sets; 
run; 
 
proc sql; 
 select value into :q13 
 from out2 
 where criterion='QICu'; 
quit; 

proc genmod data=uniseizure; 
  class id trt visit; 
  model cnt= trt visit logbase logage /link=log type3 d=poisson scale=p; 
  repeated subject=id(trt) / type=ar(1) within=visit; 
  ods output GEEFitCriteria=out2; *create output data sets; 
run; 
 
proc sql; 
 select value into :q14 
 from out2 
 where criterion='QICu'; 
quit; 
 
** Compare the QICu for the above models; 
data _null_; 
 file print; 
 put "mean1: &q1"; 
 put "mean2: &q2"; 
 put "mean3: &q3"; 
 put "mean4: &q4"; 
 put "mean5: &q5"; 
 put "mean6: &q6"; 
 put "mean7: &q7"; 
 put "mean8: &q8"; 
 put "mean9: &q9"; 
 put "mean10: &q10"; 
 put "mean11: &q11"; 
 put "mean12: &q12"; 
 put "mean13: &q13"; 
 put "mean14: &q14"; 
run; 
 
 
proc sql; 
 select avg(logbase), avg(logage) into :mlb
 from uniseizure; 
quit; 

ods trace on;
proc genmod data=uniseizure;
  class id trt visit;
  model cnt= trt|visit logbase|trt|visit logage|visit /link=log type3 d=poisson scale=p type3;
  repeated subject=id(trt) / type=ar(1) within=visit corrw;
  contrast 'trt-score' trt 1 -1; *treatment effect at logbase=0 with score method;
  contrast 'trt-wald' trt 1 -1 /wald; *treatment effect at logbase=0 with Wald method;
  estimate 'trt-wald' trt 1 -1 ; *estimates of treatment effect at logbase=0 with Wald method;

  contrast 'trt-score at mean' trt 1 -1 logbase*trt &mlb. - &mlb.;  *score test at logbase=&mlb. (the mean of logbase);
  contrast 'trt-wald at mean' trt 1 -1 logbase*trt &mlb. - &mlb./wald;  *at logbase=&mlb. (the mean of logbase);
  estimate 'trt-wald at mean' trt 1 -1 logbase*trt &mlb. - &mlb.;
  
  contrast 'trt-score at mean' trt 1 -1 logage*trt &mlb. - &mlb.;  *score test at logbase=&mlb. (the mean of logbase);
  contrast 'trt-wald at mean' trt 1 -1 logage*trt &mlb. - &mlb./wald;  *at logbase=&mlb. (the mean of logbase);
  estimate 'trt-wald at mean' trt 1 -1 logage*trt &mlb. - &mlb.;
  
  ods select Estimates Contrasts;
run;
ods trace off;




