import 'dart:math';

import 'random_address.dart';

/// class can generate random addresses with US style or german style
class RandomAddressGenerator {
  static final Random _random = Random();
  static final List<String> _firstNamesUs = [
    'James', 'John', 'Robert', 'Michael', 'William', 'David', 'Joseph',
    'Charles', 'Thomas', 'Daniel',
    'Matthew', 'Christopher', 'Andrew', 'Joshua', 'Anthony', 'Brian', 'Kevin',
    'Elizabeth', 'Mary', 'Jennifer',
    'Linda', 'Patricia', 'Susan', 'Margaret', 'Jessica', 'Sarah', 'Karen',
    'Nancy', 'Betty',
    'Dorothy', 'Lisa', 'Michelle', 'Ashley', 'Emily', 'Samantha', 'Hannah',
    'Sophia', 'Olivia', 'Emma',
    // Comment to keep the line breaks
  ];
  static final List<String> _firstNamesDe = [
    'Max', 'Paul', 'Felix', 'Moritz', 'Lukas', 'Leon', 'Julian', 'Elias',
    'Nicole', 'Heike', 'David', 'Benjamin', 'Sophie', 'Mia', 'Hannah',
    'Emma', 'Lena', 'Anna', 'Marie', 'Laura', 'Lea',
    'Julia', 'Michael', 'Markus', 'Thomas', 'Christian', 'Stefan', 'Andreas',
    'Martin',
    'Peter', 'Klaus', 'Monika', 'Sabine', 'Andrea', 'Petra', 'Birgit', 'Karin',
    'Susanne', 'Anja',
    // Comment to keep the line breaks
  ];
  static final List<String> _lastNamesUs = [
    'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Miller', 'Davis',
    'Garcia', 'Rodriguez', 'Martinez', 'Harris', 'Young', 'Lee', 'Allen',
    'King', 'Wright', 'Scott', 'Green',
    'Evans', 'Turner', 'Hoffmann', 'Müller', 'Schmidt', 'Schneider', 'Fischer',
    'Weber', 'Meyer',
    'Wagner', 'Becker', 'Schulz', 'Hofmann', 'Koch', 'Bauer', 'Richter',
    'Klein', 'Wolf',
    'Schröder', 'Neumann', 'Schwarz',
    // Comment to keep the line breaks
  ];
  static final List<String> _lastNamesDe = [
    'Schmidt', 'Schneider', 'Fischer', 'Weber', 'Meyer', 'Wagner', 'Becker',
    'Schulz', 'Hofmann', 'Koch',
    'Bauer', 'Richter', 'Klein', 'Wolf', 'Schröder', 'Neumann', 'Schwarz',
    'Zimmermann', 'Braun', 'Hoffmann',
    'Müller', 'Krüger', 'Hofmann', 'Lehmann', 'Schmitz', 'Krause', 'Roth',
    'Schmid', 'Werner',
    'Ludwig', 'Hartmann', 'Ziegler', 'Bergmann', 'Günther', 'Groß', 'Frank',
    'König', 'Lang', 'Voigt'
    // Comment to keep the line breaks
  ];
  static final List<String> _streetsUs = [
    'Main Street', 'First Street', 'Second Street', 'Third Street',
    'Fourth Street',
    'Fifth Street', 'Sixth Street', 'Seventh Street', 'Eighth Street',
    'Ninth Street',
    'Oak Street', 'Pine Street', 'Maple Street', 'Cedar Street', 'Elm Street',
    'Washington Street', 'Lincoln Street', 'Jefferson Street', 'Jackson Street',
    'Madison Street',
    'Broadway', 'Park Avenue', 'Park Street', 'High Street', 'Elmwood Avenue',
    'Central Avenue',
    'River Road', 'Market Street', 'Forest Avenue', 'Sunset Boulevard',
    'Maple Avenue',
    'Hill Street', 'Chestnut Street', 'Lake Street', 'Mill Street',
    'Valley Road',
    'Walnut Street', 'Bridge Street', 'Church Street', 'Spring Street',
    'Water Street',
    'Ridge Road', 'Prospect Avenue', 'Railroad Avenue', 'School Street',
    'Union Street', 'North Street',
    'South Street', 'West Street', 'East Street', 'Grove Street',
    'Broad Street', 'Smith Street',
    'Franklin Street', 'Columbia Avenue', 'Highland Avenue',
    'Westminster Avenue', 'Pleasant Street', 'Academy Street',
    'Madison Avenue', 'Main Avenue', 'Broadway Street', 'Fifth Avenue',
    'State Street', 'Cherry Street', 'Liberty Street',
    'Pennsylvania Avenue', 'Victoria Avenue', 'Lafayette Street',
    'Market Street', 'Franklin Avenue', 'Hillside Avenue',
    'Spruce Street', 'Cottage Street', 'Washington Avenue', 'Pearl Street',
    'Spruce Avenue', 'King Street', 'Clinton Street',
    'River Street', 'Bridge Road', 'Cedar Avenue', 'Locust Street',
    'Grant Street', 'Park Place', 'Adams Street', 'Cypress Street',
    'Sycamore Street', 'Ash Street', 'Cleveland Avenue', 'Harrison Street',
    'Monroe Street', 'Highland Street', 'Pleasant Avenue', 'Crescent Street',
    'Park Street', 'Mountain Avenue', 'Laurel Street', 'Cherry Lane',
    'Riverside Drive'
    // Comment to keep the line breaks
  ];

  static final List<String> _streetsDe = [
    'Hauptstraße', 'Bahnhofstraße', 'Berliner Straße', 'Lindenstraße',
    'Schulstraße',
    'Goethestraße', 'Friedrichstraße', 'Mühlweg', 'Am Markt', 'Kirchstraße',
    'Bergstraße', 'Gartenstraße', 'Schillerstraße', 'Hofstraße', 'Kirchplatz',
    'Feldstraße', 'Dorfstraße', 'Neue Straße', 'Poststraße', 'Marktplatz',
    'Eichenweg', 'Steinweg', 'Ringstraße', 'Parkstraße', 'Buchenweg',
    'Schulweg', 'Lerchenweg', 'Rosenstraße', 'Talstraße', 'Hofweg',
    'Schloßstraße', 'Birkenweg', 'Wiesenstraße', 'Rathausplatz', 'Kurze Straße',
    'Am Bahnhof', 'Fichtenweg',
    'Brückenstraße', 'Bismarckstraße', 'Löwenstraße', 'Bachstraße',
    'Heinrichstraße', 'Am Kirchberg', 'Waldweg', 'Hofgasse',
    'Tannenweg', 'Eschenweg', 'Schulberg', 'Königsstraße', 'Jahnstraße',
    'Ahornweg', 'Dammstraße', 'Schlossberg', 'Brunnenstraße', 'Steinberg',
    'Schulgasse', 'Rathausstraße', 'Buchenstraße', 'Feldweg', 'Kiefernweg',
    'Drosselweg', 'Weinbergstraße', 'Am Rosenhügel', 'Marktstraße',
    'Birkenstraße', 'Dorfplatz',
    'Mittelweg', 'Erlenweg', 'Bergweg', 'Wiesenweg',
    'Föhrenweg', 'Postweg', 'Berggasse', 'Hirschweg', 'Kastanienallee',
    'Bismarckplatz', 'Römerstraße', 'Bachgasse', 'Goetheplatz', 'Amselweg',
    'Schulplatz', 'Lindenweg', 'Eichendorffstraße', 'Kurze Gasse', 'Sonnenweg',
    'Waldstraße', 'Schulstraße', 'Hauptplatz', 'Mozartstraße', 'Ulmenweg',
    'Kurze Straße', 'Lindenplatz', 'Mühlstraße', 'Parkweg', 'Seestraße',
    'Kirchgasse', 'Rosenweg', 'Im Winkel', 'Dorfstraße', 'Drosselweg'
    // Comment to keep the line breaks
  ];
  static final List<String> _citiesUs = [
    'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia',
    'San Antonio', 'San Diego', 'Dallas', 'San Jose',
    'Austin', 'Jacksonville', 'Fort Worth', 'Columbus', 'Charlotte',
    'San Francisco', 'Indianapolis', 'Seattle', 'Denver', 'Washington',
    'Boston', 'El Paso', 'Nashville', 'Detroit', 'Oklahoma City', 'Portland',
    'Las Vegas', 'Memphis', 'Louisville', 'Baltimore',
    'Milwaukee', 'Albuquerque', 'Tucson', 'Fresno', 'Sacramento', 'Mesa',
    'Atlanta', 'Kansas City', 'Colorado Springs', 'Miami', 'Raleigh',
    'Omaha', 'Long Beach', 'Virginia Beach', 'Oakland', 'Minneapolis', 'Tampa',
    'Arlington', 'New Orleans', 'Wichita', 'Cleveland',
    'Bakersfield', 'Tampa', 'Aurora', 'Honolulu', 'Anaheim', 'Santa Ana',
    'Corpus Christi', 'Riverside', 'St. Louis', 'Lexington',
    'Stockton', 'Pittsburgh', 'Saint Paul', 'Anchorage', 'Cincinnati',
    'Henderson', 'Greensboro', 'Plano', 'Newark', 'Toledo',
    'Lincoln', 'Orlando', 'Chula Vista', 'Jersey City', 'Chandler',
    'Fort Wayne', 'Buffalo', 'Durham', 'St. Petersburg', 'Irvine',
    'Laredo', 'Lubbock', 'Madison', 'Gilbert', 'Norfolk', 'Reno',
    'Winston-Salem', 'Glendale', 'Hialeah', 'Garland', 'Scottsdale',
    // Comment to keep the line breaks
  ];

  static final List<String> _citiesDe = [
    'Berlin', 'Hamburg', 'München', 'Köln', 'Frankfurt am Main', 'Stuttgart',
    'Düsseldorf', 'Dortmund', 'Essen', 'Leipzig',
    'Bremen', 'Dresden', 'Hannover', 'Nürnberg', 'Duisburg', 'Bochum',
    'Wuppertal', 'Bielefeld', 'Bonn', 'Münster',
    'Karlsruhe', 'Mannheim', 'Augsburg', 'Wiesbaden', 'Gelsenkirchen',
    'Mönchengladbach', 'Braunschweig', 'Chemnitz', 'Kiel', 'Aachen',
    'Halle (Saale)', 'Magdeburg', 'Freiburg im Breisgau', 'Krefeld', 'Lübeck',
    'Oberhausen', 'Erfurt', 'Mainz', 'Rostock', 'Kassel',
    'Hagen', 'Saarbrücken', 'Hamm', 'Mülheim an der Ruhr',
    'Ludwigshafen am Rhein', 'Potsdam', 'Leverkusen', 'Oldenburg', 'Osnabrück',
    'Solingen', 'Heidelberg', 'Herne', 'Neuss', 'Darmstadt', 'Paderborn',
    'Regensburg', 'Ingolstadt', 'Würzburg', 'Fürth',
    'Wolfsburg', 'Offenbach am Main', 'Ulm', 'Heilbronn', 'Pforzheim',
    'Göttingen', 'Bottrop', 'Reutlingen', 'Koblenz', 'Bremerhaven',
    'Bergisch Gladbach', 'Remscheid', 'Jena', 'Trier', 'Erlangen', 'Moers',
    'Salzgitter', 'Siegen', 'Hildesheim', 'Cottbus',
    'Gütersloh', 'Gera', 'Kaiserslautern', 'Witten', 'Schwerin', 'Iserlohn',
    'Zwickau', 'Düren', 'Esslingen am Neckar', 'Ratingen'
    // Comment to keep the line breaks
  ];

  static final List<String> _statesUs = [
    'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
    'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
    'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
    'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
    'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
    // Comment to keep the line breaks
  ];

  static final List<String> _statesDe = [
    'BW', 'BY', 'BE', 'BB', 'HB', 'HH', 'HE', 'NI', 'MV', 'NW',
    'RP', 'SL', 'SN', 'ST', 'SH', 'TH'
    // Comment to keep the line breaks
  ];

  // static final List<String> _statesUsLong = [
  //   'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia',
  //   'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland',
  //   'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey',
  //   'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina',
  //   'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
  //   // Comment to keep the line breaks
  // ];

  // static final List<String> _statesDeLong = [
  //   'Baden-Württemberg', 'Bayern', 'Berlin', 'Brandenburg', 'Bremen', 'Hamburg', 'Hessen', 'Niedersachsen', 'Mecklenburg-Vorpommern', 'Nordrhein-Westfalen',
  //   'Rheinland-Pfalz', 'Saarland', 'Sachsen', 'Sachsen-Anhalt', 'Schleswig-Holstein', 'Thüringen'
  //   // Comment to keep the line breaks
  // ];

  static String _generatePhoneNumberUs() {
    String prefix = '+1'; // Assuming US phone numbers
    String number = ' ';
    for (int i = 0; i < 3; i++) {
      number += _random.nextInt(10).toString();
    }
    number += ' ';
    for (int i = 0; i < 7; i++) {
      number += _random.nextInt(10).toString();
    }
    return '$prefix$number';
  }

  static String _generatePhoneNumberDe() {
    String prefix = '+49'; // Assuming US phone numbers
    String number = ' ';
    var ortsvorwahlLength = _random.nextInt(3) + 2;
    for (int i = 0; i < ortsvorwahlLength; i++) {
      number += _random.nextInt(10).toString();
    }
    number += ' ';

    var numberLength = _random.nextInt(8) + 3;
    for (int i = 0; i < numberLength; i++) {
      number += _random.nextInt(10).toString();
    }

    return '$prefix$number';
  }

  static String _generateEmailAddress(
      {required String firstName,
      required String lastName,
      String domain = 'example.com'}) {
    return '${firstName.toLowerCase()}.${lastName.toLowerCase()}@$domain';
  }

  static String _generateDateOfBirth() {
    int year = 1940 + _random.nextInt(65);
    int month = 1 + _random.nextInt(12);
    int day = 1 + _random.nextInt(28); // Assuming all months have 28 days
    return '$year-$month-$day';
  }

  static String _generateJobTitleUs() {
    List<String> titles = [
      'Software Engineer',
      'Data Scientist',
      'Product Manager',
      'Marketing Manager',
      'Sales Representative',
      'Financial Analyst',
      'Human Resources Manager',
      'Graphic Designer',
      'Customer Service Representative',
      'Accountant',
      'Operations Manager',
      'Business Analyst',
      'Project Manager',
      'Software Developer',
      'Executive Assistant',
      'Administrative Assistant',
      'Web Developer',
      'Quality Assurance Analyst',
      'UX Designer',
      'Digital Marketing Specialist',
      'Content Writer',
      'Operations Analyst',
      'Customer Success Manager',
      'Account Manager',
      'Network Engineer',
      'Systems Administrator',
      'Data Analyst',
      'Financial Advisor',
      'HR Generalist',
      'Marketing Coordinator',
      'Sales Manager',
      'Business Development Manager',
      'Technical Support Specialist',
      'UI Designer',
      'Front End Developer',
      'Back End Developer',
      'Database Administrator',
      'UI/UX Designer',
      'Scrum Master',
      'Product Owner',
      'Business Intelligence Analyst',
      'Marketing Specialist',
      'Customer Experience Manager',
      'HR Manager',
      'Public Relations Specialist',
      'Operations Coordinator',
      'Digital Project Manager',
      'Software Architect',
      'DevOps Engineer',
      'IT Manager',
      'Marketing Director',
      'Financial Manager',
      'Risk Manager',
      'Legal Counsel',
      'Brand Manager',
      'Sales Associate',
      'Event Coordinator',
      'Supply Chain Manager',
      'Content Marketing Manager',
      'Creative Director',
      'User Researcher',
      'Information Security Analyst',
      'Customer Support Specialist',
      'Account Executive',
      'Logistics Coordinator',
      'Financial Controller',
      'Technical Project Manager',
      'HR Coordinator',
      'IT Specialist',
      'Social Media Manager',
      'Product Marketing Manager',
      'Business Consultant',
      'Digital Strategist',
      'Data Engineer',
      'Systems Analyst',
      'IT Support Specialist',
      'Sales Coordinator',
      'Quality Assurance Engineer',
      'Network Administrator',
      'Marketing Assistant',
      'Software Tester',
      'Customer Service Manager',
      'Executive Director',
      'Operations Assistant',
      'Office Manager',
      'Assistant Manager',
      'Recruiter',
      'Brand Ambassador',
      'Content Manager',
      'Market Research Analyst',
      'Sales Representative',
      'Personal Assistant',
      'Technical Writer',
      'Accounting Clerk',
      'Financial Analyst',
      'Event Planner',
      'SEO Specialist',
      'Graphic Artist', 'Systems Engineer', 'Production Manager'
      // Comment to keep lineBreaks
    ];
    return titles[_random.nextInt(titles.length)];
  }

  static String _generateJobTitleDe() {
    List<String> titles = [
      'Softwareentwickler',
      'Datenwissenschaftler',
      'Produktmanager',
      'Marketingmanager',
      'Vertriebsmitarbeiter',
      'Finanzanalyst',
      'Personalmanager',
      'Grafikdesigner',
      'Kundenberater',
      'Buchhalter',
      'Betriebsleiter',
      'Business-Analyst',
      'Projektmanager',
      'Software-Entwickler',
      'Assistent der Geschäftsleitung',
      'Verwaltungsassistent',
      'Web-Entwickler',
      'Qualitätssicherungsanalyst',
      'UX-Designer',
      'Spezialist für digitales Marketing',
      'Inhaltsautor',
      'Betriebsanalytiker',
      'Kundenbetreuungsmanager',
      'Key Account Manager',
      'Netzwerktechniker',
      'Systemadministrator',
      'Datenanalyst',
      'Finanzberater',
      'Personalspezialist',
      'Marketingkoordinator',
      'Vertriebsleiter',
      'Business Development Manager',
      'Technischer Support-Spezialist',
      'UI-Designer',
      'Front-End-Entwickler',
      'Back-End-Entwickler',
      'Datenbankadministrator',
      'UI/UX-Designer',
      'Scrum-Master',
      'Produktbesitzer',
      'Business Intelligence-Analyst',
      'Marketing-Spezialist',
      'Kundenbetreuungsmanager',
      'HR-Manager',
      'Spezialist für Öffentlichkeitsarbeit',
      'Betriebskoordinator',
      'Digital-Projektmanager',
      'Softwarearchitekt',
      'IT-Spezialist',
      'Marketingdirektor',
      'Finanzmanager',
      'Risikomanager',
      'Rechtsberater',
      'Markenmanager',
      'Vertriebsmitarbeiter',
      'Event-Koordinator',
      'Leiter der Lieferkette',
      'Manager für Content-Marketing',
      'Kreativdirektor',
      'Benutzerforscher',
      'Analyst für Informationssicherheit',
      'Spezialist für Kundensupport',
      'Account Executive',
      'Logistikkoordinator',
      'Finanzcontroller',
      'Technischer Projektleiter',
      'HR-Koordinator',
      'IT-Spezialist',
      'Manager für soziale Medien',
      'Produktmarketingmanager',
      'Unternehmensberater',
      'Digitalstratege',
      'Dateningenieur',
      'Systemanalytiker',
      'IT-Support-Spezialist',
      'Vertriebskoordinator',
      'Qualitätssicherungsingenieur',
      'Netzwerkadministrator',
      'Marketingassistent',
      'Softwaretester',
      'Kundenbetreuungsmanager',
      'Geschäftsführer',
      'Betriebsassistent',
      'Büroleiter',
      'Stellvertretender Manager',
      'Personalvermittler',
      'Markenbotschafter',
      'Content-Manager',
      'Marktforschungsanalyst',
      'Vertriebsmitarbeiter',
      'Persönlicher Assistent',
      'Technischer Autor',
      'Buchhalter',
      'Finanzanalyst',
      'Veranstaltungsplaner',
      'SEO-Spezialist',
      'Grafiker',
      'Systemingenieur',
      'Produktionsleiter'
      // Comment to keep lineBreaks
    ];
    return titles[_random.nextInt(titles.length)];
  }

  static String _generateHobbiesUs() {
    List<String> titles = [
      'Reading', 'Writing', 'Drawing', 'Painting', 'Photography', 'Cooking',
      'Baking', 'Gardening', 'Hiking', 'Camping',
      'Fishing', 'Running', 'Swimming', 'Cycling', 'Yoga', 'Meditation',
      'Dancing', 'Singing', 'Playing an Instrument', 'Chess',
      'Board Games', 'Video Games', 'Watching Movies', 'Watching TV Shows',
      'Listening to Music', 'Travelling', 'Learning Languages',
      'Knitting',
      'Crocheting',
      'Woodworking',
      'Pottery',
      'Sculpting',
      'Model Building',
      'Collecting Stamps',
      'Collecting Coins',
      'Collecting Comic Books',
      'Collecting Action Figures', 'Collecting Antiques', 'DIY Projects',
      'Volunteering', 'Community Service', 'Skydiving', 'Bungee Jumping',
      'Rock Climbing',
      'Scuba Diving',
      'Surfing',
      'Skiing',
      'Snowboarding',
      'Ice Skating',
      'Ballet',
      'Tap Dancing',
      'Hip Hop Dancing',
      'Ballroom Dancing',
      'Latin Dancing',
      'Street Photography',
      'Astrophotography',
      'Portrait Photography',
      'Macro Photography',
      'Landscape Photography',
      'Botany',
      'Ornithology',
      'Astronomy',
      'Archaeology',
      'Geocaching',
      'Bird Watching', 'Stargazing', 'Meteorology', 'Geology', 'History',
      'Philosophy', 'Psychology', 'Sociology',
      'Anthropology', 'Political Science', 'Economics', 'Literature', 'Poetry',
      'Creative Writing', 'Journaling', 'Calligraphy',
      'Typography',
      'Graphic Design',
      'Web Design',
      'User Interface Design',
      'User Experience Design',
      'Animation',
      'Digital Illustration',
      'Comic Art',
      'Storyboarding'
      // Add more job titles as desired
    ];
    return titles[_random.nextInt(titles.length)];
  }

  static String _generateHobbiesDe() {
    List<String> titles = [
      'Lesen', 'Schreiben', 'Malen', 'Fotografieren', 'Kochen', 'Backen',
      'Gärtnern', 'Wandern', 'Camping', 'Angeln',
      'Laufen', 'Schwimmen', 'Radfahren', 'Yoga', 'Meditation', 'Tanzen',
      'Singen', 'Ein Instrument spielen', 'Schach', 'Brettspiele',
      'Video Spiele', 'Filme schauen', 'Serien schauen', 'Musik hören',
      'Reisen', 'Sprachen lernen', 'Stricken', 'Häkeln', 'Holzbearbeitung',
      'Töpfern', 'Skulpturieren', 'Modellbau', 'Briefmarken sammeln',
      'Münzen sammeln', 'Comics sammeln',
      'Actionfiguren sammeln',
      'Antiquitäten sammeln',
      'Heimwerken',
      'Freiwilligenarbeit',
      'Gemeindearbeit',
      'Fallschirmspringen',
      'Bungee-Jumping',
      'Klettern', 'Tauchen', 'Surfen', 'Skifahren', 'Snowboarden', 'Eislaufen',
      'Ballett', 'Stepptanz', 'Hip-Hop-Tanz',
      'Standardtanz',
      'Lateinamerikanischer Tanz',
      'Straßenfotografie',
      'Astrofotografie',
      'Portraitfotografie',
      'Makrofotografie',
      'Landschaftsfotografie',
      'Botanik', 'Ornithologie', 'Astronomie', 'Archäologie', 'Geocaching',
      'Vogelbeobachtung', 'Sternegucken', 'Meteorologie',
      'Geologie', 'Geschichte', 'Philosophie', 'Psychologie', 'Soziologie',
      'Anthropologie', 'Politikwissenschaft', 'Wirtschaftswissenschaften',
      'Literatur', 'Poesie', 'Kreatives Schreiben', 'Tagebuch schreiben',
      'Kalligrafie', 'Typografie', 'Grafikdesign',
      'Webdesign', 'Benutzeroberflächendesign', 'Benutzererfahrungsdesign',
      'Animation', 'Digitale Illustration', 'Comic-Kunst', 'Storyboarding'
      // Add more job titles as desired
    ];
    return titles[_random.nextInt(titles.length)];
  }

  static RandomAddress generateFakeAddressUs() {
    String firstName = _firstNamesUs[_random.nextInt(_firstNamesUs.length)];
    String lastName = _lastNamesUs[_random.nextInt(_lastNamesUs.length)];
    String street =
        '${_random.nextInt(1000)} ${_streetsUs[_random.nextInt(_streetsUs.length)]}';
    String zipCode = '${10000 + _random.nextInt(90000)}';
    String city = _citiesUs[_random.nextInt(_citiesUs.length)];
    String state = _statesUs[_random.nextInt(_statesUs.length)];
    String country = 'USA';
    String telephoneNumber = _generatePhoneNumberUs();
    String mobileTelephoneNumber = _generatePhoneNumberUs();
    String emailAddress =
        _generateEmailAddress(firstName: firstName, lastName: lastName);
    String dateOfBirth = _generateDateOfBirth();
    String jobTitle = _generateJobTitleUs();
    String hobbies = "${_generateHobbiesUs()} ${_generateHobbiesUs()}";

    return RandomAddress(
      firstName: firstName,
      lastName: lastName,
      street: street,
      zipCode: zipCode,
      city: city,
      state: state,
      country: country,
      telephoneNumber: telephoneNumber,
      mobileTelephoneNumber: mobileTelephoneNumber,
      emailAddress: emailAddress,
      dateOfBirth: dateOfBirth,
      jobTitle: jobTitle,
      hobbies: hobbies,
    );
  }

  static RandomAddress generateFakeAddressDe() {
    String firstName = _firstNamesDe[_random.nextInt(_firstNamesUs.length)];
    String lastName = _lastNamesDe[_random.nextInt(_lastNamesUs.length)];
    String street =
        '${_streetsDe[_random.nextInt(_streetsUs.length)]} ${_random.nextInt(100)}';
    String zipCode = '${1000 + _random.nextInt(9999)}';
    String city = _citiesDe[_random.nextInt(_citiesUs.length)];
    String state = _statesDe[_random.nextInt(_statesUs.length)];
    String country = 'DE';
    String telephoneNumber = _generatePhoneNumberDe();
    String mobileTelephoneNumber = _generatePhoneNumberDe();
    String emailAddress =
        _generateEmailAddress(firstName: firstName, lastName: lastName);
    String dateOfBirth = _generateDateOfBirth();
    String jobTitle = _generateJobTitleDe();
    String hobbies = "${_generateHobbiesDe()} ${_generateHobbiesDe()}";

    return RandomAddress(
      firstName: firstName,
      lastName: lastName,
      street: street,
      zipCode: zipCode,
      city: city,
      state: state,
      country: country,
      telephoneNumber: telephoneNumber,
      mobileTelephoneNumber: mobileTelephoneNumber,
      emailAddress: emailAddress,
      dateOfBirth: dateOfBirth,
      jobTitle: jobTitle,
      hobbies: hobbies,
    );
  }

  static List<RandomAddress> generateFakeAddressesUs(int count) {
    List<RandomAddress> addresses = [];
    for (int i = 0; i < count; i++) {
      addresses.add(generateFakeAddressUs());
    }
    return addresses;
  }

  static List<RandomAddress> generateFakeAddressesDe(int count) {
    List<RandomAddress> addresses = [];
    for (int i = 0; i < count; i++) {
      addresses.add(generateFakeAddressDe());
    }
    return addresses;
  }
}
