module mux_32_8to1(
    output [31:0] res,
    input [31:0] a, b, c, d, f, g, h,
	 input e,
    input [2:0] aluop
);


mux8to1 mux0 (res[0], a[0], b[0], c[0], d[0], e, f[0], g[0], h[0],  aluop);
mux8to1 mux1 (res[1], a[1], b[1], c[1], d[1], 1'b0, f[1], g[1], h[1],  aluop);
mux8to1 mux2 (res[2], a[2], b[2], c[2], d[2], 1'b0, f[2], g[2], h[2],  aluop);
mux8to1 mux3 (res[3], a[3], b[3], c[3], d[3], 1'b0, f[3], g[3], h[3],  aluop);
mux8to1 mux4 (res[4], a[4], b[4], c[4], d[4], 1'b0, f[4], g[4], h[4],  aluop);
mux8to1 mux5 (res[5], a[5], b[5], c[5], d[5], 1'b0, f[5], g[5], h[5],  aluop);
mux8to1 mux6 (res[6], a[6], b[6], c[6], d[6], 1'b0, f[6], g[6], h[6],  aluop);
mux8to1 mux7 (res[7], a[7], b[7], c[7], d[7], 1'b0, f[7], g[7], h[7],  aluop);
mux8to1 mux8 (res[8], a[8], b[8], c[8], d[8], 1'b0, f[8], g[8], h[8],  aluop);
mux8to1 mux9 (res[9], a[9], b[9], c[9], d[9], 1'b0, f[9], g[9], h[9],  aluop);
mux8to1 mux10 (res[10], a[10], b[10], c[10], d[10], 1'b0, f[10], g[10], h[10],  aluop);
mux8to1 mux11 (res[11], a[11], b[11], c[11], d[11], 1'b0, f[11], g[11], h[11],  aluop);
mux8to1 mux12 (res[12], a[12], b[12], c[12], d[12], 1'b0, f[12], g[12], h[12],  aluop);
mux8to1 mux13 (res[13], a[13], b[13], c[13], d[13], 1'b0, f[13], g[13], h[13],  aluop);
mux8to1 mux14 (res[14], a[14], b[14], c[14], d[14], 1'b0, f[14], g[14], h[14],  aluop);
mux8to1 mux15 (res[15], a[15], b[15], c[15], d[15], 1'b0, f[15], g[15], h[15],  aluop);
mux8to1 mux16 (res[16], a[16], b[16], c[16], d[16], 1'b0, f[16], g[16], h[16],  aluop);
mux8to1 mux17 (res[17], a[17], b[17], c[17], d[17], 1'b0, f[17], g[17], h[17],  aluop);
mux8to1 mux18 (res[18], a[18], b[18], c[18], d[18], 1'b0, f[18], g[18], h[18],  aluop);
mux8to1 mux19 (res[19], a[19], b[19], c[19], d[19], 1'b0, f[19], g[19], h[19],  aluop);
mux8to1 mux20 (res[20], a[20], b[20], c[20], d[20], 1'b0, f[20], g[20], h[20],  aluop);
mux8to1 mux21 (res[21], a[21], b[21], c[21], d[21], 1'b0, f[21], g[21], h[21],  aluop);
mux8to1 mux22 (res[22], a[22], b[22], c[22], d[22], 1'b0, f[22], g[22], h[22],  aluop);
mux8to1 mux23 (res[23], a[23], b[23], c[23], d[23], 1'b0, f[23], g[23], h[23],  aluop);
mux8to1 mux24 (res[24], a[24], b[24], c[24], d[24], 1'b0, f[24], g[24], h[24],  aluop);
mux8to1 mux25 (res[25], a[25], b[25], c[25], d[25], 1'b0, f[25], g[25], h[25],  aluop);
mux8to1 mux26 (res[26], a[26], b[26], c[26], d[26], 1'b0, f[26], g[26], h[26],  aluop);
mux8to1 mux27 (res[27], a[27], b[27], c[27], d[27], 1'b0, f[27], g[27], h[27],  aluop);
mux8to1 mux28 (res[28], a[28], b[28], c[28], d[28], 1'b0, f[28], g[28], h[28],  aluop);
mux8to1 mux29 (res[29], a[29], b[29], c[29], d[29], 1'b0, f[29], g[29], h[29],  aluop);
mux8to1 mux30 (res[30], a[30], b[30], c[30], d[30], 1'b0, f[30], g[30], h[30],  aluop);
mux8to1 mux31 (res[31], a[31], b[31], c[31], d[31], 1'b0, f[31], g[31], h[31],  aluop);


endmodule
