module cmos_xor(out,A,B,Abar,Bbar);
parameter dly = 0;
input A,B,Abar,Bbar;
output out;
wire w;
supply1 vdd;
supply0 vss;

nmos #dly m5(out,w,Abar);
nmos #dly m6(out,w,A);
nmos #dly m7(w,vss,Bbar);
nmos #dly m8(w,vss,B);



pmos #dly m1(vdd,w,A);
pmos #dly m2(vdd,w,B);
pmos #dly m3(w,out,Abar);
pmos #dly m4(w,out,Bbar);
endmodule