package simple::Web;

use strict;
use warnings;
use utf8;
use Kossy;
use DBI;
use Data::Dumper;
use lib 'lib/simple';
use db;

filter 'set_title' => sub {
    my $app = shift;
    sub {
        my ( $self, $c )  = @_;
        $c->stash->{site_name} = "Kossy training";
        $app->($self,$c);
    }
};


get '/' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;
    my $teng = teng();
    my $name = $result->valid->get('name');
    
    
    $c->render('index.tx', {class_home => "active"});
};

get '/form' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;
    $c->render('form.tx', {class_post => "active"});
};

post '/create' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;
	my $result = $c->req->validator([
		'name' => {
			rule => [['NOT_NULL', 'Input some message.']]
		}
	]);
	if( $result->has_error ){
		return $c->render('form.tx', 
			{class_post => "active", info => $result->errors->{name}});
	}
	my $teng = teng();
    my $name = $result->valid->get('name');
	my $comment = $result->valid->get('comment');
	my $row = $teng->insert('todos' => {
		name => $name,
        cooment => $comment
	});
    $c->render('index.tx', {class_home => "active", info => "You have posted: " . $msg });
};

post '/update' => [qw/set_title/] => sub {
       
}

post '/delete' => [qw/set_title/] => sub {

}


post '/login' => [qw/set_title/] => sub {

}


get '/json' => sub {
    my ( $self, $c )  = @_;
    my $result = $c->req->validator([
        'q' => {
            default => 'Hello',
            rule => [
                [['CHOICE',qw/Hello Bye/],'Hello or Bye']
            ],
        }
    ]);
    $c->render_json({ greeting => $result->valid->get('q') });
};






1;

