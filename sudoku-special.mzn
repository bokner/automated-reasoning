%% Special variant of Sudoku.
int: S = 3;
int: N = S*S;
set of int: DIGITS = 1..N;
array[DIGITS, DIGITS] of var DIGITS: sudoku;

include "all_different.mzn";

% rows and columns
constraint forall(i in DIGITS)(
  all_different(row(sudoku, i)) /\
  all_different(col(sudoku, i))
);  

% 3x3 squares
constraint all_different([sudoku[1,1], sudoku[1,2], sudoku[1,3], sudoku[2,1], sudoku[2,2], sudoku[2,3], sudoku[3,1], sudoku[3,2], sudoku[3,3]]);
constraint all_different([sudoku[1,4], sudoku[1,5], sudoku[1,6], sudoku[2,4], sudoku[2,5], sudoku[2,6], sudoku[3,4], sudoku[3,5], sudoku[3,6]]);
constraint all_different([sudoku[1,7], sudoku[1,8], sudoku[1,9], sudoku[2,7], sudoku[2,8], sudoku[2,9], sudoku[3,7], sudoku[3,8], sudoku[3,9]]);

constraint all_different([sudoku[4,1], sudoku[4,2], sudoku[4,3], sudoku[5,1], sudoku[5,2], sudoku[5,3], sudoku[6,1], sudoku[6,2], sudoku[6,3]]);
constraint all_different([sudoku[4,4], sudoku[4,5], sudoku[4,6], sudoku[5,4], sudoku[5,5], sudoku[5,6], sudoku[6,4], sudoku[6,5], sudoku[6,6]]);
constraint all_different([sudoku[4,7], sudoku[4,8], sudoku[4,9], sudoku[5,7], sudoku[5,8], sudoku[5,9], sudoku[6,7], sudoku[6,8], sudoku[6,9]]);

constraint all_different([sudoku[7,1], sudoku[7,2], sudoku[7,3], sudoku[8,1], sudoku[8,2], sudoku[8,3], sudoku[9,1], sudoku[9,2], sudoku[9,3]]);
constraint all_different([sudoku[7,4], sudoku[7,5], sudoku[7,6], sudoku[8,4], sudoku[8,5], sudoku[8,6], sudoku[9,4], sudoku[9,5], sudoku[9,6]]);
constraint all_different([sudoku[7,7], sudoku[7,8], sudoku[7,9], sudoku[8,7], sudoku[8,8], sudoku[8,9], sudoku[9,7], sudoku[9,8], sudoku[9,9]]);

%% Consecutive cells
constraint sudoku[1,2] - sudoku[1,3] in {-1, 1};
constraint sudoku[1,4] - sudoku[1,5] in {-1, 1};
constraint sudoku[1,7] - sudoku[1,8] in {-1, 1};
constraint sudoku[1,6] - sudoku[2,6] in {-1, 1};
constraint sudoku[2,7] - sudoku[3,7] in {-1, 1};

constraint sudoku[3,2] - sudoku[3,3] in {-1, 1};
constraint sudoku[3,4] - sudoku[3,5] in {-1, 1};
constraint sudoku[3,6] - sudoku[3,5] in {-1, 1};
constraint sudoku[3,7] - sudoku[4,7] in {-1, 1};
constraint sudoku[3,9] - sudoku[4,9] in {-1, 1};

constraint sudoku[4,3] - sudoku[5,3] in {-1, 1};
constraint sudoku[4,7] - sudoku[5,7] in {-1, 1};
constraint sudoku[4,9] - sudoku[5,9] in {-1, 1};

constraint sudoku[5,1] - sudoku[5,2] in {-1, 1};
constraint sudoku[5,2] - sudoku[5,3] in {-1, 1};
constraint sudoku[5,4] - sudoku[5,5] in {-1, 1};
constraint sudoku[5,6] - sudoku[5,7] in {-1, 1};
constraint sudoku[5,8] - sudoku[5,9] in {-1, 1};

constraint sudoku[6,3] - sudoku[6,4] in {-1, 1};

constraint sudoku[6,3] - sudoku[7,3] in {-1, 1};
constraint sudoku[6,4] - sudoku[7,4] in {-1, 1};
constraint sudoku[6,6] - sudoku[7,6] in {-1, 1};
constraint sudoku[6,7] - sudoku[7,7] in {-1, 1};

constraint sudoku[7,3] - sudoku[7,4] in {-1, 1};

constraint sudoku[8,6] - sudoku[8,7] in {-1, 1};

% Inequalities
include "increasing.mzn";

constraint increasing([sudoku[2,j] | j in 4..9]);
constraint increasing([sudoku[4,j] | j in 1..6]);

constraint increasing([sudoku[6,j] | j in 4..9]);
constraint increasing([sudoku[8,j] | j in 1..6]);

solve satisfy;


output [ "sudoku:\n" ] ++
    [ show(sudoku[i,j]) ++
        if j = N then
            if i mod S = 0 /\ i < N then "\n\n" else "\n" endif
        else
            if j mod S = 0 then "  " else " " endif
        endif
    | i,j in 1..N ];