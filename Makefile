BINARY=wormholes.app
CC = gcc
OPT=-O0
DEPFLAGS=-MP -MD
LIBRARIES=`pkg-config --libs gtk+-3.0`
CFLAGS=-Wall -Wno-unused-command-line-argument -g $(OPT) $(DEPFLAGS) `pkg-config --cflags gtk+-3.0`
CFILES = $(wildcard *.c)
OBJECTS=$(patsubst %.c,%.o,$(CFILES))
DEPFILES=$(patsubst %.c,%.d,$(CFILES))

all: $(BINARY) 

$(BINARY): $(OBJECTS)
	$(CC) -o $@ $^ $(LIBRARIES)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $< $(LIBRARIES)

clean:
	rm -f $(BINARY) $(OBJECTS) $(DEPFILES)

check-mem:
	valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all -s ./collection.run

-include $(DEPFILES)