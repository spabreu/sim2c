# recursive quicksort, use break.

array: [100] { key: int; data: real };
size:  int;

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

readData = map () -> () [
    writeString ("Number of items? "); size := readInt ();

    i := 0;
    * [ i<size -> writeString ("Item "); writeInt (i+1); writeString("? ");
		  array[i].key := readInt();
		  i := i+1 ];

    (i, j, k) := (0, 0.5, 1.5);
    * [ i<size -> array[i].data := j+k;
		  (j, k) := (k, j+k);
		  i := i+1 ]
];

writeData = map () -> () [
    writeChar(10);
    i := 0;
    * [ i<size -> writeString ("New element "); writeInt(i+1);
		  writeString (": (");
		  writeInt(array[i].key);
		  writeString(", ");
		  writeReal(array[i].data);
		  writeString(")\n");
		  i := i+1 ]
];

program = map () -> () [
    readData ();
    qsort (0, size-1);
    writeData ()
]
