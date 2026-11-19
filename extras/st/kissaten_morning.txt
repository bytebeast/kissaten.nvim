/* Kissaten Morning for st: replace colorname[] and the default* lines in config.h */
/* upstream: https://github.com/bytebeast/kissaten.nvim */
static const char *colorname[] = {
	"#4f5578",
	"#b7002f",
	"#24680c",
	"#805000",
	"#1d4fcf",
	"#9c2d7a",
	"#00656a",
	"#c2c9dc",
	"#686f8e",
	"#980027",
	"#1b4d09",
	"#613d00",
	"#1945b4",
	"#631eca",
	"#004b6d",
	"#d4d8e4",

	[255] = 0,

	"#353a5c", /* 256: cursor */
	"#eef0f6", /* 257: reverse cursor */
	"#353a5c", /* 258: foreground */
	"#eef0f6", /* 259: background */
};

unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
