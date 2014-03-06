# reverse an array.

program = map () -> bool [
    ar : [100] int;
    n := read_int ();

    k := 0;
    * [ k < n -> ar[k] := read_int(); k := k+1 ];

    ? [ read_int() = 1 -> i := 0;
		        * [ i < n/2 -> (ar[i], ar[n-i-1]) := (ar[n-i-1], ar[i]);
				     write_int(i); write_char(10);
				     i := i+1; ] ];

    k := 0;
    * [ k < n -> write_int(ar[k]); write_char(32); k := k+1; ];
    write_char(10);
]
