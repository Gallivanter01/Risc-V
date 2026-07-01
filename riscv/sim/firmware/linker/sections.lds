MEMORY {
    pram : ORIGIN = 0x00000000, LENGTH = 0x0000800          # 0     ->  2048 bytes
    dram : ORIGIN = 0x00000800, LENGTH = 0x0000800          # 2048  ->  4096 bytes
}

ENTRY(__start)

SECTIONS {
    . = 0x00000000;

    .text : {
        *(.text.entrypoint)
        _text_start = .;            # Start of the text section
        *(.text)
        _text_end = .;              # End of the text section
    } > pram

    .ro : {
        . = ALIGN(4);
        _ro_start = .;              # Start of the RO section
        *(.rodata*)
        _ro_end = .;                # End of the RO section
    } > dram

    .data : {
        . = ALIGN(4);
        _data_start = .;            # Start of the data section
        *(.data)
        _data_end = .;              # End of the data section
    } > dram

    .bss : {
        . = ALIGN(4);
        _bss_start = .;             # Start of the BSS section
        *(.bss)
        _bss_end = .;               # End of the BSS section
    } > dram

    # Define _USER_SP_ADDR (stack pointer) to be at the top of memory
    _USER_SP_ADDR = ORIGIN(pram) + LENGTH(pram) + LENGTH(dram) - 4;
}
