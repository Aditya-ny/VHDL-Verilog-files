module xor_test;
reg a, b;

//input a;
//input b;
//output out;

wire out,test;

cmos_xor g1(out,a,b,Abar,Bbar);


//assign test = (~a&~b | a&b);
assign test = (a^b);
assign Abar=~(a);
assign Bbar=~(b);


initial
begin
	a = 1'b0; b = 1'b0;
#10
	a = 1'b0; b = 1'b1;
#10
	a = 1'b1; b = 1'b0;
#10
	a = 1'b1; b = 1'b1;
#10
     a = 1'b0; b = 1'b0;
end
initial
	$monitor("time %d a %b b %b out %b test %b %s",
		$time,a,b,out,test,out==test? "valid":"invalid");
endmodule