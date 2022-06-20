class Company {
  late String? image;
  late String name;
  Company(this.image, this.name);
}

List<Company> companies = [
  Company(
    'lib/images/companies_logo/logo4.png',
    'McDonalds',
  ),
  Company(
    'lib/images/companies_logo/logo1.png',
    'Starbucks',
  ),
  Company(
    'lib/images/companies_logo/logo2.png',
    'Nike',
  ),
  Company(
    'lib/images/companies_logo/logo3.png',
    'Louis Vuitton',
  ),
  Company(
    'lib/images/companies_logo/logo5.png',
    'Pret A Manger',
  ),
  Company(
    'lib/images/companies_logo/logo6.png',
    'Carrefour',
  ),
  Company(
    'lib/images/companies_logo/logo7.png',
    'Virgin Megastore',
  ),
  Company(
    null,
    'Dave Winklevoss',
  ),
  Company(
    null,
    'Darren Hodgkin',
  ),
];
