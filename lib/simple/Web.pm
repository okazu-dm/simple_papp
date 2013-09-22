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
    $c->render('index.tx', {class_home => "active"});
};

get '/form' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;
    $c->render('form.tx', {class_post => "active"});
};

post '/post' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;
	my $result = $c->req->validator([
		'msg' => {
			rule => [['NOT_NULL', 'Input some message.']]
		}
	]);
	if( $result->has_error ){
		return $c->render('form.tx', 
			{class_post => "active", info => $result->errors->{msg}});
	}
	my $teng = teng();
	my $msg = $result->valid->get('msg');
	my $row = $teng->insert('post' => {
		body => $msg
	});
    $c->render('index.tx', {class_home => "active", info => "You have posted: " . $msg });
};

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

