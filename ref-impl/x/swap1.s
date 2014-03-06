program = map () -> bool [
	(i, j) := (1, 2);
	writeInt(i); writeInt(j);
	(i, j) := (j, i);
	writeInt(i); writeInt(j)
]
