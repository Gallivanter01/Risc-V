`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module load(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] imm,
    input logic [31:0] mem_data,
    input logic [4:0] rd_in,
    input logic [2:0] load_control,
    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic rd_write_control,
    output logic [4:0] rd_out,
    output logic [31:0] rd_write_val,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr
);

// Edit the code here begin ---------------------------------------------------

logic taken;
logic [31:0] sample;
logic [2:0] load_prev;
logic [31:0] prev_mem_addr;
always_comb begin
    stall_pc         = 1'b0;
    rd_write_control = 1'b0;
    rd_write_val     = 32'b0;
    mem_rw_mode      = 1'b1;
    mem_addr         = 32'b0;
    case(load_control)
        `LW: begin
            mem_addr = rs1_val + imm;
            stall_pc = 1'b1;
            
        end
        `LB: begin
            mem_addr = rs1_val + imm;
            stall_pc = 1'b1;
            
            
        end
        `LH: begin
            mem_addr = rs1_val + imm;
            stall_pc = 1'b1;
           
        end
        `LBU : begin
            mem_addr = rs1_val + imm;
            stall_pc = 1'b1;
            
        end
        `LHU : begin
            mem_addr = rs1_val + imm;
            stall_pc = 1'b1;
            
        end
        default: begin
            stall_pc         = 1'b0;
            rd_write_control = 1'b0;
            rd_write_val     = 32'b0;
            mem_rw_mode      = 1'b1;
            mem_addr         = 32'b0;
        end
    endcase
    if (ignore_curr_inst)
            taken = 1'b1;
        else
            taken = 1'b0;
    if (taken) begin
        rd_write_control = 1'b1;
        case (load_prev)
        `LW: begin
            sample=mem_data;
        end
        `LB: begin
           
            case (prev_mem_addr[1:0])
            2'b00: 
            sample={{24{mem_data[7]}},mem_data[7:0]};
            2'b01:
            sample={{24{mem_data[15]}},mem_data[15:8]};
            2'b10:
            sample={{24{mem_data[23]}},mem_data[23:16]};
            2'b11:
            sample={{24{mem_data[31]}},mem_data[31:24]};

            endcase
            
        end
        `LH: begin
            
            case(prev_mem_addr[1])
            1'b0:
            sample={{16{mem_data[15]}},mem_data[15:0]};
            1'b1:
            sample={{16{mem_data[31]}},mem_data[31:16]};
            endcase
        end
        `LBU : begin
            
            case (prev_mem_addr[1:0])
            2'b00: 
            sample={{24{1'b0}},mem_data[7:0]};
            2'b01:
            sample={{24{1'b0}},mem_data[15:8]};
            2'b10:
            sample={{24{1'b0}},mem_data[23:16]};
            2'b11:
            sample={{24{1'b0}},mem_data[31:24]};

            endcase
        end
        `LHU : begin
           
            case(prev_mem_addr[1])
            1'b0:
            sample={{16{1'b0}},mem_data[15:0]};
            1'b1:
            sample={{16{1'b0}},mem_data[31:16]};
            endcase
        end
        default : begin

            sample='b0;
        end
        endcase
        rd_write_val=sample;
    end
end

always_ff @(posedge i_clk or negedge i_rst) begin
    if (!i_rst) begin
        ignore_curr_inst <= 1'b0;
        taken            <= 1'b0;
        rd_out<='b0;
    end
    else begin
        rd_out   <= rd_in;
        if(load_control==`LW) begin
            load_prev<=`LW;
            ignore_curr_inst<='b1;
        end
        else if(load_control==`LB) begin
            load_prev<=`LB;
            ignore_curr_inst<='b1;
        end
        else if(load_control==`LH) begin
            load_prev<=`LH;
            ignore_curr_inst<='b1;
        end
        else if(load_control==`LBU) begin
            load_prev<=`LBU;
            ignore_curr_inst<='b1;
        end
        else if(load_control==`LHU) begin
            load_prev<=`LHU;
            ignore_curr_inst<='b1;
        end
        else begin
        ignore_curr_inst<='b0;
        load_prev<=`LD_NOP;
        rd_out<=0;
        end
        prev_mem_addr<=mem_addr;
        
        
    end
end

// Edit the code here end -----------------------------------------------------

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/load.vcd");
        $dumpvars(0, load);
    end
`endif

endmodule