module cmos_xor(out,a,b,Abar,Bbar);
parameter dly = 0;
input a,b,Abar,Bbar;
output out;
wire wa,wb,wc;
supply1 vdd;
supply0 vss;

nmos #dly m5(out,wb,Abar);
nmos #dly m6(out,wc,a);
nmos #dly m7(wb,vss,Bbar);
nmos #dly m8(wc,vss,b);



pmos #dly m1(wa,vdd,a);
pmos #dly m2(wa,vdd,b);
pmos #dly m3(out,wa,Abar);
pmos #dly m4(out,wa,Bbar);
endmodule