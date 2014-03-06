program tacker(output);
{ solution of fast growing recursive function ackerman(mc,nc) }
   const MC = 3;
         NC = 8;

   function acker(m, n: integer): integer;
   begin
      if m = 0
	 then acker := n + 1
      else if n = 0
	 then acker := acker( m - 1, 1 )
      else acker := acker( m - 1, acker( m, n - 1 ) )
      end{acker};
begin
   writeln (acker( MC, NC ));
   end.

