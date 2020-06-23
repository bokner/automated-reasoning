% Job scheduling.

% Ten jobs numbered from 1 to 10 have to be executed without interrupt, and satisfying the following requirements:

% • The running time of job i is i + 10, for i = 1, 2, . . . , 10.

% • Job 3 may only start if jobs 1 and 2 have been finished.

% • Job 6 may only start if jobs 2 and 4 have been finished.

% • Job 7 may only start if jobs 1, 4 and 5 have been finished.

% • Job 8 may only start if jobs 3 and 6 have been finished.

% • Job 9 may only start if jobs 6 and 7 have been finished.

% • Job 10 may only start if jobs 8 and 9 have been finished.

% What is the minimal total running time?

int: jobs = 10;
set of int: JOB = 1..jobs;

array[JOB] of 11..20: running_time = [i+10 | i in JOB];
array[JOB] of var 0..sum(running_time) - min(running_time): start_time;

array[JOB] of var min(running_time)..sum(running_time): end_time;

constraint forall(j in JOB)(
  end_time[j] = start_time[j] + running_time[j]
);

% • Job 3 may only start if jobs 1 and 2 have been finished.
constraint start_time[3] >= end_time[1];
constraint start_time[3] >= end_time[2]; 

% • Job 6 may only start if jobs 2 and 4 have been finished.
constraint start_time[6] >= end_time[2];
constraint start_time[6] >= end_time[4]; 

% • Job 7 may only start if jobs 1, 4 and 5 have been finished.
constraint start_time[7] >= end_time[1];
constraint start_time[7] >= end_time[4];
constraint start_time[7] >= end_time[5];

% • Job 8 may only start if jobs 3 and 6 have been finished.
constraint start_time[8] >= end_time[3];
constraint start_time[8] >= end_time[6];
 
% • Job 9 may only start if jobs 6 and 7 have been finished.
constraint start_time[9] >= end_time[6];
constraint start_time[9] >= end_time[7]; 

% • Job 10 may only start if jobs 8 and 9 have been finished.
constraint start_time[10] >= end_time[8];
constraint start_time[10] >= end_time[9];

% Part 2: additionally it is required that job 7 should not start earlier than job 8.
constraint start_time[7] >= start_time[8];

% Part 3: additionally it is required that jobs 3, 4 and 5 
% are never allowed to run at the same time, since they need a special equipment of which only one copy is available.
constraint (start_time[3] >= end_time[4]) \/ (start_time[4] >= end_time[3]);
constraint (start_time[3] >= end_time[5]) \/ (start_time[5] >= end_time[3]);
constraint (start_time[4] >= end_time[5]) \/ (start_time[5] >= end_time[4]);  

 % Minimize total time
 solve minimize max(end_time); 