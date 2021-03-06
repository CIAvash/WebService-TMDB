use WebService::TMDB::Movie::Search;
use WebService::TMDB::Utility;

use JSON::Unmarshal;

unit class WebService::TMDB::Movie::Upcoming is WebService::TMDB::Movie::Search;

class DateRange {
    has Date $.maximum is unmarshalled-by(&make_date);
    has Date $.minimum is unmarshalled-by(&make_date);
}
has DateRange $.dates;

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