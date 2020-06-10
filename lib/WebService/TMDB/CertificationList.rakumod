unit class WebService::TMDB::CertificationList;

class Certification {
    has Str $.certification;
    has Str $.meaning;
    has Int $.order;
}

class Certifications {
    has Certification @.US;
    has Certification @.CA;
    has Certification @.DE;
    has Certification @.GB;
    has Certification @.AU;
    has Certification @.BR;
    has Certification @.FR;
    has Certification @.NZ;
    has Certification @.IN;
    has Certification @.NL;
    has Certification @.BG;
    has Certification @.ES;
    has Certification @.PT;
    has Certification @.MY;
    has Certification @.CA-QC;
    has Certification @.SE;
    has Certification @.DK;
    has Certification @.NO;
    has Certification @.HU;
    has Certification @.LT;
    has Certification @.RU;
    has Certification @.PH;
    has Certification @.IT;

    # TV Certifications
    has Certification @.TH;
    has Certification @.KR;
    has Certification @.SK;
}

has Certifications $.certifications;

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