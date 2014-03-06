fact = map (i) [
	? [ i<1 -> ^ 1;
	  |  *  -> ^ i * @ (i-1); ]
]

xfact = map (i) [
	? [ i<1 -> return 1;
	  |  *  -> return i * xfact (i-1); ]
]

program = map () -> () [
	* [ read_bool() -> i := read_int (); write_int (i); write_char(32);
			   write_int (fact (i)); write_char(32);
	   		   write_int (xfact(i)); write_char(10); ] ]
