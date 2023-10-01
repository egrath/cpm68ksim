MU		= musashi
MUFILES		= $(MU)/softfloat/softfloat.o $(MU)/m68kdasm.o $(MU)/m68kops.o $(MU)/m68kcpu.o

CC		= gcc

all: mu simbios cpm400 cpmsim.o
	$(CC) $(MUFILES) cpmsim.o -o cpmsim

cpmsim.o: cpmsim.c
	$(CC) -c cpmsim.c 

mu:
	$(MAKE) -C $(MU)

simbios: simbios.bin;

simbios.bin: simbios.s
	asl -cpu 68000 -L -olist simbios.lst -o simbios.p simbios.s
	p2bin -m ALL -r 0-0x7FFF simbios.p simbios.bin

cpm400: cpm400.bin;

cpm400.bin: cpm400.sr
	objcopy --input-target srec --output-target binary --pad-to 0x6000 cpm400.sr cpm400.obj
	dd if=/dev/zero of=cpm400.bin bs=1024 count=1
	dd if=cpm400.obj of=cpm400.bin bs=1024 seek=1
	rm cpm400.obj

clean:
	$(MAKE) -C musashi clean
	rm *.o
	rm cpm400.bin
	rm simbios.bin
	rm cpmsim

