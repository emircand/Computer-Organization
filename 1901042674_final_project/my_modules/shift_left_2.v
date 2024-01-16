module shift_left_2 (
    output wire [31:0] shifted_address,
    input [31:0] address
);
    or or0(shifted_address[31], address[29]);
    or or1(shifted_address[30], address[28]);
    or or2(shifted_address[29], address[27]);
    or or3(shifted_address[28], address[26]);
    or or4(shifted_address[27], address[25]);
    or or5(shifted_address[26], address[24]);
    or or6(shifted_address[25], address[23]);
    or or7(shifted_address[24], address[22]);
    or or8(shifted_address[23], address[21]);
    or or9(shifted_address[22], address[20]);
    or or10(shifted_address[21], address[19]);
    or or11(shifted_address[20], address[18]);
    or or12(shifted_address[19], address[17]);
    or or13(shifted_address[18], address[16]);
    or or14(shifted_address[17], address[15]);
    or or15(shifted_address[16], address[14]);
    or or16(shifted_address[15], address[13]);
    or or17(shifted_address[14], address[12]);
    or or18(shifted_address[13], address[11]);
    or or19(shifted_address[12], address[10]);
    or or20(shifted_address[11], address[9]);
    or or21(shifted_address[10], address[8]);
    or or22(shifted_address[9], address[7]);
    or or23(shifted_address[8], address[6]);
    or or24(shifted_address[7], address[5]);
    or or25(shifted_address[6], address[4]);
    or or26(shifted_address[5], address[3]);
    or or27(shifted_address[4], address[2]);
    or or28(shifted_address[3], address[1]);
    or or29(shifted_address[2], address[0]);
    or or30(shifted_address[1], 1'b0);
    or or31(shifted_address[0], 1'b0);
endmodule