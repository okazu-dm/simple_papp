use Teng;
use Teng::Schema::Loader;

sub teng{	
	my $self = shift;
	my $dbname = "kossy";
	my $user = "kossy";
	my $passwd = "kossy";
	my $dbh = DBI->connect("dbi:mysql:$dbname:localhost", $user, $passwd, {
		"mysql_enable_utf8" => 1,
	});
	my $teng = Teng::Schema::Loader->load(
		'dbh' => $dbh,
		'namespace' => 'MyApp::DB',
	);
	return $teng;
}


1;
