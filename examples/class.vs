foo = map () -> () [
	r : { i, j: int; };
	a : [10] { i, j: int; };

	r.i := 10;
	r.j := 20;
	a[1].i := 30;
	a[2].j := 40;

	x := r.i;
	x := r.j;
	x := a[1].i;
	x := a[2].j;
]
