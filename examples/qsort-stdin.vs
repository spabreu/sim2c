# recursive quicksort

array: [100] { key: string; data: int; };
size:  int;

qsort = map (l, r) -> () [
    (i, j) := (l, r);
    x := array[(l+r)/2];

    more := true;
    * [ more -> * [ array[i].key < x.key -> i := i+1; ]
		* [ x.key < array[j].key -> j := j-1; ]
		? [ i <= j -> (array[i], array[j]) := (array[j], array[i]);
			      (i, j) := (i+1, j-1); ]
		more := i <= j; ]

    ? [ l<j -> qsort (l, j); ]
    ? [ i<r -> qsort (i, r); ] ]

read_data = map () -> () [
    i := 0;
    something := true;
    * [ (i<100) & something -> array[i].key  := read_string();
			       array[i].data := i;
			       something := array[i].key ~= "";
			       i := i+1; ]
    size := i-1; ]

write_data = map () -> () [
    i := 0;
    * [ i<size -> write_int(array[i].data);
		  write_string("\t");
		  write_string(array[i].key);
		  write_char(10);
		  i := i+1; ] ]

program = map () -> () [
    read_data ();
    qsort (0, size-1);
    write_data (); ]
