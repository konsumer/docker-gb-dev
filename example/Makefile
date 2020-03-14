BIN=/opt/gbdk/bin
OBJ=./obj

build:
	mkdir -p $(OBJ)
	$(BIN)/gbdk-n-compile.sh demo.c -o $(OBJ)/demo.rel
	$(BIN)/gbdk-n-link.sh $(OBJ)/demo.rel -o $(OBJ)/demo.ihx
	$(BIN)/gbdk-n-make-rom.sh $(OBJ)/demo.ihx demo.gb

clean:
	rm -rf $(OBJ)
	rm -f demo.gb

