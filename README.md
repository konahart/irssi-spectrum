# Irssi Spectrum
Make rainbows --- in IRC!

## Scripts
### Spectrum
Currently features three colorschemes: rainbow, bright, and cool. 
Able to handle /msg, /me, /topic, and /kick commands in rainbow color.
Usage:
* /rainbow <text>
* /bright <text>
* /cool <text>
See image below for demonstration. 
![spectrum demonstration](https://cloud.githubusercontent.com/assets/945693/6343589/175d9c0c-bba0-11e4-963a-935dff8bd767.png)
Note: Colors may appear differently in different terminals.

### Hue
Output text in command hue. If the first word of the text is /topic, /kick, or 
/me, completes those commands with colored text.
Commands:
* /white <text>
* /red <text>
* /lightred <text>
	* lightred is also aliased to /boldred <text>
* /orange <text>
	*orange is also aliased to /brown <text>
* /yellow <text>
* /green <text>
* /lightgreen <text>
	* lightgreen is also aliased to /lime <text>
* /cyan <text>
* /lightcyan <text>
* /lightblue <text>
* /blue <text>
* /magenta <text>
	* magenta is also aliased to /purple <text>
* /lightmagenta <text>
	* lightmagenta is also aliased to /lightpurple <text> and /boldpurple 
	  <text>
* /black <text>
* /gray <text>
	* gray is also aliased to /grey <text>
* /lightgray <text>
	* lightgray is also aliased to /lightgrey <text>
See image below for demonstration. 
![hue demonstration](https://cloud.githubusercontent.com/assets/945693/6343939/032cc018-bba6-11e4-8795-65cfac6d9eb1.png)
Note: Colors may appear differently in different terminals.
Some colors have multiple aliases in order to accomodate variances in display 
color and spelling.

## Installation
To use, place selected scripts in ~/.irssi/scripts. In irssi, type
```
/script load spectrum
/script load hue
```
Note: all scripts are standalone. You need only load the script with the 
commands you want.
Once the scripts are loaded, you can use the commands.