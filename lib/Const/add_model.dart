class Advertisement {
  final String companyName;
  final String fromDate;
  final String phone;
  final String selectedImage;
  final String selectedOption;
  final String toDate;
  final String webLink;

  Advertisement({
    required this.companyName,
    required this.fromDate,
    required this.phone,
    required this.selectedImage,
    required this.selectedOption,
    required this.toDate,
    required this.webLink,
  });

  // Factory constructor to create an instance from a snapshot
  factory Advertisement.fromMap(Map<dynamic, dynamic> map) {
    return Advertisement(
      companyName: map['companyname'] ?? '',
      fromDate: map['fromDate'] ?? '',
      phone: map['phone'] ?? '',
      selectedImage: map['selectedImage'] ?? '',
      selectedOption: map['selectedOption'] ?? '',
      toDate: map['toDate'] ?? '',
      webLink: map['webLink'] ?? '',
    );
  }
}
