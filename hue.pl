#!/usr/bin/perl -w

# USAGE:
# /white <text>
# output white text
# if the first word of the text is /topic, /kick, or /me, completes those 
# commands with colored text.
# 
# The following commands work in the same way with their respective colors:
# /red <text>
# /lightred <text>
# 	lightred is also aliased to /boldred <text>
# /orange <text>
#	orange is also aliased to /brown <text>
# /yellow <text>
# /green <text>
# /lightgreen <text>
# 	lightgreen is also aliased to /lime <text>
# /cyan <text>
# /lightcyan <text>
# /lightblue <text>
# /blue <text>
# /magenta <text>
# 	magenta is also aliased to /purple <text>
# /lightmagenta <text>
# 	lightmagenta is also aliased to /lightpurple <text> and /boldpurple 
#	<text>
# /black <text>
# /gray <text>
# 	gray is also aliased to /grey <text>
# /lightgray <text>
# 	lightgray is also aliased to /lightgrey <text>

# Modified from rainbow.pl by Jakub Jankowski <shasta@atn.pl>
# for Irssi 0.7.98.4 and newer

use strict;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
    authors     => 'Laurel "Kona" Hart',
    contact     => 'laurel.elise.hart@gmail.com',
    name        => 'hue',
    description => 'Simple aliases for color text (all one color).',
    license     => 'GNU GPLv2 or later',
#    url         => '',
);

use Irssi;
use Irssi::Irc;

# str make_colors($color, $string)
# returns colored string
sub make_colors {
	my ($color, $string) = @_;
	Encode::_utf8_on($string);
	my $newstr = "\003";
	$newstr .= $color;

	$newstr .= substr($string, 0);
	return $newstr;
}

# void colorify($text, $server, $destination, $colorscheme)
# handles /msg, /me, /topic, and /kick and colors string
sub colorify {
	my ($text, $server, $dest, $colorscheme) = @_;

	if (!$server || !$server->{connected}) {
		Irssi::print("Not connected to server");
		return;
	}

	if ($dest) {
		my ($command, $message) = split(/ +/, $text, 2);
		$command = lc $command;
		if ($dest->{type} eq "CHANNEL") { 
			if ($command eq "/me") {
				$dest->command("/me " . 
				make_colors($colorscheme, $message));
			} elsif ($command eq "/topic") {
				$dest->command("/topic " . 
				make_colors($colorscheme, $message));
			} elsif ($command eq "/kick") {
				my ($nick, $reason) = split(/ +/, $message, 2);
				return unless $nick;
				$reason = "Irssi power!" if (
					$reason =~ /^[\ ]*$/);
				$dest->command("/kick " . $nick . " " . 
				make_colors($colorscheme, $reason));
			} else {
				$dest->command("/msg " . $dest->{name} . " " . 
				make_colors($colorscheme, $text));
			}
			
		} elsif ($dest->{type} eq "QUERY") {
			if ($command eq "/me") {
				$dest->command("/me " . make_colors($message));
			} else {
				$dest->command("/msg " . $dest->{name} . " " . 
				make_colors($colorscheme, $text));
			}
		}

	} 
}

# colors list (foregrounds)
#  0 == white
#  5 == red
#  4 == light red
#  7 == orange
#  8 == yellow
#  9 == light green
#  3 == green
# 10 == cyan
# 11 == light cyan
# 12 == light blue
#  2 == blue
#  6 == magenta
# 13 == light magenta
# 15 == light gray
# 14 == gray
#  1 == black

# void white($text, $server, $destination)
sub white {
	colorify(@_, '0');
}

sub red {
	colorify(@_, '5');
}

sub lightred {
	colorify(@_, '4');
}

sub orange {
	colorify(@_, '7');
}

sub yellow {
	colorify(@_, '8');
}

sub lightgreen {
	colorify(@_, '9');
}

sub green {
	colorify(@_, '3');
}

sub cyan {
	colorify(@_, '10');
}

sub lightcyan {
	colorify(@_, '11');
}

sub lightblue {
	colorify(@_, '12');
}

sub blue {
	colorify(@_, '2');
}

sub magenta {
	colorify(@_, '6');
}

sub lightmagenta {
	colorify(@_, '13');
}

sub black {
	colorify(@_, '1');
}

sub gray {
	colorify(@_, '14');
}

sub lightgray {
	colorify(@_, '15');
}

Irssi::command_bind("white", "white");
Irssi::command_bind("red", "red");
Irssi::command_bind("lightred", "lightred");
Irssi::command_bind("boldred", "lightred");
Irssi::command_bind("orange", "orange");
Irssi::command_bind("brown", "orange");
Irssi::command_bind("yellow", "yellow");
Irssi::command_bind("green", "green");
Irssi::command_bind("lightgreen", "lightgreen");
Irssi::command_bind("lime", "lightgreen");
Irssi::command_bind("cyan", "cyan");
Irssi::command_bind("lightcyan", "lightcyan");
Irssi::command_bind("lightblue", "lightblue");
Irssi::command_bind("blue", "blue");
Irssi::command_bind("magenta", "magenta");
Irssi::command_bind("purple", "magenta");
Irssi::command_bind("lightmagenta", "lightmagenta");
Irssi::command_bind("lightpurple", "lightmagenta");
Irssi::command_bind("boldpurple", "lightmagenta");
Irssi::command_bind("black", "black");
Irssi::command_bind("gray", "gray");
Irssi::command_bind("grey", "gray");
Irssi::command_bind("lightgray", "lightgray");
Irssi::command_bind("lightgrey", "lightgray");
