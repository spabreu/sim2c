# recursive quicksort

array: [100] int;	# array com os valores
size:  int;		# quantos elementos?

qsort = map (l, r) -> () [
    i := l;
    j := r;
    x := array[(l+r)/2];

    more := true;
    * [ more -> * [ array[i] < x -> i := i+1 ];
	        * [ x < array[j] -> j := j-1 ];
	        ? [ i <= j -> (array[i], array[j]) := (array[j], array[i]);
			      (i, j) := (i+1, j-1) ] ;
		more := i <= j ];

    ? [ l<j -> @ (l, j) ];
    ? [ i<r -> @ (i, r) ]
];

read_data = map () -> () [
    size := read_int ();

    i := 0;
    * [ i<size -> array[i] := read_int(); i := i+1 ];
];

write_data = map () -> () [
    write_char(10);
    i := 0;
    * [ i<size -> write_int(array[i]);
		  write_char(10);
		  i := i+1 ]
];

program = map () -> () [
    read_data ();
    ? [ read_bool () -> qsort (0, size-1) ];
    write_data ()
]
