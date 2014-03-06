# recursive quicksort

array: [100] { key: int; data: real };
size:  int;

qsort = map (l, r) -> () [
    i := l;
    j := r;
    x := array[(l+r)/2];

    more := true;
    * [ more -> * [ array[i].key < x.key -> i := i+1 ];
	       * [ x.key < array[j].key -> j := j-1 ];
	       ? [ i <= j -> t := array[i]; array[i] := array[j]; array[j] := t;
			   i := i+1;
			   j := j-1 ];
		more := i <= j ];

    ? [ l<j -> @ (l, j) ];
    ? [ i<r -> @ (i, r) ]
];

read_data = map () -> () [
    size := read_int ();

    i := 0;
    * [ i<size -> array[i].key := read_int(); i := i+1 ];

    i := 0;
    j := 0.5;
    k := 1.5;
    * [ i<size -> array[i].data := j+k;
		t := j;
		j := k;
		k := t+k;
		i := i+1 ]
];

write_data = map () -> () [
    write_char(10);
    i := 0;
    * [ i<size -> write_int(array[i].key);
		write_char(32);
		write_real(array[i].data);
		write_char(10);
		i := i+1 ]
];

program = map () -> () [
    read_data ();
    ? [ read_bool () -> qsort (0, size-1) ];
    write_data ()
]
