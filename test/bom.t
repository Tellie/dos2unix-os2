#!/usr/bin/perl

# Requires perl-Test-Simple installation.
use Test::Simple tests => 12;

$suffix = "";
if (-e "../dos2unix.exe") {
  $suffix = ".exe";
}
$DOS2UNIX = "../dos2unix" . $suffix;
$MAC2UNIX = "../mac2unix" . $suffix;
$UNIX2DOS = "../unix2dos" . $suffix;
$UNIX2MAC = "../unix2mac" . $suffix;

$ENV{'LC_ALL'} = 'C';

system("$DOS2UNIX -v -n dos_bom.txt out_unix.txt; cmp out_unix.txt unix.txt");
ok( $? == 0, 'dos2unix removes UTF-8 BOM' );

system("$DOS2UNIX -v -b -n dos_bom.txt out_unix.txt; cmp out_unix.txt unix_bom.txt");
ok( $? == 0, 'dos2unix -b keeps UTF-8 BOM' );

system("$DOS2UNIX -v -m -n dos.txt out_unix.txt; cmp out_unix.txt unix_bom.txt");
ok( $? == 0, 'dos2unix -m adds UTF-8 BOM' );

system("$UNIX2DOS -v -n unix_bom.txt out_dos.txt; cmp out_dos.txt dos_bom.txt");
ok( $? == 0, 'unix2dos keeps UTF-8 BOM' );

system("$UNIX2DOS -v -r -n unix_bom.txt out_dos.txt; cmp out_dos.txt dos.txt");
ok( $? == 0, 'unix2dos -r removes UTF-8 BOM' );

system("$UNIX2DOS -v -m -n unix.txt out_dos.txt; cmp out_dos.txt dos_bom.txt");
ok( $? == 0, 'unix2dos -m adds UTF-8 BOM' );

system("$DOS2UNIX -v -b -n dos_gb.txt out_unix.txt; cmp out_unix.txt unix_gb.txt");
ok( $? == 0, 'dos2unix -b keeps GB18030 BOM in none-GB18030 locale' );

system("$UNIX2DOS -v -n unix_gb.txt out_dos.txt; cmp out_dos.txt dos_gb.txt");
ok( $? == 0, 'unix2dos keeps GB18030 BOM in none-GB18030 locale' );

system("$DOS2UNIX -v -n inval_bom_utf8.txt out_unix.txt; cmp out_unix.txt inval_bom_utf8.txt");
ok( $? == 0, 'dos2unix succeeds on file with half UTF8 BOM' );

system("$DOS2UNIX -v -n inval_bom_utf16le.txt out_unix.txt; cmp out_unix.txt inval_bom_utf16le.txt");
ok( $? == 0, 'dos2unix succeeds on file with half UTF16-LE BOM' );

system("$DOS2UNIX -v -n inval_bom_utf16be.txt out_unix.txt; cmp out_unix.txt inval_bom_utf16be.txt");
ok( $? == 0, 'dos2unix succeeds on file with half UTF16-BE BOM' );

system("$DOS2UNIX -v -n inval_bom_gb.txt out_unix.txt; cmp out_unix.txt inval_bom_gb.txt");
ok( $? == 0, 'dos2unix succeeds on file with half GB18030 BOM' );
