import 'dart:convert';

class User {
  final String userName;
  final String phoneNumber;
  final String fullName;
  final String address;
  final int zipCode;
  final String email;
  final String district;
  final String? landSize;
  final Role role;
  final Lang lang;
  final int? vote;
  final List<Commodities>? commoditySelling;
  final String accCreationDate;
  final bool isAccountDisabled;
  final Map<Commodities, int>? vaultContent;

  const User({
    required this.userName,
    required this.phoneNumber,
    required this.address,
    this.commoditySelling,
    required this.district,
    required this.email,
    required this.fullName,
    this.landSize,
    required this.lang,
    required this.role,
    this.vote,
    required this.accCreationDate,
    this.vaultContent,
    required this.isAccountDisabled,
    required this.zipCode,
  });

  User copyWith({
    String? userName,
    String? phoneNumber,
    String? fullName,
    String? address,
    int? zipCode,
    String? email,
    String? district,
    String? landSize,
    Role? role,
    Lang? lang,
    int? vote,
    List<Commodities>? commoditySelling,
    String? accCreationDate,
    bool? isAccountDisabled,
    Map<Commodities, int>? vaultContent,
  }) {
    return User(
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      zipCode: zipCode ?? this.zipCode,
      email: email ?? this.email,
      district: district ?? this.district,
      landSize: landSize ?? this.landSize,
      role: role ?? this.role,
      lang: lang ?? this.lang,
      vote: vote ?? this.vote,
      commoditySelling: commoditySelling ?? this.commoditySelling,
      accCreationDate: accCreationDate ?? this.accCreationDate,
      isAccountDisabled: isAccountDisabled ?? this.isAccountDisabled,
      vaultContent: vaultContent ?? this.vaultContent,
    );
  }

  factory User.fromJson(String savedUserJson) {
    final Map<String, dynamic> jsonMap = json.decode(savedUserJson);

    return User(
      userName: jsonMap['userName'],
      phoneNumber: jsonMap['phoneNumber'],
      fullName: jsonMap['fullName'],
      address: jsonMap['address'],
      zipCode: jsonMap['zipCode'],
      email: jsonMap['email'],
      district: jsonMap['district'],
      landSize: jsonMap['landSize'],
      role: _parseRole(jsonMap['role']),
      lang: _parseLang(jsonMap['lang']),
      vote: jsonMap['vote'],
      commoditySelling: _parseCommoditySelling(jsonMap['commoditySelling']),
      accCreationDate: jsonMap['accCreationDate'],
      isAccountDisabled: jsonMap['isAccountDisabled'],
      vaultContent: _parseVaultContent(jsonMap['vaultContent']),
    );
  }

  static Role _parseRole(String? roleString) {
    if (roleString == 'farmer') {
      return Role.farmer;
    } else if (roleString == 'expert') {
      return Role.expert;
    } else if (roleString == 'admin') {
      return Role.admin;
    } else {
      throw Exception('Invalid role: $roleString');
    }
  }

  static Lang _parseLang(String? langString) {
    if (langString == 'en') {
      return Lang.en;
    } else if (langString == 'bn') {
      return Lang.bn;
    } else {
      throw Exception('Invalid lang: $langString');
    }
  }

  static List<Commodities>? _parseCommoditySelling(
      dynamic commoditySellingJson) {
    if (commoditySellingJson is List) {
      return commoditySellingJson.map((item) => _parseCommodity(item)).toList();
    } else {
      return null;
    }
  }

  static Commodities _parseCommodity(String? commodityString) {
    final commodity = Commodities.values.firstWhere(
      (c) => c.toString() == 'Commodities.$commodityString',
      orElse: () => throw Exception('Invalid commodity: $commodityString'),
    );
    return commodity;
  }

  static Map<Commodities, int>? _parseVaultContent(dynamic vaultContentJson) {
    if (vaultContentJson is Map) {
      final vaultContentMap = <Commodities, int>{};
      vaultContentJson.forEach((key, value) {
        final commodity = _parseCommodity(key);
        final count = value as int;
        vaultContentMap[commodity] = count;
      });
      return vaultContentMap;
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'address': address,
      'zipCode': zipCode,
      'email': email,
      'district': district,
      'landSize': landSize,
      'role': role.toString().split('.').last,
      'lang': lang.toString().split('.').last,
      'vote': vote,
      'commoditySelling': commoditySelling
          ?.map((commodity) => commodity.toString().split('.').last)
          .toList(),
      'accCreationDate': accCreationDate,
      'isAccountDisabled': isAccountDisabled,
      'vaultContent': vaultContent?.map(
          (key, value) => MapEntry(key.toString().split('.').last, value)),
    };
  }
}

enum Role { farmer, expert, admin }

enum Lang { en, bn }

enum Commodities {
  frenchBeansFrasbean,
  cabbage,
  gingerDry,
  tomato,
  peasDry,
  raddish,
  bhindiLadiesFinger,
  marigoldLoose,
  guava,
  mousambiSweetLime,
  capsicum,
  onion,
  chillyCapsicum,
  snakeguard,
  garlic,
  bittergourd,
  arharDalTurDal,
  sugar,
  mustard,
  paddyDhanCommon,
  blackGramDalUrdDal,
  greenChilli,
  cauliflower,
  roseLocal,
  squashChappalKadoo,
  lentilMasurWhole,
  fish,
  beans,
  banana,
  sweetPumpkin,
  mustardOil,
  pointedgourdParval,
  gingerGreen,
  carrot,
  sesamumSesameGingellyTil,
  bengalGramGramWhole,
  cucumbarKheera,
  ridgeguardTori,
  papayaRaw,
  masurDal,
  gurJaggery,
  moathDal,
  jute,
  mango,
  bottlegourd,
  apple,
  bengalGramDalChanaDal,
  potato,
  groundnut,
  pumpkin,
  wheat,
  rice,
  pomegranate,
  brinjal,
  greenGramDalMoongDal,
  arharTurRedGramWhole,
  betalLeaves,
  turmeric,
}
