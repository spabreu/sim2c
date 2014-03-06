program qsortInts(output);
{ recursive quicksort }

   const MAX = 100000;

   type index = 0..MAX;
	item  = record
		   key: integer;
		   data: real
		   end;

   var a: array[index] of item;

   procedure initialize;
      var r : integer;
	  i : index;
	  t, j : real;
   begin
      r := 333; j := 0.5;
      for i := 1 to MAX do begin
	 r := (1317 * r) mod 214748;
	 a[i].key := r;
	 a[i].data := j*3.0;
	 j := j+0.5
	 end
      end;

   procedure qsort(l, r: index);
      var i, j: index;
          x, w: item; 
   begin
      i := l;
      j := r;
      x := a[ (l+r) div 2 ];
      repeat
	 while a[i].key < x.key do i := i + 1;
	 while x.key < a[j].key do j := j - 1;
	 if i <= j then begin
	    w    := a[i];
	    a[i] := a[j];
	    a[j] := w;
	    i    := i + 1;
	    j    := j - 1
	    end
         until i > j;
      if l < j then qsort(l, j);
      if i < r then qsort(i, r)
      end{sort};

begin
   initialize;
   qsort(1, MAX);
   end.
