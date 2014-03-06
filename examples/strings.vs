program = map () -> () [
	write_string ("Hi there.\n");
	more := true;
	* [ more -> write_string("? ");
		    s := read_string();
		    write_string("You typed: \"");
		    write_string(s);
		    write_string("\".\n");
		    more := s ~= ""; ]
	write_string ("See you around.\n");
]
