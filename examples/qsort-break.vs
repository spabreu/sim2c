# recursive quicksort, use break.

array: [100] { key: int; data: real; };
size:  int;

qsort = map (l, r) -> () [
    (i, j) := (l, r);
    x := array[(l+r)/2];

    * [ true -> * [ array[i].key < x.key -> i := i+1; ]
		* [ x.key < array[j].key -> j := j-1; ]
		? [ i <= j -> (array[i], array[j]) := (array[j], array[i]);
			      (i, j) := (i+1, j-1); ]
		? [ i > j -> break 1; ] ]

    ? [ l<j -> @ (l, j); ]
    ? [ i<r -> @ (i, r); ] ]

read_data = map () -> () [
    write_string ("Number of items? "); size := read_int ();

    i := 0;
    * [ i<size -> write_string ("Item "); write_int (i+1); write_string("? ");
		  array[i].key := read_int();
		  i := i+1; ]

    (i, j, k) := (0, 0.5, 1.5);
    * [ i<size -> array[i].data := j+k;
		  (j, k) := (k, j+k);
		  i := i+1; ] ]

write_data = map () -> () [
    write_char(10);
    i := 0;
    * [ i<size -> write_string ("New element "); write_int(i+1);
		  write_string (": (");
		  write_int(array[i].key);
		  write_string(", ");
		  write_real(array[i].data);
		  write_string(")\n");
		  i := i+1; ] ]

program = map () -> () [
    read_data ();
    qsort (0, size-1);
    write_Data (); ]
