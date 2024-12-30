/// class to hold a randomly generated address
class RandomAddress {
  final String firstName;
  final String lastName;
  final String street;
  final String zipCode;
  final String city;
  final String state;
  final String country;
  final String telephoneNumber;
  final String mobileTelephoneNumber;
  final String emailAddress;
  final String dateOfBirth;
  final String jobTitle;
  final String hobbies;

  RandomAddress({
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.country,
    required this.telephoneNumber,
    required this.mobileTelephoneNumber,
    required this.emailAddress,
    required this.dateOfBirth,
    required this.jobTitle,
    required this.hobbies,
  });

  @override
  String toString() {
    return "$firstName $lastName";
  }
}
