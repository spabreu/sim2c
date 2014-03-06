swap = map (a, b) -> (int, int) [ return (b,a) ];

program = map () -> bool [
	(i, j) := swap (1, 2);
	writeInt (i);
	writeInt (j)
]
