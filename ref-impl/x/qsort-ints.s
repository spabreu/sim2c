# recursive quicksort, use break.

MAX: int = 100000;

array: [MAX] { key: int; data: real };

qsort = map (l, r) -> () [
    (i, j) := (l, r);
    x := array[(l+r)/2];

    * [ true -> * [ array[i].key < x.key -> i := i+1 ];
		* [ x.key < array[j].key -> j := j-1 ];
		? [ i <= j -> (array[i], array[j]) := (array[j], array[i]);
			      (i, j) := (i+1, j-1) ];
		? [ i > j -> break 1 ] ];

    ? [ l<j -> @ (l, j) ];
    ? [ i<r -> @ (i, r) ]
];

initialize = map () -> () [
    (i, r, j) := (0, 333, 0.5);
    * [ i<MAX -> r := (1317 * r) % 214748;
		 array[i] := (r, j*3.0);
		 j := j+0.5;
		 i := i+1 ]
];

program = map () -> () [
    initialize ();
    qsort (0, MAX-1);
]
