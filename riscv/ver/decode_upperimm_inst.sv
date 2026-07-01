
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_upperimm_inst(
    input logic [31:0] instruction_code,
    output logic [4:0] rd,
    output logic [31:0] imm,
    output logic [4:0] alu_control
);

// Edit the code here begin ---------------------------------------------------

    assign rd = instruction_code[11:7];
    assign imm = {instruction_code[31:12],{12{1'b0}}};
    //assign alu_control = 'b0;
    logic [6:0] opcode;
    assign opcode=instruction_code[6:0];
    always_comb begin
    alu_control='b0;
        case(opcode)
        7'b0110111:
        alu_control=`LUI;
        7'b0010111:
        alu_control=`AUIPC;
        endcase
    end
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_upperimm_inst.vcd");
        $dumpvars(0, decode_upperimm_inst);
    end
`endif

endmodule
