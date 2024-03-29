#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
use ExtUtils::MakeMaker;
use 5.008;

WriteMakefile(
	NAME => "App::getpaste",
	AUTHOR => "Mantas Mikulėnas <grawity\@gmail.com>",
	VERSION => "0.20",
	LICENSE => "mit",
	PREREQ_PM => {
		"perl" => "v5.10",
		"Compress::LZW" => 0,
		"Compress::Raw::Zlib" => 0,
		"CryptX" => 0,
		"HTML::Entities" => 0,
		"IO::Uncompress::Inflate" => 0,
		"IO::Uncompress::RawInflate" => 0,
		"JSON" => 0,
		"LWP::UserAgent" => 0,
		"MIME::Base64" => 0,
	},
	EXE_FILES => [
		"getpaste",
	],
);
