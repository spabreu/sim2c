# recursive quicksort

array: [100] { key: int; data: real };
size:  int;

qsort = map (l, r) -> () [
    (i, j) := (l, r);
    x := array[(l+r)/2];

    more := true;
    * [ more -> * [ array[i].key < x.key -> i := i+1 ];
		* [ x.key < array[j].key -> j := j-1 ];
		? [ i <= j -> (array[i], array[j]) := (array[j], array[i]);
			      (i, j) := (i+1, j-1) ];
		more := i <= j ];

    ? [ l<j -> qsort (l, j) ];
    ? [ i<r -> qsort (i, r) ]
];

readData = map () -> () [
    size := readInt ();

    i := 0;
    * [ i<size -> array[i].key := readInt(); i := i+1 ];

    (i, j, k) := (0, 0.5, 1.5);
    * [ i<size -> array[i].data := j+k;
		  (j, k) := (k, j+k);
		  i := i+1 ]
];

writeData = map () -> () [
    writeChar(10);
    i := 0;
    * [ i<size -> writeInt(array[i].key);
		  writeChar(32);
		  writeReal(array[i].data);
		  writeChar(10);
		  i := i+1 ]
];

program = map () -> () [
    readData ();
    ? [ readBool () -> qsort (0, size-1) ];
    writeData ()
]
