# quicksort recursivo, com a instrução "break".

MAX: int = 100000;

array: [MAX] int;

qsort = map (l, r) -> () [
    i := l;
    j := r;
    x := array[(l+r)/2];

    * [ true -> * [ array[i] < x -> i := i+1; ];
	        * [ x < array[j] -> j := j-1; ];
	        ? [ i <= j -> (array[i], array[j]) := (array[j], array[i]);
			      i := i+1;
		              j := j-1; ];
	        ? [ i > j -> break; ] ];

    ? [ l<j -> @ (l, j) ];
    ? [ i<r -> @ (i, r) ];
];

initialize = map () -> () [
    i := 0;
    r := 333;
    * [ i<MAX -> r := (1317 * r) % 214748;
	         array[i] := r;
	         i := i+1; ]
];

program = map () -> () [
    initialize ();
    qsort (0, MAX-1);
]
