/* Kissaten Midnight for st: replace colorname[] and the default* lines in config.h */
/* upstream: https://github.com/bytebeast/kissaten.nvim */
static const char *colorname[] = {
	"#2a2c42",
	"#f38ba8",
	"#a6d98a",
	"#e6c56f",
	"#7aa2f7",
	"#f5c2e7",
	"#73daca",
	"#a9b1d6",
	"#575d82",
	"#f8a0b8",
	"#b4e29a",
	"#edcf81",
	"#8fb2fb",
	"#cab0fb",
	"#97d8ff",
	"#c8d0f0",

	[255] = 0,

	"#c8d0f0", /* 256: cursor */
	"#16161f", /* 257: reverse cursor */
	"#c8d0f0", /* 258: foreground */
	"#16161f", /* 259: background */
};

unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
