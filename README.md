# OAuth1TokenVendingServer

Access token vending server for OAuth1

## Over View

1. Access & Authenticate

    ![https://dl.dropboxusercontent.com/u/14832699/OAuth1TokenVendingServer/top.png](https://dl.dropboxusercontent.com/u/14832699/OAuth1TokenVendingServer/top.png)

2. You've got an access token

    ![https://dl.dropboxusercontent.com/u/14832699/OAuth1TokenVendingServer/token.png](https://dl.dropboxusercontent.com/u/14832699/OAuth1TokenVendingServer/token.png)

## Getting Started

<ol>
<li>carton install</li>

<pre>
$ carton install
</pre>

<li>Edit `config/production.pl`</li>

<pre>
+{
    app_name    => '__YOUR_APP_NAME__',
    description => '__YOUR_APP_DESCRIPTION__',

    consumer_key    => '__YOUR_APP_CONSUMER_KEY__',
    consumer_secret => '__YOUR_APP_CONSUMER_SECRET__',

    site               => 'http://oauth_provider.com',
    request_token_path => '/request_token', # => in this case: `http://oauth_provider.com/request_token`
    access_token_path  => '/access_token',  # => in this case: `http://oauth_provider.com/access_token`
    authorize_path     => '/authorize',     # => in this case: `http://oauth_provider.com/authorize`

    scope => [qw/read write/],

    callback_url => 'http://YOUR_APP_URL.com/token',
};
</pre>

<li>Start server</li>

<pre>
$ carton exec -- plackup -E production script/oauth1tokenvendingserver-server
</pre>
</ol>

## See Also

[OAuth2TokenVendingServer](https://github.com/moznion/OAuth2TokenVendingServer)

## LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
