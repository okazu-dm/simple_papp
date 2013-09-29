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
    my $itr = $teng->search('todos');
    $c->render('index.tx', {class_home => "active", itr => $itr});
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
        comment => $comment
	});
    $c->render('index.tx', {class_home => "active", info => "You have posted: " . $name });
};



post '/update/${id:[0-9]+}' => [qw/set_title/] => sub {
    my ( $self, $c ) = @_;
    my $id = $c->args->{id};
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
    my $row = $teng->search('todos', {id => $id});
    $row->update('todos' => {
        name => $name,
        comment => $comment
    });
    $c->render('index.tx', {class_home => "active", info => "You have updated: " . $name });
           
};

get '/test' => sub{
    my ( $self, $c )  = @_;
    my $param = $c->req->query_parameters_raw();
    my @k = $c->req->query_parameters_raw->mixed->{id};
    $c->render('index.tx', {class_home => "active", test=>@k,info => "GET: " . "@k"});
};


post '/delete/${id:[0-9]+}' => [qw/set_title/] => sub {
    my ( $self, $c ) = @_;
    my $id = $c->args->{id};
    my $teng = teng();
    $teng->delete('todos', +{id => $id});
    $c->redirect($c->req->uri_for('/'));
};


post '/login' => [qw/set_title/] => sub {

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

