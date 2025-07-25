class ServiceProviderModel {
  final String message;
  final Vendor vendor;

  ServiceProviderModel({
    required this.message,
    required this.vendor,
  });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      message: json['message'],
      vendor: Vendor.fromJson(json['vendor']),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "vendor": vendor.toJson(),
      };
}

class Vendor {
  final ProviderService providerService;
  final User user;
  final String message;

  Vendor({
    required this.providerService,
    required this.user,
    required this.message,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
  Map<String, dynamic> providerJson;

  if (json.containsKey('provider_Servive')) {
    providerJson = json['provider_Servive'] ?? {};
  } else if (json.containsKey('vendor')) {
    providerJson = json['vendor'] ?? {};
  } else {
    providerJson = {};
  }

  return Vendor(
    providerService: ProviderService.fromJson(providerJson),
    user: User.fromJson(json['user']),
    message: json['message'] ?? '',
  );
}


  Map<String, dynamic> toJson() => {
        "provider_Servive": providerService.toJson(),
        "user": user.toJson(),
        "message": message,
      };
}

class ProviderService {
  final int id;
  final String? status;
  final String? image;
  final String? address;
  final String? lang;
  final String? lat;

  ProviderService({
    required this.id,
    this.status,
    this.image,
    this.address,
    this.lang,
    this.lat,
  });

  factory ProviderService.fromJson(Map<String, dynamic> json) =>
      ProviderService(
        id: json["id"] ?? 0,
        status: json["status"],
        image: json["image"],
        address: json["address"],
        lang: json["lang"],
        lat: json["lat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "image": image,
        "address": address,
        "lang": lang,
        "lat": lat,
      };
}

class User {
  final int id;
  final String name;
  final String email;
  final String nationalId;
  final String? imageNationalId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.nationalId,
    required this.imageNationalId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        nationalId: json["national_id"] ?? '',
        imageNationalId: json["image_national_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "national_id": nationalId,
        "image_national_id": imageNationalId,
      };
}
