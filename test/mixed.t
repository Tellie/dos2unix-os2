#!/usr/bin/perl

# Requires perl-Test-Simple installation.
use Test::Simple tests => 8;

$suffix = "";
if (-e "../dos2unix.exe") {
  $suffix = ".exe";
}
$DOS2UNIX = "../dos2unix" . $suffix;
$MAC2UNIX = "../mac2unix" . $suffix;
$UNIX2DOS = "../unix2dos" . $suffix;
$UNIX2MAC = "../unix2mac" . $suffix;

system("$DOS2UNIX -v -n mixed.txt out.txt; cmp out.txt mixedd2u.txt");
ok( $? == 0, 'DOS to Unix conversion mixed');
system("$MAC2UNIX -v -n mixed.txt out.txt; cmp out.txt mixedm2u.txt");
ok( $? == 0, 'Mac to Unix conversion mixed');
system("$UNIX2DOS -v -n mixed.txt out.txt; cmp out.txt mixedu2d.txt");
ok( $? == 0, 'Unix to DOS conversion mixed');
system("$UNIX2MAC -v -n mixed.txt out.txt; cmp out.txt mixedu2m.txt");
ok( $? == 0, 'Unix to Mac conversion mixed');

system("$DOS2UNIX -v -n mixed2.txt out.txt; cmp out.txt mixed2_d2u.txt");
ok( $? == 0, 'DOS to Unix conversion mixed2');
system("$MAC2UNIX -v -n mixed2.txt out.txt; cmp out.txt mixed2_m2u.txt");
ok( $? == 0, 'Mac to Unix conversion mixed2');
system("$UNIX2DOS -v -n mixed2.txt out.txt; cmp out.txt mixed2_u2d.txt");
ok( $? == 0, 'Unix to DOS conversion mixed2');
system("$UNIX2MAC -v -n mixed2.txt out.txt; cmp out.txt mixed2_u2m.txt");
ok( $? == 0, 'Unix to Mac conversion mixed2');
