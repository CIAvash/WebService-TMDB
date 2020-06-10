use WebService::TMDB::Utility;

use JSON::Unmarshal;

unit class WebService::TMDB::Person::TVCast;

has Str $.credit_id;
has Str $.original_name;
has Int $.id;
has Int @.genre_ids;
has Str $.character;
has Str $.name;
has Str $.poster_path;
has Int $.vote_count;
has Rat $.vote_average;
has Rat $.popularity;
has Int $.episode_count;
has Str $.original_language;
has Date $.first_air_date is unmarshalled-by(&make_date);
has Str $.backdrop_path;
has Str $.overview;
has Str @.origin_country;

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