class Profile {
  final String id;
  final String userName;
  final int age;
  final String address;
  final String phoneNumber;
  final String gender;
  final String email;
  final double pocketmoney;
  final String academicYear;
  final String classId;
  // final String profilePictureUrl = 'https://example.com/profile.jpg'; // Default profile picture URL
  
  Profile({
    required this.id,
    required this.userName,
    required this.age,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.email,
    required this.pocketmoney,
    required this.academicYear,
    required this.classId,
  });

  factory Profile.fromJson(Map<String, dynamic> j) => Profile(
        id: j['id']?? 0,
        userName: j['userName'] ?? '',
        age: int.tryParse(j['age'].toString()) ?? 0,
        address: j['address'] ?? '',
        phoneNumber: j['phoneNumber'] ?? '',
        gender: j['gender'] ?? '',
        email: j['email'] ?? '',
        pocketmoney: j['pocketmoney'] ?? '',
        academicYear: j['academicYear'] ?? '',
        classId: j['classId'] ?? '',
      );
}
