# CP/M-68K Emulator

This is a emulator for a very simple and generic 68000 based system capable of running CP/M-68K. It has been
written by David Schultz. My current modifications are described in the changelog in detail.

David's homepage is over at: http://davesrocketworks.com/electronics/cpm68/simulator.html. As snapshot of his homepage with additional information can also be found in the "docs" folder.

## Changelog

09/13/2023:
- Update to Musashi 4.10:
- Added a build target for the BIOS needed by CP/M-68K

## Prerequisites and building

- To build the BIOS, "Macroassembler AS" is needed. It's available from http://john.ccac.rwth-aachen.de:8000/as/
- Run 'make' to build the simulator binary.

## Notes

- Keep the m68kconf.h file, it's modified!

