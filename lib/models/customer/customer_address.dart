class CustomerAddress {
  const CustomerAddress({
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
  });

  factory CustomerAddress.fromMap(Map<String, dynamic> map) {
    return CustomerAddress(
      address: map['address'],
      city: map['city'],
      state: map['state'],
      zip: map['zip'],
    );
  }

  final String address;
  final String city;
  final String state;
  final String zip;

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
    };
  }
}
