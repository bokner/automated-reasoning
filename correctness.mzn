% Consider the following program:

% a := 1; b := 1;

% for i := 1 to 10 do

% if ? then {a := a+2b; b := b+i} else {b := a+b; a := a+i};

% if b = 600+n then crash

% Here '?' is an unknown test that may yield false or true in any situation.

% Establish for which values of n = 1,2...,10 it is safe, that is, will not reach 'crash'.

int: steps = 10;
set of int: STEP = 0..steps;

array[STEP] of var 1..10000: a;
array[STEP] of var 1..10000: b;

%
var STEP: n;

constraint a[0] = 1;
constraint b[0] = 1;

constraint forall(s in 1..steps)(
  (
    (a[s] = a[s-1] + 2*b[s-1]) /\ (b[s] = b[s-1] + s) 
  )  
    \/
  (
    (b[s] = a[s-1] + b[s-1]) /\ (a[s] = a[s-1] + s)
    
  )
);


% Run n = 1..10 to find UNSATISFIABLE values
constraint n = 5;

constraint b[steps] = 600 + n;                                

