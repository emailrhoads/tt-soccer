# frozen_string_literal: true

module Enum
  # This is a shared enumeration for several models
  class Country < ApplicationRecord # rubocop:disable Metrics/ClassLength
    self.abstract_class = true

    # FIXME: Migrate to Postgres and use types for these
    # created by CS.countries.map { |short, long| long }
    VALUES = [
      'Andorra',
      'United Arab Emirates',
      'Afghanistan',
      'Antigua and Barbuda',
      'Anguilla',
      'Albania',
      'Armenia',
      'Angola',
      'Antarctica',
      'Argentina',
      'American Samoa',
      'Austria',
      'Australia',
      'Aruba',
      'Åland',
      'Azerbaijan',
      'Bosnia and Herzegovina',
      'Barbados',
      'Bangladesh',
      'Belgium',
      'Burkina Faso',
      'Bulgaria',
      'Bahrain',
      'Burundi',
      'Benin',
      'Saint-Barthélemy',
      'Bermuda',
      'Brunei',
      'Bolivia',
      'Bonaire',
      'Brazil',
      'Bahamas',
      'Bhutan',
      'Botswana',
      'Belarus',
      'Belize',
      'Canada',
      'Cocos [Keeling] Islands',
      'Congo',
      'Central African Republic',
      'Republic of the Congo',
      'Switzerland',
      'Ivory Coast',
      'Cook Islands',
      'Chile',
      'Cameroon',
      'China',
      'Colombia',
      'country_name',
      'Costa Rica',
      'Cuba',
      'Cape Verde',
      'Curaçao',
      'Christmas Island',
      'Cyprus',
      'Czech Republic',
      'Germany',
      'Djibouti',
      'Denmark',
      'Dominica',
      'Dominican Republic',
      'Algeria',
      'Ecuador',
      'Estonia',
      'Egypt',
      'Eritrea',
      'Spain',
      'Ethiopia',
      'Finland',
      'Fiji',
      'Falkland Islands',
      'Federated States of Micronesia',
      'Faroe Islands',
      'France',
      'Gabon',
      'United Kingdom',
      'Grenada',
      'Georgia',
      'French Guiana',
      'Guernsey',
      'Ghana',
      'Gibraltar',
      'Greenland',
      'Gambia',
      'Guinea',
      'Guadeloupe',
      'Equatorial Guinea',
      'Greece',
      'South Georgia and the South Sandwich Islands',
      'Guatemala',
      'Guam',
      'Guinea-Bissau',
      'Guyana',
      'Hong Kong',
      'Honduras',
      'Croatia',
      'Haiti',
      'Hungary',
      'Indonesia',
      'Ireland',
      'Israel',
      'Isle of Man',
      'India',
      'British Indian Ocean Territory',
      'Iraq',
      'Iran',
      'Iceland',
      'Italy',
      'Jersey',
      'Jamaica',
      'Hashemite Kingdom of Jordan',
      'Japan',
      'Kenya',
      'Kyrgyzstan',
      'Cambodia',
      'Kiribati',
      'Comoros',
      'Saint Kitts and Nevis',
      'North Korea',
      'Republic of Korea',
      'Kuwait',
      'Cayman Islands',
      'Kazakhstan',
      'Laos',
      'Lebanon',
      'Saint Lucia',
      'Liechtenstein',
      'Sri Lanka',
      'Liberia',
      'Lesotho',
      'Republic of Lithuania',
      'Luxembourg',
      'Latvia',
      'Libya',
      'Morocco',
      'Monaco',
      'Republic of Moldova',
      'Montenegro',
      'Saint Martin',
      'Madagascar',
      'Marshall Islands',
      'Macedonia',
      'Mali',
      'Myanmar [Burma]',
      'Mongolia',
      'Macao',
      'Northern Mariana Islands',
      'Martinique',
      'Mauritania',
      'Montserrat',
      'Malta',
      'Mauritius',
      'Maldives',
      'Malawi',
      'Mexico',
      'Malaysia',
      'Mozambique',
      'Namibia',
      'New Caledonia',
      'Niger',
      'Norfolk Island',
      'Nigeria',
      'Nicaragua',
      'Netherlands',
      'Norway',
      'Nepal',
      'Nauru',
      'Niue',
      'New Zealand',
      'Oman',
      'Panama',
      'Peru',
      'French Polynesia',
      'Papua New Guinea',
      'Philippines',
      'Pakistan',
      'Poland',
      'Saint Pierre and Miquelon',
      'Pitcairn Islands',
      'Puerto Rico',
      'Palestine',
      'Portugal',
      'Palau',
      'Paraguay',
      'Qatar',
      'Réunion',
      'Romania',
      'Serbia',
      'Russia',
      'Rwanda',
      'Saudi Arabia',
      'Solomon Islands',
      'Seychelles',
      'Sudan',
      'Sweden',
      'Singapore',
      'Saint Helena',
      'Slovenia',
      'Svalbard and Jan Mayen',
      'Slovakia',
      'Sierra Leone',
      'San Marino',
      'Senegal',
      'Somalia',
      'Suriname',
      'South Sudan',
      'São Tomé and Príncipe',
      'El Salvador',
      'Sint Maarten',
      'Syria',
      'Swaziland',
      'Turks and Caicos Islands',
      'Chad',
      'French Southern Territories',
      'Togo',
      'Thailand',
      'Tajikistan',
      'Tokelau',
      'East Timor',
      'Turkmenistan',
      'Tunisia',
      'Tonga',
      'Turkey',
      'Trinidad and Tobago',
      'Tuvalu',
      'Taiwan',
      'Tanzania',
      'Ukraine',
      'Uganda',
      'U.S. Minor Outlying Islands',
      'United States',
      'Uruguay',
      'Uzbekistan',
      'Vatican City',
      'Saint Vincent and the Grenadines',
      'Venezuela',
      'British Virgin Islands',
      'U.S. Virgin Islands',
      'Vietnam',
      'Vanuatu',
      'Wallis and Futuna',
      'Samoa',
      'Kosovo',
      'Yemen',
      'Mayotte',
      'South Africa',
      'Zambia',
      'Zimbabwe'
    ].freeze
  end
end
