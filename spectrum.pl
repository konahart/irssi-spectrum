#!/usr/bin/perl -w

# USAGE:
#

# Modified from rainbow.pl by Jakub Jankowski <shasta@atn.pl>
# for Irssi 0.7.98.4 and newer

use strict;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
    authors     => 'Laurel "Kona" Hart',
    contact     => 'laurel.elise.hart@gmail.com',
    name        => 'spectrum',
#    description => '',
    license     => 'GNU GPLv2 or later',
#    url         => '',
);

use Irssi;
use Irssi::Irc;

#Config:
my $colorspan = 2;

# colors list (foregrounds)
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

#not used:
#  0 == white
#  1 == black
# 14 == gray
# 15 == light gray

my @rainbow = ('5', '4', '7', '8', '9', '3', '10', '11', '12', '2', '6', '13');
my @bright = ('4', '8', '9', '11', '12', '13');
my @cool = ('9', '11', '12', '13');

# str make_colors($colorscheme, $string)
# returns a string colored according to colorscheme
sub make_colors {
	my ($colorscheme, $string) = @_;
	Encode::_utf8_on($string);
	my $newstr = "";

	#pick a random color to start on
	my $start = int(rand(scalar(@{$colorscheme})));
	my $color = $start;

	my $i = 0;
	for (my $c = 0; $c < length($string); $c++) {
		my $char = substr($string, $c, 1);
		#don't color spaces
		if ($char eq ' ') {
			$newstr .= $char;
			next;
		}
		if ($i % $colorspan == 0){  
			$color++;	
			$color = $color % @{$colorscheme};
			$newstr .= "\003";
			$newstr .= sprintf("%02d", $colorscheme->[$color]);
		}
		$newstr .= $char;
		$i++;
	}

	return $newstr;
}

# void colourify($text, $server, $destination, $colorscheme)
# handles /msg, /me, /topic, and /kick and colors string
sub colourify {
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

# void rainbow($text, $server, $destination)
sub rainbow {
	colourify(@_, \@rainbow);
}

# void rainbow($text, $server, $destination)
sub bright {
	colourify(@_, \@bright);
}

# void rainbow($text, $server, $destination)
sub cool {
	colourify(@_, \@cool);
}


Irssi::command_bind("rainbow", "rainbow");
Irssi::command_bind("bright", "bright");
Irssi::command_bind("cool", "cool");
