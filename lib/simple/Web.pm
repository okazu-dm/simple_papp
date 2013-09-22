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
        $c->stash->{site_name} = __PACKAGE__;
        $app->($self,$c);
    }
};


get '/' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;
    $c->render('index.tx', { greeting => "Hello", class_home => "active"});
};

get '/form' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;
    $c->render('form.tx', {class_post => "active"});
};

post '/post' => sub {
    my ( $self, $c )  = @_;
    $c->render('post.tx', {class_post => "active"});
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

