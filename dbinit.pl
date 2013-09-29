use lib 'lib/simple';
use db;

sub init{
	my $teng = shift;
	print "Create TABLE todos\n";
	$teng->do(q{
		CREATE TABLE todos (
			id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
			name TEXT NOT NULL,
			comment TEXT default NULL,
			created_at TIMESTAMP default current_timestamp,
			updated_at TIMESTAMP,
			parent_id INT default NULL,
			deadline TIMESTAMP
		)
	});
}

print "DB initializing...\n";
$teng = teng();
init($teng);
print "DB initialized...\n";

1;