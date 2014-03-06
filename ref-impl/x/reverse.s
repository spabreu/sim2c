# reverse an array.

rev = map (ar:[100] int; n: int) -> [100] int [
    i := 0;
    * [ i < n/2 -> (ar[i], ar[n-i-1]) := (ar[n-i-1], ar[i]);
		   writeInt(i); writeChar(10);
		   i := i+1 ];
    return ar
];

program = map () [
    x : [100] int;

    n := readInt ();

    k := 0;
    * [ k < n -> x[k] := readInt(); k := k+1 ];

    ? [ readBool() -> x := rev (x, n) ];

    k := 0;
    * [ k < n -> writeInt(x[k]); writeChar(32); k := k+1 ];
    writeChar(10)
]
