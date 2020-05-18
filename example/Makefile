 
LCC=/opt/gbdk/bin/lcc
AS = $(LCC) -c
CC = $(LCC) -Wa-l -Wl-m

BIN = demo.gb
OBJS = demo.o

all: $(BIN)

$(BIN): $(OBJS)
	$(CC) -o $(BIN) $(OBJS)

clean:
	rm -rf $(BIN) $(OBJS) *~

