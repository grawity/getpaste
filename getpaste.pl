#!/usr/bin/env perl
# getpaste v0.9
# Retrieves raw text from a pastebin
#
# (c) 2009 Mantas Mikulėnas <grawity@gmail.com>
# Released under WTFPL v2 <http://sam.zoy.org/wtfpl/>

use warnings;
use strict;
no locale;

use LWP::Simple;

# Stolen from URI::Split
sub uri_split {
	return $_[0] =~ m,(?:([^:/?#]+):)?(?://([^/?#]*))?([^?#]*)(?:\?([^#]*))?(?:#(.*))?,;
}

use Data::Dumper;

sub parse_url {
	my ($url) = @_;
	my ($scheme, $host, $path, $query, $frag) = uri_split $url;
	$path =~ s|^/||;
	#print Dumper($scheme, $host, $path, $query, $frag);

	if ($host =~ /^sprunge\.us$/)
		{ return $url }

	elsif ($host =~ /^codepad\.org$/ and $path =~ m!^(\w+)!)
		{ return "http://$host/$1/raw" }
	
	elsif ($host =~ /^dpaste\.(org|de)$/ and $path =~ m!^(\w+)!)
		{ return "http://$host/$1/raw/" }

	elsif ($host =~ /^dpaste\.com$/ and $path =~ m!^(?:hold/)?(\d+)!)
		{ return "http://$host/$1/plain/" }

	elsif ($host =~ /^(?:[\w-]+\.)?pastebin\.ca$/ and $path =~ m!^(?:raw/)?(\d+)!)
		{ return "http://$host/raw/$1" }

	elsif ($host =~ /^pastebin\.com$/ and $path =~ m!^(\w+)!)
		{ return "http://$host/download.php?i=$1" }

	elsif ($host =~ /^pastebin\.org$/ and $path =~ m!^(?:pastebin\.php\?dl=)?(\d+)!)
		{ return "http://$host/pastebin.php?dl=$1" }

	elsif ($host =~ /^pastie\.org$/ and $path =~ m!^(\d+)!)
		{ return "http://$host/pastes/$1/download" }
	
	# LodgeIt
	elsif ($host =~ /^paste\.pocoo\.org|bpaste\.net$/ and $path =~ m!^(?:show|raw)/(\d+)!)
		{ return "http://$host/raw/$1" }

	elsif ($host =~ /(?:dark-)?code\.bulix\.org$/ and $path =~ m!^(\w+-\d+)!)
		{ return "http://$host/$1?raw" }

	elsif ($host =~ /^fpaste\.org$/ and $path =~ m!^(\w+)!)
		{ return "http:/?$host/$1/raw/" }

	else
		{ return "$url" }
}

my $showurl = ($ARGV[0] eq "-u");
shift @ARGV if $showurl;

if (!@ARGV) {
	print STDERR "Usage: getpaste [-u] <url>\n";
	exit 2;
}

for my $url (@ARGV) {
	if ($showurl) {
		print parse_url($url), "\n";
	}
	else {
		getprint parse_url($url);
		print "\n";
	}
}
