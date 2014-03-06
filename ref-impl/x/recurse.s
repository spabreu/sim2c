fact = map (i) [
	? [ i<1 -> ^ 1
	  |  *  -> ^ i * @ (i-1) ]
];

xfact = map (i) [
	? [ i<1 -> return 1
	  |  *  -> return i * xfact (i-1) ]
];

program = map () -> () [
	* [ readBool() -> i := readInt (); writeInt (i); writeChar(32);
			  writeInt (fact (i)); writeChar(32);
	   		  writeInt (xfact(i)); writeChar(10) ] ]
