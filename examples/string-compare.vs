show_string = map (s) -> () [
    write_string ("\""); write_string (s); write_string ("\""); ]

compare = map (s1, s2, op; v) -> () [
    show_string (s1); write_string (op); show_string (s2);
    write_string (" <=> "); write_bool (v);
    write_string (".\n"); ]

a, b: string;

read_strings = map () -> bool [
    write_string ("_string 1: ");
    a := read_string();
    ? [ a = "" -> ^ false;
      |   *    -> write_string ("_string 2: ");
		  b := read_string();
		  ^ true; ] ]

program = map () -> () [
    * [ read_strings() -> compare(a, b, " <  ",  a<b);
			  compare(a, b, " <= ", a<=b);
			  compare(a, b, " =  ",  a=b);
			  compare(a, b, " ~= ", a~=b);
			  compare(a, b, " >= ", a>=b);
			  compare(a, b, " >  ",  a>b);
			  write_string("\n"); ] ]
