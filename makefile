CFLAGS = -Wall -Werror -Wextra -Wno-varargs

# Tells the linker to make sure the compiled executable looks for libvector.so in ./lib and not the usual /usr/lib
LOCAL_LIB = -Wl,-rpath=lib

compile: prepare
	clear
	mkdir -p lib
	gcc $(CFLAGS) -shared -o lib/libvector.so src/*.c

prepare:
	clear
	mkdir -p lib

compile_debug: prepare
	gcc $(CFLAGS) -g -shared -o lib/libvector.so src/*.c

install: compile
	cp lib/libvector.so

test: compile_debug
	gcc $(CFLAGS) test.c -Llib $(LOCAL_LIB) -lvector
	valgrind ./a.out
