openocd -f board/esp32c3-builtin.cfg -c "program_esp build/matmul.bin 0x10000 verify"