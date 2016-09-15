#!\usr\bin\perl

use warnings;
use strict;
use DBI;

# Q. Write a Perl program that prompts the user for a GO term ID, 
#    queries the term table for that ID, and displays the name.

my($dbh, $sth, $name, $id);

$dbh=DBI->connect('dbi:mysql:go','vadali.s','BIO')||
	die "Error opening database: $DBI::errstr\n";

print "Please enter GO term ID : ";
$id =  <STDIN>;
chomp $id;

$sth=$dbh->prepare("SELECT name from term where id = '$id';")||
	die "Prepare failed: $DBI::errstr\n";

$sth->execute() ||
	die "Couldn't execute query: $DBI::errstr\n";

if (($name) = $sth->fetchrow_array) {
	print "$id has the following name : $name\n";
} else {
	print "Unable to find name for given id : $id\n";
}

$sth->finish();

$dbh->disconnect || die "Failed to disconnect\n";

