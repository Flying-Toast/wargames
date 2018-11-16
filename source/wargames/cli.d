module wargames.cli;

import wargames;
import std.stdio;
import std.process : executeShell;
import core.thread;
import std.file : getcwd;
import std.concurrency : spawn;
import std.string;

class Cli {
	Color fg;
	Color bg;

	this() {
		fg = new Color(90, 204, 179);
		bg = new Color;
	}

	///erase the screen with `bg` and go to 0,0
	void clearScreen() {
		write(bg.bgEscapeCode, fg.fgEscapeCode(true), "\033[2J", "\033[0;0H");
	}

	void runCli() {
		clearScreen();
		foreach (command; commands) {
			while ((!command.sleep && command.trigger != "") && (readln().replace("\n", "").toLower.indexOf(command.trigger) == -1)) {}

			if (command.sleep) {
				Thread.sleep(dur!"msecs"(command.sleepTime));
				continue;
			}
			
			typeText(command.response, command.soundName, command.delay);
		}
	}

	///Prints out a string with a delay(in milliseconds) between each character
	void typeText(string str, string sound="", ushort delay=50) {
		if (sound != "") {
			spawn(&playSound, sound);
		}
		writeln();
		foreach (i; 0 .. str.length+1) {
			writeln("\033[1A", str[0 .. i]); //go up 1 line then print one more char than last time
			Thread.sleep(dur!"msecs"(delay));
		}
	}
}

///plays the sound at 'sounds/sound.wav'
private void playSound(string sound) {
	executeShell("nohup aplay "~getcwd~"/sounds/"~sound~".wav");
}
