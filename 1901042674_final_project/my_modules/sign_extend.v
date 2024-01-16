module sign_extend(
    output [31:0] sign_ext_imm,  
    input [15:0] imm                
);

or or1(sign_ext_imm[0], imm[0]);
or or2(sign_ext_imm[1], imm[1]);
or or3(sign_ext_imm[2], imm[2]);
or or4(sign_ext_imm[3], imm[3]);
or or5(sign_ext_imm[4], imm[4]);
or or6(sign_ext_imm[5], imm[5]);
or or7(sign_ext_imm[6], imm[6]);
or or8(sign_ext_imm[7], imm[7]);
or or9(sign_ext_imm[8], imm[8]);
or or10(sign_ext_imm[9], imm[9]);
or or11(sign_ext_imm[10], imm[10]);
or or12(sign_ext_imm[11], imm[11]);
or or13(sign_ext_imm[12], imm[12]);
or or14(sign_ext_imm[13], imm[13]);
or or15(sign_ext_imm[14], imm[14]);
or or16(sign_ext_imm[15], imm[15]);
or or17(sign_ext_imm[16], imm[15]);
or or18(sign_ext_imm[17], imm[15]);
or or19(sign_ext_imm[18], imm[15]);
or or20(sign_ext_imm[19], imm[15]);
or or21(sign_ext_imm[20], imm[15]);
or or22(sign_ext_imm[21], imm[15]);
or or23(sign_ext_imm[22], imm[15]);
or or24(sign_ext_imm[23], imm[15]);
or or25(sign_ext_imm[24], imm[15]);
or or26(sign_ext_imm[25], imm[15]);
or or27(sign_ext_imm[26], imm[15]);
or or28(sign_ext_imm[27], imm[15]);
or or29(sign_ext_imm[28], imm[15]);
or or30(sign_ext_imm[29], imm[15]);
or or31(sign_ext_imm[30], imm[15]);
or or32(sign_ext_imm[31], imm[15]);



endmodule