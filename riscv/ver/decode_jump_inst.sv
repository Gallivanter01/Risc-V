
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_jump_inst(
    input logic [31:0] instruction_code,
    output logic [4:0] rd,
    output logic [4:0] rs1,
    output logic [31:0] imm,
    output logic [1:0] jump_control
);

// Edit the code here begin ---------------------------------------------------

    //assign rs1 = instruction_code[19:15];
    assign rd = instruction_code[11:7];
    //assign alu_control = 'b0;
    logic [2:0] func3;
    logic [6:0] func7;

    assign func3 = instruction_code[14:12];
    assign func7 = instruction_code[31:25];
    //assign jump_control = 'b0;

    logic [6:0] opcode;
    always_comb begin
    jump_control = 'b0;
    opcode=instruction_code[6:0];
    //imm='b0;
    //rs1 = 'b0;
        case(opcode)
        7'b1101111: begin
            imm={{12{instruction_code[31]}},instruction_code[19:12],instruction_code[20],instruction_code[30:21],1'b0};
            jump_control=`JAL;
            rs1 = 5'b0;
        end
        

        7'b1100111: begin
            if(func3==3'h0) begin
                rs1 = instruction_code[19:15];
                imm={{20{instruction_code[31]}},instruction_code[31:20]};
                jump_control=`JALR;
            end
            else begin
            jump_control = 'b0;
            imm=32'b0;
            rs1 =5'b0;
        end
        end
        default : begin
            jump_control = 'b0;
            imm=32'b0;
            rs1 = 5'b0;
        end
        
        endcase
    end
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_jump_inst.vcd");
        $dumpvars(0, decode_jump_inst);
    end
`endif

endmodule
