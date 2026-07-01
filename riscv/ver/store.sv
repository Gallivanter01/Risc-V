`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module store(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [31:0] imm,
    input logic [2:0] store_control,
    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr,
    output logic [31:0] mem_write_data,
    output logic [3:0] mem_byte_en
);

// Edit the code here begin ---------------------------------------------------



assign mem_addr = rs1_val + imm;
assign stall_pc    = (store_control != `STR_NOP);
assign mem_rw_mode = (store_control == `STR_NOP);
always_comb begin
    mem_write_data = 32'd0;
    mem_byte_en    = 4'd0;
    case (store_control)
        `SB: begin
            case (mem_addr[1:0])
                2'd0: begin 
                    mem_write_data = {24'd0, rs2_val[7:0]}; 
                    mem_byte_en = 4'b0001; 
                    end
                2'd1: begin 
                    mem_write_data = {16'd0, rs2_val[7:0], 8'd0}; 
                    mem_byte_en = 4'b0010;
                     end
                2'd2: begin 
                    mem_write_data = {8'd0, rs2_val[7:0], 16'd0}; 
                    mem_byte_en = 4'b0100;
                     end
                2'd3: begin 
                    mem_write_data = {rs2_val[7:0], 24'd0};
                    mem_byte_en = 4'b1000;
                     end
            endcase
        end
        `SH: begin
            if (mem_addr[1:0] == 2'd0 || mem_addr[1:0] == 2'd1) 
            begin
                mem_write_data = {16'd0, rs2_val[15:0]};
                mem_byte_en    = 4'b0011;
            end 
            else
            begin
                mem_write_data = {rs2_val[15:0], 16'd0};
                mem_byte_en    = 4'b1100;
            end
        end
        `SW: begin
            mem_write_data = rs2_val;
            mem_byte_en    = 4'b1111;
        end
        default: begin
            mem_write_data = 32'd0;
            mem_byte_en    = 4'd0;
        end
    endcase
end

always_ff @(posedge i_clk or negedge i_rst) begin
    if (!i_rst)
        ignore_curr_inst <= 1'b0;
    else
        ignore_curr_inst <= stall_pc;
end
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/store.vcd");
        $dumpvars(0, store);
    end
`endif

endmodule