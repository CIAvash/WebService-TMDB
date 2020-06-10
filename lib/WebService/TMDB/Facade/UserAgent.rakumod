=begin pod

=head1 NAME

WebService::TMDB::Facade::UserAgent - A user agent facade

=head1 SYNOPSIS

=begin code

use WebService::TMDB::Facade::UserAgent;

my $ua = WebService::TMDB::Facade::UserAgent.new;

my $movie_json = $ua.get: 'https://api.themoviedb.org/3/movie/550', :Authorization<Bearer 1234>;

=end code

=head1 DESCRIPTION

A user agent facade.

=head1 METHODS

=end pod

use HTTP::UserAgent;

use WebService::TMDB::Role::UserAgent;

unit class WebService::TMDB::Facade::UserAgent;

also does WebService::TMDB::Role::UserAgent;

has $!ua = HTTP::UserAgent.new: :throw-exceptions;

#| Makes HTTP requests
method get (Str $url, *%headers) returns Str {
    my $response = $!ua.get: $url, |%headers;

    CATCH {
        # Add tmdb_status_message and tmdb_error attributes to the exception and rethrow it
        when X::HTTP::Response {
            my Str $status_message;
            my Str $errors;

            if .response.content -> $content {
                require JSON::Fast <&from-json>;
                my $data = from-json($content);
                $status_message = $data<status_message> if $data<status_message>:exists;
                $errors = $data<errors> if $data<errors>:exists;
            }

            my $exception = $_ but role {
                has Str $.tmdb_status_message = $status_message;
                has Str $.tmdb_errors = $errors;
            };
            $exception.rethrow;
        }
    }

    if $response.is-success {
        $response.content;
    } else {
        die $response.status-line;
    }
}

=begin pod

=head1 ERRORS

C<HTTP::UserAgent> module is used with exception throwing enabled.
So exceptions will be thrown in case of non-existent resources, out of range values, etc.
See L<http://modules.perl6.org/dist/HTTP::UserAgent>.

When an exception of type C<X::HTTP::Response> is caught, and the response received from themoviedb.org
contains an error message, an attribute named C<tmdb_status_message> or C<tmdb_errors> will be added
to the exception containing that error message.

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