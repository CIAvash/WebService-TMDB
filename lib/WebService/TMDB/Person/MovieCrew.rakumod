use WebService::TMDB::Utility;

use JSON::Unmarshal;

unit class WebService::TMDB::Person::MovieCrew;

has Int $.id;
has Str $.department;
has Str $.original_language;
has Str $.original_title;
has Str $.job;
has Str $.overview;
has Int $.vote_count;
has Bool $.video;
has Str $.poster_path;
has Str $.backdrop_path;
has Str $.title;
has Rat $.popularity;
has Int @.genre_ids;
has Rat $.vote_average;
has Bool $.adult;
has Date $.release_date is unmarshalled-by(&make_date);
has Str $.credit_id;

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