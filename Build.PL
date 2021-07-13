#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
use Module::Build;
use 5.008;

my $build = Module::Build->new(
	module_name => "App::getpaste",
	license => "MIT",
	dist_author => "Mantas Mikulėnas <grawity\@gmail.com>",
	dist_version => "1.0",
	requires => {
		"perl" => "5.10.0",
		"HTML::Entities" => 0,
		"JSON" => 0,
		"LWP::UserAgent" => 0,
		"MIME::Base64" => 0,
	},
	recommends => {
		"Compress::Raw::Zlib" => 0,
		"Compress::LZW" => 0,
		"CryptX" => 0,
		"IO::Uncompress::Inflate" => 0,
		"IO::Uncompress::RawInflate" => 0,
	},
	script_files => [
		"getpaste",
	],
);

$build->create_build_script();
