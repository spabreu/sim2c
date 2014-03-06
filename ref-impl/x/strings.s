program = map () -> () [
	writeString ("Hi there.\n");
	more := true;
	* [ more -> writeString("? ");
		    s := readString();
		    writeString("You typed: \"");
		    writeString(s);
		    writeString("\".\n");
		    more := s ~= "" ];
	writeString ("See you around.\n");
]
