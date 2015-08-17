CC=cl65
CFLAGS=-u __EXEHDR__ -t c64 -C c64-asm.cfg

BIN=player.prg
SRC=main.s
SID=music.sid
GEN_SID=gen_music.dat
GEN_ASM=gen_music.inc

all: $(BIN)

$(BIN): $(SRC) $(GEN_SID) c64-asm.cfg
	$(CC) $(CFLAGS) -o $(BIN) $(SRC)

$(GEN_SID): $(SID) recode_sid.py
	./recode_sid.py $(SID) --sid-file $(GEN_SID) --asm-file $(GEN_ASM) --sa-routine-address c500

clean:
	rm -f $(BIN) $(GEN_SID) $(GEN_ASM) *.o

run: $(BIN)
	x64 $<

.PHONY: clean run
