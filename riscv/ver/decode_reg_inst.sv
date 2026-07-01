`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_reg_inst(
    input  logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [4:0] alu_control
);

assign rs1 = instruction_code[19:15];
assign rs2 = instruction_code[24:20];
assign rd  = instruction_code[11:7];

logic [2:0] func3;
logic [6:0] func7;

assign func3 = instruction_code[14:12];
assign func7 = instruction_code[31:25];

always_comb begin
    alu_control = 'b0; 

    case (func3)
        3'd0: begin
            if(func7==7'h0)
            alu_control=`ADD;
            else if(func7==7'h20)
            alu_control=`SUB;
        end

        3'd4: begin
            if(func7==7'h0)
            alu_control = `XOR;
        end
        3'd6: 
        begin
            if(func7==7'h0)
            alu_control = `OR;
        end
        3'd7: begin 
        if(func7==7'h0)
        alu_control = `AND;
        end
        3'd1: begin
            if(func7==7'h0)
            alu_control = `SLL;
        end

        3'd5: begin
            if (func7 == 7'd0)
                alu_control = `SRL;
            else if(func7==7'h20)
                alu_control = `SRA;
        end

        3'd2: begin
            if(func7==7'h0)
            alu_control = `SLT;
        end
        3'd3: begin
            if(func7==7'h0)
        alu_control = `SLTU;
        end

        default: alu_control = 'b0;
    endcase
end

endmodule