CFLAGS = -Wall -Werror -Wextra -Wno-varargs -std=gnu2x

# Tells the linker to make sure the compiled executable looks for libvector.so in ./lib and not the usual /usr/lib
LOCAL_LIB = -Wl,-rpath=lib

.PHONY: prepare compile compile_debug test install uninstall

compile: prepare
	gcc $(CFLAGS) -shared -o lib/libvector.so src/*.c

prepare:
	clear
	mkdir -p lib bin

compile_debug: prepare
	gcc $(CFLAGS) -g -shared -o lib/libvector.so src/*.c

test: compile_debug
	gcc $(CFLAGS) test.c -Llib $(LOCAL_LIB) -lvector -o bin/test
	valgrind bin/test

install: compile
	cp lib/libvector.so /usr/lib

uninstall:
	rm /usr/lib/libvector.so
