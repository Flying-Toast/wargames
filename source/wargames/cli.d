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
		fg = new Color(132, 217, 236);
		bg = new Color;
	}

	///erase the screen with `bg` and go to 0,0
	void clearScreen() {
		write(bg.bgEscapeCode, fg.fgEscapeCode(true), "\033[2J", "\033[0;0H");
	}

	void runCli() {
		scope (exit) {
			writeln(escape); //clear terminal colors.
		}

		clearScreen();

		while (true) {
			write("LOGON: ");
			string line = readln().replace("\n", "").toLower;

			if (line == "joshua") {
				writeln();
				break;
			} else if (line == "help games") {
				writeln();
				typeText("'GAMES' REFERES TO MODELS, SIMULATIONS, AND GAMES", "helpgames", 45);
				typeText("WHICH HAVE TACTICAL AND STRATEGIC APPLICATIONS.", "", 45);
			} else if (line == "help logon") {
				writeln();
				typeText("HELP NOT AVAILABLE", "nohelp", 45);
			} else if (line == "list games") {
				writeln();
				typeText("FALKEN'S MAZE", "falkensmaze", 45);
				Thread.sleep(dur!"msecs"(1500));
				typeText("BLACK JACK", "blackjack", 45);
				Thread.sleep(dur!"msecs"(600));
				typeText("GIN RUMMY", "rummy", 45);
				Thread.sleep(dur!"msecs"(600));
				typeText("HEARTS", "hearts", 45);
				Thread.sleep(dur!"msecs"(400));
				typeText("BRIDGE", "bridge", 45);
				Thread.sleep(dur!"msecs"(300));
				typeText("CHECKERS", "checkers", 45);
				Thread.sleep(dur!"msecs"(500));
				typeText("CHESS", "chessgame", 45);
				Thread.sleep(dur!"msecs"(300));
				typeText("POKER", "poker", 45);
				Thread.sleep(dur!"msecs"(200));
				typeText("FIGHTER COMBAT", "fightercombat", 45);
				Thread.sleep(dur!"msecs"(100));
				typeText("GUERRILLA ENGAGEMENT", "engagement", 45);
				Thread.sleep(dur!"msecs"(250));
				typeText("DESERT WARFARE", "desert", 45);
				Thread.sleep(dur!"msecs"(1100));
				typeText("AIR-TO-GROUND ACTIONS", "actions", 20);
				Thread.sleep(dur!"msecs"(800));
				typeText("THEATERWIDE TACTICAL WARFARE", "tactical", 45);
				Thread.sleep(dur!"msecs"(1000));
				typeText("THEATERWIDE BIOTOXIC AND CHEMICAL WARFARE", "biotoxic", 45);
				Thread.sleep(dur!"msecs"(1300));
				typeText("", "", 0);
				typeText("GLOBAL THERMONUCLEAR WAR", "global", 45);
			} else {
				writeln();
				typeText("IDENTIFICATION NOT RECOGNIZED BY SYSTEM", "terminated", 35);
				typeText("--CONNECTION TERMINATED--", "", 25);
				Thread.sleep(dur!"msecs"(1500));
				clearScreen();
			}
		}

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
		if (str == "CLEARSCREEN") {
			clearScreen();
			return;
		}
		foreach (i; 0 .. str.length+1) {
			writeln("\033[1A", str[0 .. i]); //go up 1 line then print one more char than last time
			Thread.sleep(dur!"msecs"(delay));
		}
	}
}

version(linux) {
	///plays the sound at sounds/`sound`.wav
	private void playSound(string sound) {
		executeShell("nohup aplay "~getcwd~"/sounds/"~sound~".wav");
	}
}

version(OSX) {
	//plays the sound at sounds/`sound`.wav
	private void playSound(string sound) {
		executeShell("nohup afplay "~getcwd~"/sounds/"~sound~".wav");
	}
}

version(Windows) {
	//so that it still compiles on windows, even though the sound wont work
	private void playSound(string sound) {}
}
