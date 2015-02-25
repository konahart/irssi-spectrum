#!/usr/bin/perl -w

# USAGE:
# /pride <text>
# output colored text in the pride colorscheme
# unlike the spectrum script, these always start on the same color
# if the first word of the text is /topic, /kick, or /me, completes those 
# commands with colored text.
#
# The following commands work in the same way with their respective colors:
# /trans <text>
# /genderqueer <text>
# /bi <text>
# /pan <text>
# /poly <text>
# /ace <text>
# /graya <text>
#
# I have done my best to match colors, but a lot of the flag colors simply aren't
# currently supported in irssi. Some look better/closer than others.

# Modified from rainbow.pl by Jakub Jankowski <shasta@atn.pl>
# for Irssi 0.7.98.4 and newer

use strict;
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI = (
    authors     => 'Laurel "Kona" Hart',
    contact     => 'laurel.elise.hart@gmail.com',
    name        => 'pride',
    description => 'Print colored text in gsrm/lgbtq/quiltbag colorschemes.',
    license     => 'GNU GPLv2 or later',
#    url         => '',
);

use Irssi;
use Irssi::Irc;

#Config:
my $colorspan = 4; #how many characters makes up each color before switching

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
#  1 == black
# 14 == gray
# 15 == light gray

my @pride = ('5', '4', '7', '8', '9', '3', '10', '11', '12', '2', '6', '13');
my @trans = ('12', '4', '0', '4', '12');
my @genderqueer = ('13', '0', '3');
my @bi = ('4', '4', '6', '2', '2');
my @pan = ('4', '8', '11');
my @poly = ('4', '3', '12');
my @ace = ('1', '14', '0', '6');
my @lightace = ('14', '15', '0', '6');
my @aro = ('3', '9', '0', '14', '1');
my @lightaro = ('3', '9', '0', '15', '14');

# str make_colors($colorscheme, $string)
# returns a string colored according to colorscheme, starting at a random point
# in the colorscheme
sub make_colors {
	my ($colorscheme, $string) = @_;
	Encode::_utf8_on($string);
	my $newstr = "";
	my $color = -1;

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

# void pride($text, $server, $destination)
sub pride {
	colorify(@_, \@pride);
}

# void trans($text, $server, $destination)
sub trans {
	colorify(@_, \@trans);
}

# void genderqueer($text, $server, $destination)
sub genderqueer {
	colorify(@_, \@genderqueer);
}

# void bi($text, $server, $destination)
sub bi {
	colorify(@_, \@bi);
}

# void pan($text, $server, $destination)
sub pan {
	colorify(@_, \@pan);
}

# void poly($text, $server, $destination)
sub poly {
	colorify(@_, \@poly);
}

# void ace($text, $server, $destination)
sub ace {
	colorify(@_, \@ace);
}

# void lightace($text, $server, $destination)
sub lightace {
	colorify(@_, \@lightace);
}

# void aro($text, $server, $destination)
sub aro {
	colorify(@_, \@aro);
}

# void lightaro($text, $server, $destination)
sub lightaro {
	colorify(@_, \@lightaro);
}

Irssi::command_bind("pride", "pride");
Irssi::command_bind("trans", "trans");
Irssi::command_bind("genderqueer", "genderqueer");
Irssi::command_bind("bi", "bi");
Irssi::command_bind("pan", "pan");
Irssi::command_bind("poly", "poly");
Irssi::command_bind("ace", "ace");
Irssi::command_bind("lightace", "lightace");
Irssi::command_bind("aro", "aro");
Irssi::command_bind("lightaro", "lightaro");
