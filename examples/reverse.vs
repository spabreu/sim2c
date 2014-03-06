# reverse an array.

rev = map (ar:[100] int; n: int) -> [100] int [
    i := 0;
    * [ i < n/2 -> (ar[i], ar[n-i-1]) := (ar[n-i-1], ar[i]);
		   write_int(i); write_char(10);
		   i := i+1; ];
    return ar; ]

program = map () [
    x : [100] int;

    n := read_int ();

    k := 0;
    * [ k < n -> x[k] := read_int(); k := k+1; ];

    ? [ read_bool() -> x := rev (x, n); ];

    k := 0;
    * [ k < n -> write_int(x[k]); write_char(32); k := k+1; ];
    write_char(10); ]
