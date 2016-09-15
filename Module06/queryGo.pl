#!\usr\bin\perl

use warnings;
use strict;
use DBI;

my($dbh, $sth, $name, $id);

$dbh=DBI->connect('dbi:mysql:go','vadali.s','BIO')||
	die "Error opening database: $DBI::errstr\n";

$sth=$dbh->prepare("SELECT id,name from term where id = 42952;")||
	die "Prepare failed: $DBI::errstr\n";

$sth->execute() ||
	die "Couldn't execute query: $DBI::errstr\n";

while (($id, $name) = $sth ->fetchrow_array) {
	print "$name has ID $id\n";
}

$sth->finish();

$dbh->disconnect || die "Failed to disconnect\n";

