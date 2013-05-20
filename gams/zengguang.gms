variables
	x1
	x2
	fn
;

equations 
	obj
	st
;
obj .. fn =e= (x1 +1) ** 2 + x2 ** 2;
st .. x1 + x2 =g= 1;

model zengguang /all/;
solve zengguang using nlp minimizing fn;
display x1.l, x2.l;
