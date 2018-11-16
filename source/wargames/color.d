module wargames.color;

import std.conv;

class Color {
	private ubyte r;
	private ubyte g;
	private ubyte b;

	@property ubyte red() { return r; }
	@property ubyte green() { return g; }
	@property ubyte blue() { return b; }

	@property ubyte red(ubyte r) { return this.r = r; }
	@property ubyte green(ubyte g) { return this.g = g; }
	@property ubyte blue(ubyte b) { return this.b = b; }

	this(ubyte r=0, ubyte g=0, ubyte b=0) {
		red = r;
		green = g;
		blue = b;
	}

	void setRGB(ubyte r, ubyte g, ubyte b) {
		red = r;
		green = g;
		blue = b;
	}

	string fgEscapeCode(bool bold=false) {
		return "\033["~(bold ? "1;" : "")~"38;2;"~red.to!string~";"~green.to!string~";"~blue.to!string~"m";
	}

	string bgEscapeCode() {
		return "\033[48;2;"~red.to!string~";"~green.to!string~";"~blue.to!string~"m";
	}
}

immutable string escape = "\033[0m";
