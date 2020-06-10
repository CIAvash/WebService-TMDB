=begin pod

=head1 NAME

WebService::TMDB::Request - Class for making HTTP requests on themoviedb.org

=head1 SYNOPSIS

=begin code

use WebService::TMDB::Request;

my $request = WebService::TMDB::Request.new(
    access_token => '12345',
    base_url => 'https://api.themoviedb.org/3/'
    language => 'en-US'
);

my $movie = $request.get: 'movie/550';

=end code

=head1 DESCRIPTION

Class that makes it easy to do HTTP requests on themoviedb.org.

=head1 ATTRIBUTES/METHODS

=end pod

use WebService::TMDB::Facade::UserAgent;
use WebService::TMDB::Role::UserAgent;
use WebService::TMDB::Role::Request;
use URI::Escape;

unit class WebService::TMDB::Request does WebService::TMDB::Role::Request;

#| Access token provided by themoviedb.org
has Str:D $.access_token is required;
#| Base URL used for making HTTP requests
has Str:D $.base_url = 'https://api.themoviedb.org/3/';
#| Language used by the TMDB API
has Str:D $.language = 'en-US';

#| Useragent for making HTTP requests
has WebService::TMDB::Role::UserAgent $.ua = WebService::TMDB::Facade::UserAgent.new;

#| Makes HTTP requests to TMDB API and returns the result
method get (Str:D $url is copy, @append_to_response? where .all ~~ Str, :%params is copy --> Str) {
    # Prepend the base url if url is not absolute
    $url = $!base_url ~ uri-escape($url) unless $url ~~ /^https? '://'/;

    %params.append: 'language', $!language;

    if @append_to_response {
        %params.append: 'append_to_response', @append_to_response.join: ',';
    }

    if %params {
        # Encode and join parameters and then append them to url
        $url ~= '?' ~ %params.kv.map(&uri-escape).hash.sort.map(*.kv.join: '=').join: '&';
    }

    # Set header fields
    my %headers = :Authorization("Bearer $!access_token");

    $!ua.get: $url, |%headers;
}

#| Sets the language TMDB API uses
method set_language (Str:D $language) {
    $!language = $language;
}

=begin pod

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Siavash Askari Nasr

This file is part of WebService::TMDB.

WebService::TMDB is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

WebService::TMDB is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with WebService::TMDB.  If not, see <http://www.gnu.org/licenses/>.

=end pod