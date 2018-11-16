module wargames.commands;

immutable struct Command {
	string soundName;///the name of the sound, relative to sounds/, without ".wav"
	string trigger;
	string response;
	ushort delay;
	bool sleep;
	ushort sleepTime;

	this(string trigger, string response, string soundName, ushort delay) {
		this.soundName = soundName;
		this.trigger = trigger;
		this.response = response;
		this.delay = delay;
		this.sleep = false;
	}

	this(ushort sleepTime) {
		this.sleep = true;
		this.sleepTime = sleepTime;
	}
}

immutable Command[] commands = [
	Command("", "LOGON:", "", 0),
	Command("joshua", "", "", 0),
	Command("", "GREETINGS PROFESSOR FALKEN.", "greetings", 50),
	Command("hello", "HOW ARE YOU FEELING TODAY?", "howAreYou", 45),
	Command("how are you", "EXCELLENT. IT'S BEEN A LONG TIME. CAN YOU EXPLAIN THE REMOVAL OF YOUR USER ACCOUNT ON JUNE 23, 1973?", "explain", 45),
	Command(6000),
	Command("people sometimes make mistakes", "YES THEY DO.", "mistakes", 45),
	Command(2000),
	Command("", "SHALL WE PLAY A GAME?", "play", 45)
];
