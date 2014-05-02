
CC=clang # or gcc

FRAMEWORKS:= -framework Foundation
LIBRARIES:= -lobjc

SOURCE=main.m

CFLAGS=-Wall -Werror -g -v $(SOURCE)
LDFLAGS=$(LIBRARIES) $(FRAMEWORKS)
OUT=main

all:
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(OUT)

clean:
	rm -fr $(OUT) *.dSYM
