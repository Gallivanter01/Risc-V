    .global _USER_SP_ADDR

    .section .text.entrypoint
    .global __start

__start:
    jal ra, pre_main                    # Jump to pre_main

__post_main:
    j __post_main                       # Infinite loop after main

pre_main:
    la sp, _USER_SP_ADDR                # Load the stack pointer address into sp

    # Other initialization code...

    j main                              # Jump to main function
