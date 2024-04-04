from ctypes import *
 
libupper = CDLL("/usr/local/lib/libup.so")
 
libupper.mytoupper.argtypes = [c_char_p, c_char_p]
libupper.mytoupper.restype = c_int
 
inStr = create_string_buffer(b"This is a test!")
outStr = create_string_buffer(250)
 
len = libupper.mytoupper(inStr, outStr)
 
print(inStr.value.decode())
print(outStr.value.decode())
print(len)
