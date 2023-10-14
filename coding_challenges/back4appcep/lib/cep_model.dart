class CEPModel {
  List<Results> results = [];

  CEPModel({List<Results>? results}) {
    if (results != null) {
      results = results;
    }
  }

  CEPModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Results {
  String _objectId = "";
  String _cep = "";
  String _street = "";
  int? number;
  String? complement;
  String _city = "";
  String _state = "";
  String _createdAt = "";
  String _updatedAt = "";

  Results(
      {String? objectId,
      String? cep,
      String? street,
      int? number,
      String? complement,
      String? city,
      String? state,
      String? createdAt,
      String? updatedAt}) {
    if (objectId != null) {
      _objectId = objectId;
    }
    if (cep != null) {
      _cep = cep;
    }
    if (street != null) {
      _street = street;
    }
    if (number != null) {
      number = number;
    }
    if (complement != null) {
      complement = complement;
    }
    if (city != null) {
      _city = city;
    }
    if (state != null) {
      _state = state;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  String? get objectId => _objectId;
  set objectId(String? objectId) => _objectId = objectId!;
  String? get cep => _cep;
  set cep(String? cep) => _cep = cep!;
  String? get street => _street;
  set street(String? street) => _street = street!;
  String? get city => _city;
  set city(String? city) => _city = city!;
  String? get state => _state;
  set state(String? state) => _state = state!;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt!;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt!;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data.addAll({
      'objectId': _objectId,
      'cep': _cep,
      'street': _street,
      'number': number,
      'complement': complement,
      'city': _city,
      'state': _state,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
    });
    return data;
  }

  Results.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _cep = json['cep'];
    _street = json['street'];
    number = json['number'];
    complement = json['complement'];
    _city = json['city'];
    _state = json['state'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['cep'] = _cep;
    data['street'] = _street;
    data['number'] = number;
    data['complement'] = complement;
    data['city'] = _city;
    data['state'] = _state;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
