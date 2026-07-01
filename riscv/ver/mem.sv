
module mem(
    input logic i_clk,
    input logic i_rst,
    input logic [9:0] in_mem_addr,
    input logic in_mem_re_web,
    input logic [31:0] in_mem_write_data,
    input logic [3:0] in_mem_byte_en,
    output logic [31:0] out_mem_data
);

logic [31:0] memory_reg [0:1023];

// Edit the code here begin ---------------------------------------------------

    always @(posedge i_clk or negedge i_rst) begin
        if(!i_rst) begin
            out_mem_data='b0;
        end
        else begin
            if(in_mem_re_web) begin
                out_mem_data=memory_reg[in_mem_addr];
            end
            else begin
                for(int i=0;i<=3;i++) begin
                    if(in_mem_byte_en[i]) begin
                        memory_reg[in_mem_addr][i*8+:8]<=in_mem_write_data[i*8+:8];
                    end
                end
                //out_mem_data=memory_reg[in_mem_addr];
                
            end
        end
    end

// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/mem.vcd");
        $dumpvars(0, mem);
    end
`endif

endmodule
