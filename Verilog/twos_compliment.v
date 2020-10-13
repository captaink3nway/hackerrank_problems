module twos_complement(a,b,sum,carry);
input a,b;
output sum,carry;
wire abar;
assign abar=~a;
assign sum=abar^b;
assign carry=abar&b;
endmodule

module TC4bit(a,s);
input [3:0] a;
output [3:0] s;
wire c1,c2,c3,c4;
begin
twos_complement comp0(a[0],1,s[0],c1);
twos_complement comp1(a[1],c1,s[1],c2);
twos_complement comp2(a[2],c2,s[2],c3);
twos_complement comp3(a[0],c3,s[3],c4);
end
endmodule

module TC_test;
reg [3:0]a;
wire [0:3]s;
wire c1,c2,c3,c4;
TC4bit uut(a,s);
initial
begin
a=4'b1101;
#100;
a=4'b1001;
#100;
end
initial
$monitor($time, "a=%b,s=%c", a,s);
endmodule