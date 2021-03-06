
CC ?= gcc
CFLAGS += -g -Wall -Werror -fno-strict-aliasing -Wwrite-strings -std=gnu99 -fsanitize=address -fsanitize=undefined

all: metadata.pb-c.c schema.pb-c.c
	$(CC) $(CFLAGS) main.c utils.c metadata.pb-c.c -lsodium -lprotobuf-c -o main
	$(CC) $(CFLAGS) server.c net.c utils.c log.c dht.c dht_wrapper.c varint.c schema.pb-c.c crypto-stream-state/src/*.c -lsodium -lprotobuf-c -o server

metadata.pb-c.c:
	protoc --c_out=. metadata.proto

schema.pb-c.c:
	protoc --c_out=. schema.proto

run:
	./main
