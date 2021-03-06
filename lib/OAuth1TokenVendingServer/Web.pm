package OAuth1TokenVendingServer::Web;
use strict;
use warnings;
use utf8;
use parent qw/OAuth1TokenVendingServer Amon2::Web/;
use File::Spec;

# dispatcher
use OAuth1TokenVendingServer::Web::Dispatcher;
sub dispatch {
    return (OAuth1TokenVendingServer::Web::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

sub res_406 {
    my ($c) = @_;
    return $c->create_simple_status_page(406, 'Not Acceptable');
}

# load plugins
__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::JSON',
    '+OAuth1TokenVendingServer::Web::Plugin::Session',
);

# setup view
use OAuth1TokenVendingServer::Web::View;
{
    sub create_view {
        my $view = OAuth1TokenVendingServer::Web::View->make_instance(__PACKAGE__);
        no warnings 'redefine';
        *OAuth1TokenVendingServer::Web::create_view = sub { $view }; # Class cache.
        $view
    }
}

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;

        # http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );

        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );

        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

1;
