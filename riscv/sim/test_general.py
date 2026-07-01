import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.clock import Clock
from common import reset_dut, load_hex

@cocotb.test()
async def test_core_from_hexfile(dut):
    """ Test for general .c program """

    # Create a clock signal
    cocotb.start_soon(Clock(dut.i_clk, 10, units="ns").start())

    # Load hex file
    load_hex(dut=dut)

    # Reset the DUT
    await reset_dut(dut=dut)

    for _ in range(10000):
        await RisingEdge(dut.i_clk)

