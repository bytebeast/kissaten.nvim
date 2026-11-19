/* Kissaten Evening for st: replace colorname[] and the default* lines in config.h */
/* upstream: https://github.com/bytebeast/kissaten.nvim */
static const char *colorname[] = {
	"#323650",
	"#f28fad",
	"#b5e08d",
	"#ebcf8c",
	"#82aaff",
	"#f5bde6",
	"#7fd8c8",
	"#aeb7dc",
	"#5f668d",
	"#f7a3bd",
	"#c2e89e",
	"#f2d99f",
	"#9cbbff",
	"#d4c0ff",
	"#a3e4ff",
	"#cad3f5",

	[255] = 0,

	"#cad3f5", /* 256: cursor */
	"#1f2133", /* 257: reverse cursor */
	"#cad3f5", /* 258: foreground */
	"#1f2133", /* 259: background */
};

unsigned int defaultfg = 258;
unsigned int defaultbg = 259;
unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;
