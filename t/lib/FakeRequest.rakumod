use WebService::TMDB::Role::Request;

unit class FakeRequest does WebService::TMDB::Role::Request;

has IO::Path $!data_dir = $?FILE.IO.parent.add: 'data';

method get (Str $url is copy, @append_to_response?, :%params is copy) {
    if @append_to_response {
        %params.append: 'append_to_response', @append_to_response.join: ',';
    }
    
    $url ~= "-{.key}({.value})" for %params.sort;

    self!file_content($url);
}

method !file_content (Str $file_name) {
    my $path = $!data_dir.add: "$file_name.json";
    $path = $!data_dir.add: 'error.json' unless $path.f;
    $path.slurp;
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