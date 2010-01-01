#!/usr/bin/perl
# retrieves raw text from a pastebin

# (c) 2009 Mantas Mikulėnas <grawity@gmail.com>
# Released under WTFPL v2 <http://sam.zoy.org/wtfpl/>

use warnings;
use strict;
no locale;

use LWP::Simple;

sub parse_url ($) {
	($_) = @_;
	my $h = qr[https?://];

	if (m!^${h}sprunge\.us/\w+!)
		{ return "$_"; }

	elsif (m!^${h}codepad\.org/(\w+)!)
		{ return "http://codepad.org/$1/raw"; }

	elsif (m!^${h}dpaste\.com/(?:hold/)?(\d+)!)
		{ return "http://dpaste.com/$1/plain/"; }

	elsif (m!^${h}((?:[\w-]+\.)?pastebin\.ca)/(\d+)!)
		{ return "http://$1/raw/$2"; }

	elsif (m!^${h}(pastebin\.com)/(\w+)!)
		{ return "http://$1/pastebin.php?dl=$2"; }

	elsif (m!^${h}(paste\.pocoo\.org)/(?:show|raw)/(\d+)!)
		{ return "http://$1/raw/$2/"; }

	elsif (m!^${h}paste2\.org/(?:p|get)/(\d+)!)
		{ return "http://paste2.org/get/$1"; }

	elsif (m!^${h}((?:code|dark-code)\.bulix\.org)/(\w+-\d+)!)
		{ return "http://$1/$2?raw"; }

	elsif (m!^${h}pastie\.org/(\d+)!)
		{ return "http://pastie.org/$1.txt"; }

	else
		{ return "$_"; }
}

my $showurl = ($ARGV[0] eq "-u");
shift @ARGV if $showurl;

my $url = shift @ARGV;

if (!defined $url) {
	print STDERR "Usage: getpaste [-u] <url>\n";
	exit 2;
}

if ($showurl) {
	print parse_url $url, "\n";
}
else {
	getprint parse_url $url;
}
