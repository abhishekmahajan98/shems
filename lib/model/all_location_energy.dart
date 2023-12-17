
class AllLocationEnergy {
  String? cId;
  int? totalEnergyUsage;
  double? totalEnergyCost;
  List<Locations>? locations;

  AllLocationEnergy({this.cId, this.totalEnergyUsage, this.totalEnergyCost, this.locations});

  AllLocationEnergy.fromJson(Map<String, dynamic> json) {
    if(json["c_id"] is String) {
      cId = json["c_id"];
    }
    if(json["totalEnergyUsage"] is int) {
      totalEnergyUsage = json["totalEnergyUsage"];
    }
    if(json["totalEnergyCost"] is double) {
      totalEnergyCost = json["totalEnergyCost"];
    }
    if(json["locations"] is List) {
      locations = json["locations"] == null ? null : (json["locations"] as List).map((e) => Locations.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["c_id"] = cId;
    _data["totalEnergyUsage"] = totalEnergyUsage;
    _data["totalEnergyCost"] = totalEnergyCost;
    if(locations != null) {
      _data["locations"] = locations?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Locations {
  String? locationid;
  double? totalenergycost;
  int? totalenergyusage;

  Locations({this.locationid, this.totalenergycost, this.totalenergyusage});

  Locations.fromJson(Map<String, dynamic> json) {
    if(json["locationid"] is String) {
      locationid = json["locationid"];
    }
    if(json["totalenergycost"] is double) {
      totalenergycost = json["totalenergycost"];
    }
    if(json["totalenergyusage"] is int) {
      totalenergyusage = json["totalenergyusage"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["locationid"] = locationid;
    _data["totalenergycost"] = totalenergycost;
    _data["totalenergyusage"] = totalenergyusage;
    return _data;
  }
}