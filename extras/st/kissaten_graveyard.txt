/* Kissaten Graveyard for st: replace colorname[] and the default* lines in config.h */
/* upstream: https://github.com/bytebeast/kissaten.nvim */
static const char *colorname[] = {
	"#23253b",
	"#ea83a0",
	"#9dd081",
	"#ddbc66",
	"#739aee",
	"#ebb9dd",
	"#69d1c1",
	"#a1a9cd",
	"#51577b",
	"#f196af",
	"#aadb90",
	"#e6c777",
	"#86a9f4",
	"#c2a6f4",
	"#89d1fa",
	"#bfc7e6",

	[255] = 0,

	"#bfc7e6", /* 256: cursor */
	"#0a0a0d", /* 257: reverse cursor */
	"#bfc7e6", /* 258: foreground */
	"#0a0a0d", /* 259: background */
};

unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
