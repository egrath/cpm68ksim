EXENAME          = cpmsim

MAINFILES        = cpmsim.c
MUSASHIFILES     = m68kcpu.c m68kdasm.c softfloat/softfloat.c
MUSASHIGENCFILES = m68kops.c
MUSASHIGENHFILES = m68kops.h
MUSASHIGENERATOR = m68kmake

EXEPATH = ./

.CFILES   = $(MAINFILES) $(OSDFILES) $(MUSASHIFILES) $(MUSASHIGENCFILES)
.OFILES   = $(.CFILES:%.c=%.o)

CC        = gcc
WARNINGS  = -Wall -Wextra -pedantic
CFLAGS    = -O2 $(WARNINGS)
LFLAGS    = $(WARNINGS)

TARGET = $(EXENAME)$(EXE)

DELETEFILES = $(MUSASHIGENCFILES) $(MUSASHIGENHFILES) $(.OFILES) $(TARGET) $(MUSASHIGENERATOR)$(EXE) simbios.bin simbios.lst simbios.p cpm400.bin

all: $(TARGET) cpm400 simbios

clean:
	rm -f $(DELETEFILES)

$(TARGET): $(MUSASHIGENHFILES) $(.OFILES) Makefile simbios
	$(CC) -o $@ $(.OFILES) $(LFLAGS) -lm

$(MUSASHIGENCFILES) $(MUSASHIGENHFILES): $(MUSASHIGENERATOR)$(EXE)
	$(EXEPATH)$(MUSASHIGENERATOR)$(EXE)

$(MUSASHIGENERATOR)$(EXE):  $(MUSASHIGENERATOR).c
	$(CC) -o  $(MUSASHIGENERATOR)$(EXE)  $(MUSASHIGENERATOR).c

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

