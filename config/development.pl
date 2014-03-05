use strict;
use warnings;
use utf8;

return +{
    app_name    => '__YOUR_APP_NAME__',
    description => '__YOUR_APP_DESCRIPTION__',

    consumer_key    => '__YOUR_APP_CONSUMER_KEY__',
    consumer_secret => '__YOUR_APP_CONSUMER_SECRET__',

    site               => 'http://oauth_provider.com',
    request_token_path => '/request_token',
    access_token_path  => '/access_token',
    authorize_path     => '/authorize',

    scope => [qw/read write/],

    callback_url => 'http://YOUR_APP_URL.com/token',
};
