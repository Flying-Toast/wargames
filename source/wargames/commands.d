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

Command[] commands = [
	Command("", "LOGON:", "", 0),
	Command("joshua", "", "", 0),
	Command("", "GREETINGS PROFESSOR FALKEN.", "greetings", 50),
	Command("hello", "HOW ARE YOU FEELING TODAY?", "howAreYou", 45),
	Command("how are you", "EXCELLENT. IT'S BEEN A LONG TIME.", "explain", 45),
	Command("", "CAN YOU EXPLAIN THE REMOVAL OF YOUR USER ACCOUNT ON JUNE 23, 1973?", "", 45),
	Command(6000),
	Command("people sometimes make mistakes", "YES THEY DO.", "mistakes", 45),
	Command(2000),
	Command("", "SHALL WE PLAY A GAME?", "play", 45),
	Command("global thermonuclear war", "WOULDN'T YOU PREFER A GOOD GAME OF CHESS?", "chess", 45),
	Command("later", "FINE.", "fine", 45),
	Command(1000),
	Command("", "CLEARSCREEN", "", 0)
];

void generateCommands() {
	import std.string;
	import std.array : replicate;
	string[] usaLines = usaMap.splitLines();
	string[] ussrLines = ussrMap.splitLines();

	if (usaLines.length > ussrLines.length) {
		foreach (i; 0 .. usaLines.length - ussrLines.length) {
			ussrLines ~= "";
		}
	} else if (usaLines.length < ussrLines.length) {
		foreach (i; 0 .. ussrLines.length - usaLines.length) {
			usaLines ~= "";
		}
	}

	foreach (i; 0 .. usaLines.length) {
		commands ~= Command("", usaLines[i]~"    "~ussrLines[i].stripRight(), "", 1);
	}

	commands ~= [
		Command("", " ".replicate(usaLines[0].length / 2 - 7)~"UNITED STATES"~" ".replicate((usaLines.length / 2) + 7 - 6 + (ussrLines[0].length/2))~"SOVIET UNION", "", 45)
	];
}

private immutable string usaMap = q"USA
  ,+ .:;,.                                     
               `..,,:::::.`                `.  
 .                       .;;;:;;      `;;. '   
#                            ++ ,    ``   '    
                             .`  + '     ;     
.                                      ;'      
;                                      #       
 .                                             
  .`                                   :       
    ,;.                              +         
        .:;;::                      ;          
              ;  `           :``:;; :          
                  '   ::           ' `         
                   '.+               ;:        
USA";

private immutable string ussrMap = q"USSR
                                   _   
                                 ,  :    
                                `        
                             .,`    ` ,  
       , .         `:  : , `.      `: `  
   ..:`;,      ::.`   `            ` ' : 
  '                               ,    ,:
 .`                              .       
  `                              .:`;    
`.`                                  ;   
`   '  :. ,..:                . ,,,, '   
 ,`            `       .    ,,      .,   
                  ,,```                  
USSR";
