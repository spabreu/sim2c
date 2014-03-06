showString = map (s) -> () [
    writeString ("\""); writeString (s); writeString ("\"")
];

compare = map (s1, s2, op; v) -> () [
    showString (s1); writeString (op); showString (s2);
    writeString (" <=> "); writeBool (v);
    writeString (".\n")
];

a, b: string;

readStrings = map () -> bool [
    writeString ("String 1: ");
    a := readString();
    ? [ a = "" -> ^ false
      |   *    -> writeString ("String 2: ");
		  b := readString();
		  ^ true ]
];

program = map () -> () [
    * [ readStrings() -> compare(a, b, " <  ",  a<b);
			 compare(a, b, " <= ", a<=b);
			 compare(a, b, " =  ",  a=b);
			 compare(a, b, " ~= ", a~=b);
			 compare(a, b, " >= ", a>=b);
			 compare(a, b, " >  ",  a>b);
			 writeString("\n") ]
]
