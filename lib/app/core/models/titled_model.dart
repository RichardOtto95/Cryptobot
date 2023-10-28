import 'package:cloud_firestore/cloud_firestore.dart';

class Titled {
  final String? avatar;
  final String? fullname;
  final String? username;
  final Timestamp? birthday;
  final String? cpf;
  final String? rg;
  final String? gender;
  final String? id;
  final String? mainAccount;
  final String? email;
  final String? phone;
  final String? status;
  final String? cep;
  final String? city;
  final String? state;
  final String? country;
  final String? neighborhood;
  final String? address;
  final String? number;
  final String? addressComplement;
  final String? mainAddress;
  final Timestamp? createdAt;
  final int? newNotifications;
  final List<String>? tokenId;
  final bool? connected;
  final bool? notificationEnabled;

  Titled({
    this.username,
    this.email,
    this.phone,
    this.avatar,
    this.fullname,
    this.birthday,
    this.cpf,
    this.rg,
    this.gender,
    this.id,
    this.status,
    this.cep,
    this.city,
    this.state,
    this.country,
    this.neighborhood,
    this.address,
    this.number,
    this.addressComplement,
    this.mainAddress,
    this.createdAt,
    this.newNotifications,
    this.tokenId,
    this.connected,
    this.notificationEnabled,
    this.mainAccount,
  });

  factory Titled.fromDoc(DocumentSnapshot doc) => Titled(
        username: doc["username"],
        email: doc["email"],
        phone: doc["phone"],
        avatar: doc["avatar"],
        fullname: doc["fullname"],
        birthday: doc["birthday"],
        cpf: doc["cpf"],
        rg: doc["rg"],
        gender: doc["gender"],
        id: doc["id"],
        status: doc["status"],
        cep: doc["cep"],
        city: doc["city"],
        state: doc["state"],
        country: doc["country"],
        neighborhood: doc["neighborhood"],
        address: doc["address"],
        number: doc["number"],
        addressComplement: doc["address_complement"],
        mainAddress: doc["main_address"],
        createdAt: doc["createdAt"],
        newNotifications: doc["new_notifications"],
        tokenId: doc["token_id"],
        connected: doc["connected"],
        notificationEnabled: doc["notification_enabled"],
        mainAccount: doc["main_account"],
      );

  Map<String, dynamic> toJson({Titled? tilted}) {
    bool hasParam = tilted != null;
    return {
      "username": hasParam ? tilted.username : username,
      "email": hasParam ? tilted.email : email,
      "phone": hasParam ? tilted.phone : phone,
      "avatar": hasParam ? tilted.avatar : avatar,
      "fullname": hasParam ? tilted.fullname : fullname,
      "birthday": hasParam ? tilted.birthday : birthday,
      "cpf": hasParam ? tilted.cpf : cpf,
      "rg": hasParam ? tilted.rg : rg,
      "gender": hasParam ? tilted.gender : gender,
      "id": hasParam ? tilted.id : id,
      "status": hasParam ? tilted.status : status,
      "cep": hasParam ? tilted.cep : cep,
      "city": hasParam ? tilted.city : city,
      "state": hasParam ? tilted.state : state,
      "country": hasParam ? tilted.country : country,
      "neighborhood": hasParam ? tilted.neighborhood : neighborhood,
      "address": hasParam ? tilted.address : address,
      "number": hasParam ? tilted.number : number,
      "address_complement":
          hasParam ? tilted.addressComplement : addressComplement,
      "main_address": hasParam ? tilted.mainAddress : mainAddress,
      "createdAt": hasParam ? tilted.createdAt : createdAt,
      "new_notifications":
          hasParam ? tilted.newNotifications : newNotifications,
      "token_id": hasParam ? tilted.tokenId : tokenId,
      "connected": hasParam ? tilted.connected : connected,
      "notification_enabled":
          hasParam ? tilted.notificationEnabled : notificationEnabled,
      "main_account": hasParam ? tilted.mainAccount : mainAccount,
    };
  }
}
