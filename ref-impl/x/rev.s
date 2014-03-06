# reverse an array.

program = map () -> bool [
    ar : [100] int;
    n := readInt ();

    k := 0;
    * [ k < n -> ar[k] := readInt(); k := k+1 ];

    ? [ readBool() -> i := 0;
		      * [ i < n/2 -> (ar[i], ar[n-i-1]) := (ar[n-i-1], ar[i]);
				     writeInt(i); writeChar(10);
				     i := i+1 ] ];

    k := 0;
    * [ k < n -> writeInt(ar[k]); writeChar(32); k := k+1 ];
    writeChar(10)
]
