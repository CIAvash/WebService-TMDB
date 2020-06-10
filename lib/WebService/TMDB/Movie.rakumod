use WebService::TMDB::Genre;
use WebService::TMDB::Company;
use WebService::TMDB::Country;
use WebService::TMDB::SpokenLanguage;
use WebService::TMDB::Credits;
use WebService::TMDB::ExternalID;
use WebService::TMDB::Utility;

use JSON::Unmarshal;

unit class WebService::TMDB::Movie;

has Bool $.adult;
has Str $.backdrop_path;
has Int $.budget;
has WebService::TMDB::Genre @.genres;
has Str $.homepage;
has Int $.id;
has Str $.imdb_id;
has Str $.original_language;
has Str $.original_title;
has Str $.overview;
has Rat $.popularity;
has Str $.poster_path;
has WebService::TMDB::Company @.production_companies;
has WebService::TMDB::Country @.production_countries;
has Date $.release_date is unmarshalled-by(&make_date);
has Int $.revenue;
has Int $.runtime;
has WebService::TMDB::SpokenLanguage @.spoken_languages;
has Str $.status;
has Str $.tagline;
has Str $.title;
has Bool $.video;
has Rat $.vote_average;
has Int $.vote_count;
has WebService::TMDB::Credits $.credits;
has WebService::TMDB::ExternalID $.external_ids;

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