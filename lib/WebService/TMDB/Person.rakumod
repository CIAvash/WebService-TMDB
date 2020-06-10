use WebService::TMDB::Person::MovieCredits;
use WebService::TMDB::Person::TVCredits;
use WebService::TMDB::ExternalID;
use WebService::TMDB::Utility;

use JSON::Unmarshal;

unit class WebService::TMDB::Person;

has Date $.birthday is unmarshalled-by(&make_date);
has Str $.known_for_department;
has Date $.deathday is unmarshalled-by(&make_date);
has Int $.id;
has Str $.name;
has Str @.also_known_as;
has Int $.gender;
has Str $.biography;
has Rat $.popularity;
has Str $.place_of_birth;
has Str $.profile_path;
has Bool $.adult;
has Str $.imdb_id;
has Str $.homepage;

has WebService::TMDB::Person::MovieCredits $.movie_credits;
has WebService::TMDB::Person::TVCredits $.tv_credits;
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