BIN=/opt/gbdk/bin
RGBASM=/opt/rgbds/rgbasm
OBJ=./obj

build:
	mkdir -p $(OBJ)
	$(BIN)/gbdk-n-compile.sh demo.c -o $(OBJ)/demo.rel
	$(RGBASM) debug.asm -o $(OBJ)/debug.o
	$(BIN)/gbdk-n-link.sh $(OBJ)/demo.rel $(OBJ)/debug.o -o $(OBJ)/demo.ihx
	$(BIN)/gbdk-n-make-rom.sh $(OBJ)/demo.ihx demo.gb

clean:
	rm -rf $(OBJ)
	rm -f demo.gb

