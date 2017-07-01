#!/usr/bin/perl

use strict;
use Switch;

# Program to fill the note mapping of handbell music using lilypond

# Use hash:
#	- first level indicating all notes possible
#	- second level 1 or 0 to indicate if note is present or missing respectively

my %notes =
(
	# First Octave:
	"c,", "0",
	"cis,", "0",
	"des,", "0",
	"d,", "0",
	"dis,", "0",
	"ees,", "0",
	"e,", "0",
	"f,", "0",
	"fis,", "0",
	"ges,", "0",
	"g,", "0",
	"gis,", "0",
	"aes,", "0",
	"a,", "0",
	"ais,", "0",
	"bes,", "0",
	"b,", "0",
	# Second Octave:
	"c", "0",
	"cis", "0",
	"des", "0",
	"d", "0",
	"dis", "0",
	"ees", "0",
	"e", "0",
	"f", "0",
	"fis", "0",
	"ges", "0",
	"g", "0",
	"gis", "0",
	"aes", "0",
	"a", "0",
	"ais", "0",
	"bes", "0",
	"b", "0",
	# Third Octave:
	"c'", "0",
	"cis'", "0",
	"des'", "0",
	"d'", "0",
	"dis'", "0",
	"ees'", "0",
	"e'", "0",
	"f'", "0",
	"fis'", "0",
	"ges'", "0",
	"g'", "0",
	"gis'", "0",
	"aes'", "0",
	"a'", "0",
	"ais'", "0",
	"bes'", "0",
	"b'", "0",
	# Fourth Octave:
	"c''", "0",
	"cis''", "0",
	"des''", "0",
	"d''", "0",
	"dis''", "0",
	"ees''", "0",
	"e''", "0",
	"f''", "0",
	"fis''", "0",
	"ges''", "0",
	"g''", "0",
	"gis''", "0",
	"aes''", "0",
	"a''", "0",
	"ais''", "0",
	"bes''", "0",
	"b''", "0",
	# Fifth Octave:
	"c'''", "0",
	"cis'''", "0",
	"des'''", "0",
	"d'''", "0",
	"dis'''", "0",
	"ees'''", "0",
	"e'''", "0",
	"f'''", "0",
	"fis'''", "0",
	"ges'''", "0",
	"g'''", "0",
	"gis'''", "0",
	"aes'''", "0",
	"a'''", "0",
	"ais'''", "0",
	"bes'''", "0",
	"b'''", "0"
);

my %note_dictionary =
(
	# First Octave:
	"c,", "0",
	"cis,", "1",
	"des,", "2",
	"d,", "3",
	"dis,", "4",
	"ees,", "5",
	"e,", "6",
	"f,", "7",
	"fis,", "8",
	"ges,", "9",
	"g,", "10",
	"gis,", "11",
	"aes,", "12",
	"a,", "13",
	"ais,", "14",
	"bes,", "15",
	"b,", "16",
	# Second Octave:
	"c", "17",
	"cis", "18",
	"des", "19",
	"d", "20",
	"dis", "21",
	"ees", "22",
	"e", "23",
	"f", "24",
	"fis", "25",
	"ges", "26",
	"g", "27",
	"gis", "28",
	"aes", "29",
	"a", "30",
	"ais", "31",
	"bes", "32",
	"b", "33",
	# Third Octave:
	"c'", "34",
	"cis'", "35",
	"des'", "36",
	"d'", "37",
	"dis'", "38",
	"ees'", "39",
	"e'", "40",
	"f'", "41",
	"fis'", "42",
	"ges'", "43",
	"g'", "44",
	"gis'", "45",
	"aes'", "46",
	"a'", "47",
	"ais'", "48",
	"bes'", "49",
	"b'", "50",
	# Fourth Octave:
	"c''", "50",
	"cis''", "51",
	"des''", "52",
	"d''", "53",
	"dis''", "54",
	"ees''", "55",
	"e''", "56",
	"f''", "57",
	"fis''", "58",
	"ges''", "59",
	"g''", "60",
	"gis''", "61",
	"aes''", "62",
	"a''", "63",
	"ais''", "64",
	"bes''", "65",
	"b''", "66",
	# Fifth Octave:
	"c'''", "67",
	"cis'''", "68",
	"des'''", "69",
	"d'''", "70",
	"dis'''", "71",
	"ees'''", "72",
	"e'''", "73",
	"f'''", "74",
	"fis'''", "75",
	"ges'''", "76",
	"g'''", "77",
	"gis'''", "78",
	"aes'''", "79",
	"a'''", "80",
	"ais'''", "81",
	"bes'''", "82",
	"b'''", "83"
);

my $doc = $ARGV[0];
open my $input_file, '<', $doc or die "Could not open '$doc' $!";
while (my $line = <$input_file>)
{
	chomp $line;
	foreach my $note (split /[\<\>\d+\s+]/, $line)
	{
		if (exists $notes{$note})
		{
			switch($notes{$note}){
				case "0"		{ $notes{$note}++; }
				else			{ }
			}
		}
	}
}
close $input_file;
my @fileArray = split(/\./, $doc);
my $filename = $fileArray[0];

my @bass_map;
my @treble_map;
my @note_array;
foreach my $note (keys %notes)
{
	switch($notes{$note})
	{
		case 1
		{
			# If bass note:
			if ($note !~ '\w+\'' || $note =~ 'c\'$' || $note =~ 'cis\'$')
			{
				push @bass_map, $note;
			}
			else
			{
				push @treble_map, $note;
			}
			push @note_array, $note;
		}
		# Debug from case 1: printf "%-8s %s\n", $note, $notes{$note};
		else	{ }
	}
}

my @bassFinal;
my @trebleFinal;

########################################################################
################## SORT NOTES INTO CHROMATIC ORDER #####################
########################################################################
foreach (@bass_map)
{
	my $index = $note_dictionary{$_};
	$bassFinal[$index] = " $_";
}
my $bassStr = join("", @bassFinal);
foreach (@treble_map)
{
	my $index = $note_dictionary{$_};
	$trebleFinal[$index] = " $_";
}
my $trebleStr = join("", @trebleFinal);


my $notesContained = "\\score {
  \\new StaffGroup
  <<
    \\new Staff = \"upper\" {
      \\key c \\major
      % These are notes up to c# (middle c#)
      $trebleStr
    }
    \\new Staff = \"lower\" {
      \\clef bass
      \\key c \\major
      % These are notes from db (d flat of middle c)
      $bassStr
    }
  >>
}
";



################################################################
$filename .= ".txt";
open(my $output_file, '>', $filename);
print $output_file "$notesContained";
close $output_file;
print "notemap: Wrote note-mapping to $filename\n";

# print $notesContained;