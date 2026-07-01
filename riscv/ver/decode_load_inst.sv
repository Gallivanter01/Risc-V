
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_load_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [2:0] load_control
);

// Edit the code here begin ---------------------------------------------------

    assign rs1 = instruction_code[19:15];
    assign rd = instruction_code[11:7];
    assign imm = instruction_code[31:20];
    //assign load_control = 'b0;
    logic [2:0] func3;
    logic [6:0] func7;

    assign func3 = instruction_code[14:12];
    assign func7 = instruction_code[31:25];
    always_comb begin
        case(func3)
            3'd0:
            load_control=`LB;
            3'd1:
            load_control=`LH;
            3'd2:
            load_control=`LW;
            3'd4:
            load_control=`LBU;
            3'd5:
            load_control=`LHU;
            default:
            load_control=`LD_NOP;
        endcase
    end
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_load_inst.vcd");
        $dumpvars(0, decode_load_inst);
    end
`endif

endmodule
