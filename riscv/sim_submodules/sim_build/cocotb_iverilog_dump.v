module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/store.fst");
    $dumpvars(0, store);
end
endmodule
