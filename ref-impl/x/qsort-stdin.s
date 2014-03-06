# recursive quicksort

array: [100] { key: string; data: int };
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
    i := 0;
    something := true;
    * [ (i<100) and something -> array[i].key  := readString();
				 array[i].data := i;
				 something := array[i].key ~= "";
				 i := i+1 ];
    size := i-1
];

writeData = map () -> () [
    i := 0;
    * [ i<size -> writeInt(array[i].data);
		  writeString("\t");
		  writeString(array[i].key);
		  writeChar(10);
		  i := i+1 ]
];

program = map () -> () [
    readData ();
    qsort (0, size-1);
    writeData ()
]
