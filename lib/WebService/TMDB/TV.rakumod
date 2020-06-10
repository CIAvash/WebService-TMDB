use WebService::TMDB::Crew;
use WebService::TMDB::Genre;
use WebService::TMDB::TV::Episode;
use WebService::TMDB::TV::Season;
use WebService::TMDB::Company;
use WebService::TMDB::Role::HasRequest;
use WebService::TMDB::Utility;

use JSON::Unmarshal;

unit class WebService::TMDB::TV;

also does WebService::TMDB::Role::HasRequest;

has Str $.backdrop_path;
has WebService::TMDB::Crew @.created_by;
has Int @.episode_run_time;
has Date $.first_air_date is unmarshalled-by(&make_date);
has WebService::TMDB::Genre @.genres;
has Str $.homepage;
has Int $.id;
has Bool $.in_production;
has Str @.languages;
has Date $.last_air_date is unmarshalled-by(&make_date);
has WebService::TMDB::TV::Episode $.last_episode_to_air;
has Str $.name;
has WebService::TMDB::TV::Episode $.next_episode_to_air;
has WebService::TMDB::Company @.networks;
has Int $.number_of_episodes;
has Int $.number_of_seasons;
has Str @.origin_country;
has Str $.original_language;
has Str $.original_name;
has Str $.overview;
has Rat $.popularity;
has Str $.poster_path;
has WebService::TMDB::Company @.production_companies;
has WebService::TMDB::TV::Season @.seasons;
has Str $.status;
has Str $.type;
has Rat $.vote_average;
has Int $.vote_count;
has WebService::TMDB::Credits $.credits;

#| Get season
method season (Int $number, :@append where .all ~~ Str --> WebService::TMDB::TV::Season) {
    my $season = unmarshal $!request.get("tv/$!id/season/$number", @append), WebService::TMDB::TV::Season;
    $season.set_request: $!request;
    $season.tv_id = $!id;
    $season;
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