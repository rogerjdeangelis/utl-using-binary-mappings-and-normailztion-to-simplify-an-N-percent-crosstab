Using binary mappings and normailztion to simplify an N percent crosstab                                                                    
                                                                                                                                            
github                                                                                                                                      
https://tinyurl.com/y4tqtrys                                                                                                                
https://github.com/rogerjdeangelis/utl-using-binary-mappings-and-normailztion-to-simplify-an-N-percent-crosstab                             
                                                                                                                                            
Problenm: Calculate miss/populated n/percent for all variables by state and send.                                                           
                                                                                                                                            
SASA Forum                                                                                                                                  
https://tinyurl.com/y6esnrb3                                                                                                                
https://communities.sas.com/t5/SAS-Programming/Calculate-percentages-for-each-variable-in-a-Dataset/m-p/672917                              
                                                                                                                                            
There are a couple of problems with the post                                                                                                
                                                                                                                                            
  1. I assume State is always populated.                                                                                                    
                                                                                                                                            
  2. For State=AL SEND=. Count of missing Xs cannot be 4  (it should be 3)                                                                  
                                                                                                                                            
    State Send  X   Y                                                                                                                       
                                                                                                                                            
      AL   Y    1   .                                                                                                                       
      AL   Y    2   .                                                                                                                       
      AL   Y    .   .                                                                                                                       
                                                                                                                                            
      AL   .    .   .                                                                                                                       
      AL   .    .   .                                                                                                                       
      AL   .    .   .                                                                                                                       
                                                                                                                                            
                                                                                                                                            
       State = AL                                                                                                                           
       Send=Y      Send=.      Send=Y      Send=.       Total Records                                                                       
       Count      Count      Percentage      Percentage                                                                                     
                                                                                                                                            
X      2           4**(3)      33.33           66.66           6                                                                            
                                                                                                                                            
                                                                                                                                            
I have reformulated the problem                                                                                                             
                                                                                                                                            
Calculate the count of records populated and percentage of each variable populated/missing and Send = Y or Send=.;                          
                                                                                                                                            
Note there are four possibilities for SEND=(pop/mis) and a variable(pop/mis)                                                                
                                                                                                                                            
    CNT_SPEND_POP_VAR_POP                                                                                                                   
    CNT_SPEND_POP_VAR_MIS                                                                                                                   
    CNT_SPEND_MIS_VAR_POP                                                                                                                   
    CNT_SPEND_MIS_VAR_MIS                                                                                                                   
                                                                                                                                            
I let the OP decide which counts and percentages he/she might want to combine.                                                              
                                                                                                                                            
   Technique                                                                                                                                
                                                                                                                                            
        1. For simplicity normalize into var/val                                                                                            
                                                                                                                                            
        2. create binany strings pop/miss( 00, 01, 10 and 11) for all spend*var combinations                                                
           After that there are many ways to get frequencies abd percents,                                                                  
           see https://github.com/rogerjdeangelis?tab=repositories&q=n+percent+&type=&language=                                             
                                                                                                                                            
                                                                                                                                            
/*                   _                                                                                                                      
(_)_ __  _ __  _   _| |_                                                                                                                    
| | `_ \| `_ \| | | | __|                                                                                                                   
| | | | | |_) | |_| | |_                                                                                                                    
|_|_| |_| .__/ \__,_|\__|                                                                                                                   
        |_|                                                                                                                                 
*/                                                                                                                                          
                                                                                                                                            
                                                                                                                                            
data have;                                                                                                                                  
 retain state;                                                                                                                              
 informat spend X Y C state $3.;                                                                                                            
 input spend X Y C State;                                                                                                                   
cards4;                                                                                                                                     
P 1 . 100 AL                                                                                                                                
P 2 . 28 AL                                                                                                                                 
P . . 56 AL                                                                                                                                 
. . . 55 AL                                                                                                                                 
. . . 77 AL                                                                                                                                 
. . . 30 AL                                                                                                                                 
P 10 25 44 PA                                                                                                                               
P 20 32 89 PA                                                                                                                               
P 30 43 78 PA                                                                                                                               
. 40 27 43 PA                                                                                                                               
. . 10 22 PA                                                                                                                                
. . . 34 PA                                                                                                                                 
;;;;                                                                                                                                        
run;quit;                                                                                                                                   
                                                                                                                                            
Up to 40 obs WORK.HAVE total obs=12                                                                                                         
                                                                                                                                            
Obs    STATE    SPEND    X     Y      C                                                                                                     
                                                                                                                                            
  1     AL        P      1           100                                                                                                    
  2     AL        P      2           28                                                                                                     
  3     AL        P                  56                                                                                                     
  4     AL                           55                                                                                                     
  5     AL                           77                                                                                                     
  6     AL                           30                                                                                                     
  7     PA        P      10    25    44                                                                                                     
  8     PA        P      20    32    89                                                                                                     
  9     PA        P      30    43    78                                                                                                     
 10     PA               40    27    43                                                                                                     
 11     PA                     10    22                                                                                                     
 12     PA                           34                                                                                                     
                                                                                                                                            
/*          _                                                                                                                               
 _ __ _   _| | ___  ___                                                                                                                     
| `__| | | | |/ _ \/ __|                                                                                                                    
| |  | |_| | |  __/\__ \                                                                                                                    
|_|   \__,_|_|\___||___/                                                                                                                    
                                                                                                                                            
*/                                                                                                                                          
                                                                                                                                            
 The Count for State=AL when SPEND is populated and X is populated = 2                                                                      
                                                                                                                                            
  STATE  SPEND   X                                                                                                                          
                                                                                                                                            
   AL      P     1                                                                                                                          
   AL      P     2                                                                                                                          
   AL      P                                                                                                                                
   AL                                                                                                                                       
   AL                                                                                                                                       
   AL                                                                                                                                       
                                                                                                                                            
  For X  CNT_SPEND_POP_VAR_POP = 2  Percent 2/6 = 33%                                                                                       
  For X  CNT_SPEND_POP_VAR_MIS = 1                                                                                                          
  For X  CNT_SPEND_MIS_VAR_POP = 0                                                                                                          
  For X  CNT_SPEND_MIS_VAR_MIS = 3                                                                                                          
                                                                                                                                            
                                                                                                                                            
data havNrm /*(where=(var='sendx'))*/;                                                                                                      
                                                                                                                                            
 length val $2.;                                                                                                                            
                                                                                                                                            
 set have;                                                                                                                                  
                                                                                                                                            
 var='X';val=cats((not missing(spend)),(not missing(x)));output;                                                                            
 var='y';val=cats((not missing(spend)),(not missing(y)));output;                                                                            
 var='c';val=cats((not missing(spend)),(not missing(c)));output;                                                                            
                                                                                                                                            
 drop spend x  y c;                                                                                                                         
                                                                                                                                            
run;quit;                                                                                                                                   
                                                                                                                                            
/* for checking                                                                                                                             
 proc sort data=havNrm(where=(var='X')) out=delete;                                                                                         
 by state var;                                                                                                                              
 run;quit;                                                                                                                                  
                                                                                                                                            
Up to 40 obs WORK.DELETE total obs=12                                                                                                       
                                                                                                                                            
Obs    VAL    STATE    VAR                                                                                                                  
                                                                                                                                            
  1    11      AL       X                                                                                                                   
  2    11      AL       X  POP POP 2  (val and state populated)                                                                             
                                                                                                                                            
  3    10      AL       X  POP MIS 1                                                                                                        
                                                                                                                                            
  4    00      AL       X  MIs MIS 3                                                                                                        
  5    00      AL       X                                                                                                                   
  6    00      AL       X                                                                                                                   
                           MIS POP 0                                                                                                        
*/                                                                                                                                          
                                                                                                                                            
ods exclude all;                                                                                                                            
Ods Output rowprofiles = wantpct;                                                                                                           
ods output observed    = wantcnt;                                                                                                           
proc corresp data=havnrm dim=1 observed outf=outf all print=both missing;                                                                   
by state;                                                                                                                                   
tables var, val;                                                                                                                            
run;quit;                                                                                                                                   
ods select all;                                                                                                                             
                                                                                                                                            
data want;                                                                                                                                  
  format pct: 6.3;                                                                                                                          
  merge                                                                                                                                     
     wantcnt(where=(label ne 'Sum') rename=(                                                                                                
         _11=CNT_SPEND_POP_VAR_POP                                                                                                          
         _10=CNT_SPEND_POP_VAR_MIS                                                                                                          
         _01=CNT_SPEND_MIS_VAR_POP                                                                                                          
         _00=CNT_SPEND_MIS_VAR_MIS ))                                                                                                       
     wantpct(rename=(                                                                                                                       
         _11=PCT_SPEND_POP_VAR_POP                                                                                                          
         _10=PCT_SPEND_POP_VAR_MIS                                                                                                          
         _01=PCT_SPEND_MIS_VAR_POP                                                                                                          
         _00=PCT_SPEND_MIS_VAR_MIS ))                                                                                                       
   ;                                                                                                                                        
run;quit;                                                                                                                                   
                                                                                                                                            
                                                                                                                                            
 WORK.WANT total obs=6                                                                                                                      
                                                                                                                                            
                         CNT_SPEND_    CNT_SPEND_    CNT_SPEND_    CNT_SPEND_           PCT_SPEND_    PCT_SPEND_    PCT_SPEND_    PCT_SPEND_
                          MIS_VAR_      MIS_VAR_      POP_VAR_      POP_VAR_             MIS_VAR_      MIS_VAR_      POP_VAR_      POP_VAR_ 
Obs    STATE    LABEL        MIS           POP           MIS           POP       SUM        MIS           POP           MIS           POP   
                                                                                                                                            
 1      AL        X           3             0             1             2         6       0.50000       0.00000       0.16667       0.33333 
 2      AL        c           0             3             0             3         6       0.00000       0.50000       0.00000       0.50000 
 3      AL        y           3             0             3             0         6       0.50000       0.00000       0.50000       0.00000 
 4      PA        X           2             1             .             3         6       0.33333       0.16667        .            0.50000 
 5      PA        c           0             3             .             3         6       0.00000       0.50000        .            0.50000 
 6      PA        y           1             2             .             3         6       0.16667       0.33333        .            0.50000 
                                                                                                                                            
                                                                                                                                            
                                                                                                                                            
