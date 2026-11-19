/* Kissaten Afternoon for st: replace colorname[] and the default* lines in config.h */
/* upstream: https://github.com/bytebeast/kissaten.nvim */
static const char *colorname[] = {
	"#3c4159",
	"#f690ac",
	"#a9d881",
	"#e8c47e",
	"#89aefe",
	"#f4b8e4",
	"#7fd3c4",
	"#b0b9dd",
	"#6a7194",
	"#faa5bd",
	"#b6e291",
	"#efcf90",
	"#a2bfff",
	"#d4b5fa",
	"#93dbf6",
	"#cdd5f6",

	[255] = 0,

	"#cdd5f6", /* 256: cursor */
	"#282b3e", /* 257: reverse cursor */
	"#cdd5f6", /* 258: foreground */
	"#282b3e", /* 259: background */
};

unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
