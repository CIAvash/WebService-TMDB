use WebService::TMDB::TV::Episode;
use WebService::TMDB::Role::HasRequest;
use WebService::TMDB::Credits;
use WebService::TMDB::Utility;

use JSON::Unmarshal;

unit class WebService::TMDB::TV::Season;

also does WebService::TMDB::Role::HasRequest;

has Int $.tv_id is rw;

has Str $._id;
has Date $.air_date is unmarshalled-by(&make_date);
has WebService::TMDB::TV::Episode @.episodes;
has Str $.name;
has Str $.overview;
has Int $.id;
has Str $.poster_path;
has Int $.season_number;
has Int $.episode_count;
has WebService::TMDB::Credits $.credits;

#| Get episode. Should only be used with season method of TV
method episode (Int $number, :@append where .all ~~ Str --> WebService::TMDB::TV::Episode) {
    with $!tv_id {
        my $url = "tv/$_/season/$!season_number/episode/$number";
        unmarshal $!request.get($url, @append), WebService::TMDB::TV::Episode;
    }
    else { Nil }
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