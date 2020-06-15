NAME
====

WebService::TMDB - a module for accessing [The Movie Database](https://themoviedb.org) data.

SYNOPSIS
========

```perl6
use WebService::TMDB;

my $search = $tmdb.search_movie: query => 'legend of 1900';
say $search.results[0].title;

my $movie = $tmdb.movie: 10775, :append(['credits']);
say $movie.title;
say $movie.credits.cast[0].name;
```

INSTALLATION
============

You need to have [Raku](https://raku.org/) and [zef](https://github.com/ugexe/zef), then run:

    zef install WebService::TMDB

or if you have cloned the repo:

    zef install .

TESTING
=======

    prove -ve 'raku -Ilib' --ext rakutest

DESCRIPTION
===========

WebService::TMDB is a module for interfacing with the [TMDB API](https://developers.themoviedb.org/3/). An access token is required to use the API.

ATTRIBUTES/METHODS
==================

### has Str $.access_token

Access token required by themoviedb.org

### has WebService::TMDB::Role::Request $.request handles('language', 'set_language')

An object for making requests to themoviedb.org

### method movie

```perl6
method movie(
    Int $id,
    :@append where { ... }
) returns WebService::TMDB::Movie
```

Get a specific movie by its ID. Credits and external IDs can be appended to response.

### method movie_credits

```perl6
method movie_credits(
    Int $id
) returns WebService::TMDB::Credits
```

Get credits for a movie

### method movie_external_ids

```perl6
method movie_external_ids(
    Int $id
) returns WebService::TMDB::ExternalID
```

Get external IDs for a movie

### method movie_upcoming

```perl6
method movie_upcoming(
    *%params
) returns WebService::TMDB::Movie::Upcoming
```

Get upcoming movies

### method movie_now_playing

```perl6
method movie_now_playing(
    *%params
) returns WebService::TMDB::Movie::Upcoming
```

Get movies that are in theatres

### method search_movie

```perl6
method search_movie(
    *%params
) returns WebService::TMDB::Movie::Search
```

Search for movies

### method discover_movie

```perl6
method discover_movie(
    *%params
) returns WebService::TMDB::Movie::Search
```

Discover movies

### method tv

```perl6
method tv(
    Int $id,
    :@append where { ... }
) returns WebService::TMDB::TV
```

Get a TV show by its ID. Credits and external IDs can be appended to response.

### method season

```perl6
method season(
    Int :$tv,
    Int :$season,
    :@append where { ... }
) returns WebService::TMDB::TV::Season
```

Get a TV season. Credits can be appended to response.

### method episode

```perl6
method episode(
    Int :$tv,
    Int :$season,
    Int :$episode,
    :@append where { ... }
) returns WebService::TMDB::TV::Episode
```

Get a TV episode. Credits can be appended to response.

### method tv_airing_today

```perl6
method tv_airing_today(
    *%params
) returns WebService::TMDB::TV::Search
```

Get TV shows that are airing today

### method tv_on_the_air

```perl6
method tv_on_the_air(
    *%params
) returns WebService::TMDB::TV::Search
```

Get TV shows that are currently on the air

### method search_tv

```perl6
method search_tv(
    *%params
) returns WebService::TMDB::TV::Search
```

Search TV shows

### method discover_tv

```perl6
method discover_tv(
    *%params
) returns WebService::TMDB::TV::Search
```

Discover TV shows

### method person

```perl6
method person(
    Int $id,
    :@append where { ... }
) returns WebService::TMDB::Person
```

Get a person by its ID. Movie & TV credits and external IDs can be appended to response.

### method person_movie_credits

```perl6
method person_movie_credits(
    Int $id
) returns WebService::TMDB::Person::MovieCredits
```

Get a person's movie credits

### method person_tv_credits

```perl6
method person_tv_credits(
    Int $id
) returns WebService::TMDB::Person::TVCredits
```

Get a person's TV credits

### method person_external_ids

```perl6
method person_external_ids(
    Int $id
) returns WebService::TMDB::ExternalID
```

Get a person's external IDs

### method search_person

```perl6
method search_person(
    *%params
) returns WebService::TMDB::Person::Search
```

Search people

### method genre_movie_list

```perl6
method genre_movie_list() returns WebService::TMDB::Genre::List
```

Get genre list for movies

### method genre_tv_list

```perl6
method genre_tv_list() returns WebService::TMDB::Genre::List
```

Get genre list for TV shows

### method certification_movie_list

```perl6
method certification_movie_list() returns WebService::TMDB::CertificationList
```

Get certification list for movies

### method certification_tv_list

```perl6
method certification_tv_list() returns WebService::TMDB::CertificationList
```

Get certification list for TV shows

### method configuration

```perl6
method configuration() returns WebService::TMDB::Configuration
```

Get themoviedb.org configuration. themoviedb.org recommends caching this data and checking for updates every few days.

ERRORS
======

`HTTP::UserAgent` module is used with exception throwing enabled. So exceptions will be thrown in case of non-existent resources, out of range values, etc. See [http://modules.perl6.org/dist/HTTP::UserAgent](http://modules.perl6.org/dist/HTTP::UserAgent).

When an exception of type `X::HTTP::Response` is caught, and the response received from themoviedb.org contains an error message, an attribute named `tmdb_status_message` or `tmdb_errors` will be added to the exception containing that error message.

ENVIRONMENT
===========

Some live tests will run when `NETWORK_TESTING` environment variable is set.

REPOSITORY
==========

[https://github.com/CIAvash/WebService-TMDB](https://github.com/CIAvash/WebService-TMDB)

BUGS
====

[https://github.com/CIAvash/WebService-TMDB/issues](https://github.com/CIAvash/WebService-TMDB/issues)

AUTHOR
======

Siavash Askari Nasr - https://ciavash.name

COPYRIGHT AND LICENSE
=====================

Copyright © 2020 Siavash Askari Nasr

This file is part of WebService::TMDB.

WebService::TMDB is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

WebService::TMDB is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with WebService::TMDB. If not, see <http://www.gnu.org/licenses/>.

