program = map () -> bool [
	(i, j) := (1, 2);
	write_int(i); write_int(j); write_char(10);
	(i, j) := (j, i);
	write_int(i); write_int(j); write_char(10);
]
