module alu (
    x,y,z,sign,zero,carry,parity,overflow
);
    input [15:0] x,y;
    output [15:0] z;
    output sign,zero,carry,parity,overflow;
    wire c[3:0];

    assign sign = z[15];     // most significant digit 1-> - , 0->+
    assign zero = ~|z;      // NOR if output is = 0, zero wii be set to 1
    assign parity = ~^z;    // XNOR even parity = 1 , odd parity=0
    assign overflow = (x[15] & y[15] & ~z[15]) | (x[15] & ~y[15] & z[15]); 

    adder4 A0 (z[3:0], c[1], x[3:0], y[3:0], 1'b0);
    adder4 A1 (z[7:4], c[2], x[7:4], y[7:4], c[1]);
    adder4 A2 (z[11:8], c[3], x[11:8], y[11:8], c[2]);
    adder4 A3 (z[15:12], carry, x[15:12], y[15:12], c[3]);

endmodule

// behavioral description of a 4-bit adder
module adder4 (S, cout, A, B, cin);
    input [3:0] A,B;
    input cin;
    output [3:0] S;
    output cout;

    assign {cout, S} = A + B + cin;
endmodule