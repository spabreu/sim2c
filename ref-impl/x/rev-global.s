# reverse an array -- global variables.

ar : [100] int;

rev = map (n: int) -> bool [
    i := 0;
    * [ i < n/2 -> (ar[i], ar[n-i-1]) := (ar[n-i-1], ar[i]);
		   writeInt(i); writeChar(10);
		   i := i+1 ]
];

program = map () [
    n := readInt ();

    k := 0;
    * [ k < n -> ar[k] := readInt(); k := k+1 ];

    ? [ readBool() -> rev (n) ];

    k := 0;
    * [ k < n -> writeInt(ar[k]); writeChar(32); k := k+1 ];
    writeChar(10)
]
