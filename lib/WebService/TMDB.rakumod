=begin pod

=head1 NAME

WebService::TMDB - a module for accessing L<The Movie Database|https://themoviedb.org> data.

=head1 SYNOPSIS

=begin code :lang<perl6>

use WebService::TMDB;

my $search = $tmdb.search_movie: query => 'legend of 1900';
say $search.results[0].title;

my $movie = $tmdb.movie: 10775, :append(['credits']);
say $movie.title;
say $movie.credits.cast[0].name;

=end code

=head1 INSTALLATION

You need to have L<Raku|https://raku.org/> and L<zef|https://github.com/ugexe/zef>, then run:

=begin code

zef install WebService::TMDB

=end code

or if you have cloned the repo:

=begin code

zef install .

=end code

=head1 TESTING

=begin code

prove -ve 'raku -Ilib' --ext rakutest

=end code

=head1 DESCRIPTION

WebService::TMDB is a module for interfacing with the L<TMDB API|https://developers.themoviedb.org/3/>.
An access token is required to use the API.

=head1 ATTRIBUTES/METHODS

=end pod

use v6.c;

use WebService::TMDB::Role::Request;
use WebService::TMDB::Request;
use WebService::TMDB::Movie;
use WebService::TMDB::Movie::Search;
use WebService::TMDB::Movie::Upcoming;
use WebService::TMDB::TV;
use WebService::TMDB::TV::Search;
use WebService::TMDB::Person;
use WebService::TMDB::Person::Search;
use WebService::TMDB::Genre::List;
use WebService::TMDB::Configuration;
use WebService::TMDB::CertificationList;

use JSON::Unmarshal;

unit class WebService::TMDB;

#| Access token required by themoviedb.org
has Str $.access_token is required;

#| An object for making requests to themoviedb.org
has WebService::TMDB::Role::Request $.request handles<language set_language> = WebService::TMDB::Request.new: :$!access_token;

#| Get a specific movie by its ID.
#| Credits and external IDs can be appended to response.
method movie (Int $id, :@append where .all ~~ Str --> WebService::TMDB::Movie) {
    unmarshal $!request.get("movie/$id", @append), WebService::TMDB::Movie;
}

#| Get credits for a movie
method movie_credits (Int $id --> WebService::TMDB::Credits) {
    unmarshal $!request.get("movie/$id/credits"), WebService::TMDB::Credits;
}

#| Get external IDs for a movie
method movie_external_ids (Int $id --> WebService::TMDB::ExternalID) {
    unmarshal $!request.get("movie/$id/external_ids"), WebService::TMDB::ExternalID;
}

#| Get upcoming movies
method movie_upcoming (*%params --> WebService::TMDB::Movie::Upcoming) {
    unmarshal $!request.get("movie/upcoming", :%params), WebService::TMDB::Movie::Upcoming;
}

#| Get movies that are in theatres
method movie_now_playing (*%params --> WebService::TMDB::Movie::Upcoming) {
    unmarshal $!request.get("movie/now_playing", :%params), WebService::TMDB::Movie::Upcoming;
}

#| Search for movies
method search_movie (*%params --> WebService::TMDB::Movie::Search) {
    unmarshal $!request.get("search/movie", :%params), WebService::TMDB::Movie::Search;
}

#| Discover movies
method discover_movie (*%params --> WebService::TMDB::Movie::Search) {
    unmarshal $!request.get("discover/movie", :%params), WebService::TMDB::Movie::Search;
}

#| Get a TV show by its ID.
#| Credits and external IDs can be appended to response.
method tv (Int $id, :@append where .all ~~ Str --> WebService::TMDB::TV) {
    my $tv = unmarshal $!request.get("tv/$id", @append), WebService::TMDB::TV;
    $tv.set_request: $!request;
    $tv;
}

#| Get a TV season.
#| Credits can be appended to response.
method season (Int :$tv, Int :$season, :@append where .all ~~ Str --> WebService::TMDB::TV::Season) {
    my $season_ = unmarshal $!request.get("tv/$tv/season/$season", @append), WebService::TMDB::TV::Season;
    $season_.tv_id = $tv;
    $season_;
}

#| Get a TV episode.
#| Credits can be appended to response.
method episode (Int :$tv, Int :$season, Int :$episode, :@append where .all ~~ Str --> WebService::TMDB::TV::Episode) {
    unmarshal $!request.get("tv/$tv/season/$season/episode/$episode", @append), WebService::TMDB::TV::Episode;
}

#| Get TV shows that are airing today
method tv_airing_today (*%params --> WebService::TMDB::TV::Search) {
    unmarshal $!request.get("tv/airing_today", :%params), WebService::TMDB::TV::Search;
}

#| Get TV shows that are currently on the air
method tv_on_the_air (*%params --> WebService::TMDB::TV::Search) {
    unmarshal $!request.get("tv/on_the_air", :%params), WebService::TMDB::TV::Search;
}

#| Search TV shows
method search_tv (*%params --> WebService::TMDB::TV::Search) {
    unmarshal $!request.get("search/tv", :%params), WebService::TMDB::TV::Search;
}

#| Discover TV shows
method discover_tv (*%params --> WebService::TMDB::TV::Search) {
    unmarshal $!request.get("discover/tv", :%params), WebService::TMDB::TV::Search;
}

#| Get a person by its ID.
#| Movie & TV credits and external IDs can be appended to response.
method person (Int $id, :@append where .all ~~ Str --> WebService::TMDB::Person) {
    unmarshal $!request.get("person/$id", @append), WebService::TMDB::Person;
}

#| Get a person's movie credits
method person_movie_credits (Int $id --> WebService::TMDB::Person::MovieCredits) {
    unmarshal $!request.get("person/$id/movie_credits"), WebService::TMDB::Person::MovieCredits;
}

#| Get a person's TV credits
method person_tv_credits (Int $id --> WebService::TMDB::Person::TVCredits) {
    unmarshal $!request.get("person/$id/tv_credits"), WebService::TMDB::Person::TVCredits;
}

#| Get a person's external IDs
method person_external_ids (Int $id --> WebService::TMDB::ExternalID) {
    unmarshal $!request.get("person/$id/external_ids"), WebService::TMDB::ExternalID;
}

#| Search people
method search_person (*%params --> WebService::TMDB::Person::Search) {
    unmarshal $!request.get("search/person", :%params), WebService::TMDB::Person::Search;
}

#| Get genre list for movies
method genre_movie_list (--> WebService::TMDB::Genre::List) {
    unmarshal $!request.get("genre/movie/list"), WebService::TMDB::Genre::List;
}

#| Get genre list for TV shows
method genre_tv_list (--> WebService::TMDB::Genre::List) {
    unmarshal $!request.get("genre/tv/list"), WebService::TMDB::Genre::List;
}

#| Get certification list for movies
method certification_movie_list (--> WebService::TMDB::CertificationList) {
    unmarshal $!request.get("certification/movie/list"), WebService::TMDB::CertificationList;
}

#| Get certification list for TV shows
method certification_tv_list (--> WebService::TMDB::CertificationList) {
    unmarshal $!request.get("certification/tv/list"), WebService::TMDB::CertificationList;
}

#| Get themoviedb.org configuration.
#| themoviedb.org recommends caching this data and checking for updates every few days.
method configuration (--> WebService::TMDB::Configuration) {
    unmarshal $!request.get("configuration"), WebService::TMDB::Configuration;
}

=begin pod

=head1 ERRORS

C<HTTP::UserAgent> module is used with exception throwing enabled.
So exceptions will be thrown in case of non-existent resources, out of range values, etc.
See L<http://modules.perl6.org/dist/HTTP::UserAgent>.

When an exception of type C<X::HTTP::Response> is caught, and the response received from themoviedb.org
contains an error message, an attribute named C<tmdb_status_message> or C<tmdb_errors> will be added
to the exception containing that error message.

=head1 ENVIRONMENT

Some live tests will run when C<NETWORK_TESTING> environment variable is set.

=head1 REPOSITORY

L<https://github.com/CIAvash/WebService-TMDB>

=head1 BUGS

L<https://github.com/CIAvash/WebService-TMDB/issues>

=head1 AUTHOR

Siavash Askari Nasr L<https://ciavash.name>

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
