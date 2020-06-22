% Filling trucks for a magic factory, part 1.
% Eight trucks have to deliver pallets of obscure building blocks to a magic factory. 
% Every truck has a capacity of 8000 kg and can carry at most eight pallets. In total, the following has to be delivered:

% •Four pallets of nuzzles, each of weight 800 kg.

% •A number of pallets of prittles, each of weight 1100 kg.

% •Eight pallets of skipples, each of weight 1000 kg.

% •Ten pallets of crottles, each of weight 2500 kg.

% •Twenty pallets of dupples, each of weight 200 kg.

% Skipples need to be cooled; only three of the eight trucks have the facility for cooling skipples.

% Nuzzles are very valuable; to distribute the risk of loss no two pallets of nuzzles may be in the same truck.

% Investigate what is the maximum number of pallets of prittles that can be delivered.

% (Hint: if you do not use the maximize command, you may run the tool several times and do a binary search to find the right value)

set of int: TRUCK = 1..8;
set of int: PALLETE = 1..5;

int: capacity = 8000;
set of int: LOAD = 0..capacity;

int: max_palletes = 8;

int: NUZZLES = 1;
int: PRITTLES = 2;
int: SKIPPLES = 3;
int: CROTTLES = 4;
int: DUPPLES = 5;

array[PALLETE] of int: pallete_size = [800, 1100, 1000, 2500, 200];

array[PALLETE] of var int: pallete_num = [4, _, 8, 10, 20];

int: cooling_trucks = 3;

% Truck load
array[TRUCK, PALLETE] of var LOAD: load;

% Satisfy the reqs for the number of palletes. 
constraint forall(p in PALLETE)(
  sum(load[.., p]) = pallete_num[p]
);

% Satisfy the load reqs.
array[TRUCK] of var LOAD: truck_load;
constraint forall(t in TRUCK)(
  truck_load[t] = sum(p in PALLETE)(load[t,p]*pallete_size[p])
);

constraint forall(t in TRUCK)(
  truck_load[t] <=capacity
);

% Only 3 (cooling) trucks can carry Skipples
constraint sum(t in TRUCK)(load[t, SKIPPLES] > 0) <= 3;

% No more than 1 Nuzzle can be in a truck
constraint forall(t in TRUCK)(load[t, NUZZLES] <=1);

% Part 2: Prittles and crottles are an explosive combination: they are not allowed to be put in the same truck.
constraint forall(t in TRUCK)(load[t, PRITTLES] * load[t, CROTTLES] = 0);

solve maximize pallete_num[PRITTLES];

output ["\(load[i,j])" ++ if j = 5 then "\n" else ".." endif | i in TRUCK, j in PALLETE];

output ["prittles: \(pallete_num[PRITTLES])\n"]; 
output ["truck loads: \(truck_load)\n"];
output ["trucks with Skipples: \([t | t in TRUCK where (load[t, SKIPPLES] > 0)])\n"];