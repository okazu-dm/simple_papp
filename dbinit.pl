use lib 'lib/simple';
use db;

sub init{
	my $teng = shift;
	print "Create TABLE post\n";
	$teng->do(q{
		CREATE TABLE post (
			id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
			body TEXT NOT NULL,
			created TIMESTAMP default current_timestamp
		)
	});
}

print "DB initializing...\n";
$teng = teng();
init($teng);
print "DB initialized...\n";

1;