CC=gcc
CFLAGS=-Wall
SRC=src/main.c src/elf_inject.c
LIBS=-lelf

all: injector

injector: $(SRC)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)


.PHONY: clean

clean:
	rm -f src/*.o injector
