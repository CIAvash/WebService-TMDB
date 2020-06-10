use WebService::TMDB::Crew;
use WebService::TMDB::Cast;
use WebService::TMDB::Credits;
use WebService::TMDB::Utility;

use JSON::Unmarshal;

unit class WebService::TMDB::TV::Episode;

has Date $.air_date is unmarshalled-by(&make_date);
has WebService::TMDB::Crew @.crew;
has Int $.episode_number;
has WebService::TMDB::Cast @.guest_stars;
has Str $.name;
has Str $.overview;
has Int $.id;
has Int $.show_id;
has Str $.production_code;
has Int $.season_number;
has Str $.still_path;
has Rat $.vote_average;
has Int $.vote_count;
has WebService::TMDB::Credits $.credits;

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