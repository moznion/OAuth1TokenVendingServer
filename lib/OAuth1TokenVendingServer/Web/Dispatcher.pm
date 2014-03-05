package OAuth1TokenVendingServer::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use OAuth::Lite::Consumer;
use OAuth::Lite::Token;
use OAuth1TokenVendingServer;

my $config = OAuth1TokenVendingServer->load_config;

my $app_name     = $config->{app_name};
my $description  = $config->{description};
my $callback_url = $config->{callback_url};
my $scope        = join(',', @{$config->{scope}});

my $consumer    = OAuth::Lite::Consumer->new(
    consumer_key       => $config->{consumer_key},
    consumer_secret    => $config->{consumer_secret},
    site               => $config->{site},
    request_token_path => $config->{request_token_path},
    access_token_path  => $config->{access_token_path},
    authorize_path     => $config->{authorize_path},
);

get '/' => sub {
    my ($c) = @_;

    return $c->render('index.tx', {
        app_name    => $app_name,
        description => $description,
    });
};

get '/auth' => sub {
    my ($c) = @_;

    my $request_token = $consumer->get_request_token(
        callback_url => $callback_url,
        scope        => $scope,
    ) or die $consumer->errstr;

    $c->session->set(request_token => $request_token->as_encoded);
    $c->redirect($consumer->url_to_authorize(token => $request_token));
};

get '/token' => sub {
    my ($c) = @_;

    my $verifier      = $c->req->param('oauth_verifier');
    my $request_token = OAuth::Lite::Token->from_encoded($c->session->get('request_token'));

    my $access_token = $consumer->get_access_token(
        token    => $request_token,
        verifier => $verifier,
    ) or die $consumer->errstr;

    $c->session->expire;

    return $c->render('token.tx', {
        app_name    => $app_name,
        token        => $access_token->token,
        token_secret => $access_token->secret
    });
};

1;
