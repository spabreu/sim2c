# reverse an array -- global variables.

ar : [100] int;

rev = map (n: int) -> bool [
    i := 0;
    * [ i < n/2 -> (ar[i], ar[n-i-1]) := (ar[n-i-1], ar[i]);
		   write_int(i); write_char(10);
		   i := i+1; ] ]

program = map () [
    n := read_int ();

    k := 0;
    * [ k < n -> ar[k] := read_int(); k := k+1; ]

    ? [ read_bool() -> rev (n); ]

    k := 0;
    * [ k < n -> write_int(ar[k]); write_char(32); k := k+1; ]
    write_char(10); ]
