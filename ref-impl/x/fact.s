fact = map (i) [
	? [ i<0 -> return 0
	  | i=0 -> return 1
	  |  *  -> return i * fact (i-1) ]
];

ifact = map (i) [
	res := 1;
	k := i;
	* [ k > 0 -> res := res*k;
		     k := k-1 ];
	return (res)
];

program = map () -> () [
	* [ readBool() -> i := readInt (); writeInt (i); writeChar(10);
			   writeInt (ifact (i)); writeChar(32);
			   writeInt (fact (i));  writeChar(10) ] ]
