
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_imm_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [4:0] alu_control
);

// Edit the code here begin ---------------------------------------------------

    assign rs1 = instruction_code[19:15];
    assign rd = instruction_code[11:7];
    assign imm = instruction_code[31:20];
    //assign alu_control = 'b0;
    logic [2:0] func3;
    logic [6:0] func7;

    assign func3 = instruction_code[14:12];
    assign func7 = instruction_code[31:25];


    always_comb begin
        case(func3) 
        3'd0:
            alu_control=`ADDI;
        3'd4:
        alu_control=`XORI;
        3'd6:
        alu_control=`ORI;
        3'd7:
        alu_control=`ANDI;
        3'd1:
        alu_control=`SLLI; 
        3'd5: begin
            if(func7==7'd0)
                alu_control=`SRLI;
            else if(func7==7'h20)
                alu_control=`SRAI;
            else 
                alu_control='d0;

        end
        3'd2 :
        alu_control=`SLTI;
        3'd3:
        alu_control=`SLTIU;
        default:
        alu_control='d0;
        endcase
    end
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_imm_inst.vcd");
        $dumpvars(0, decode_imm_inst);
    end
`endif

endmodule
