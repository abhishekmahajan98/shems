class LocationDeviceEnergyConsumedModel {
  String? locId;
  int? totalEnergyUsage;
  double? totalEnergyCost;
  List<Devices>? devices;

  LocationDeviceEnergyConsumedModel(
      {this.locId, this.totalEnergyUsage, this.totalEnergyCost, this.devices});

  LocationDeviceEnergyConsumedModel.fromJson(Map<String, dynamic> json) {
    if (json["loc_id"] is String) {
      locId = json["loc_id"];
    }
    if (json["totalEnergyUsage"] is int) {
      totalEnergyUsage = json["totalEnergyUsage"];
    }
    if (json["totalEnergyCost"] is double) {
      totalEnergyCost = json["totalEnergyCost"];
    }
    if (json["devices"] is List) {
      devices = json["devices"] == null
          ? null
          : (json["devices"] as List).map((e) => Devices.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["loc_id"] = locId;
    _data["totalEnergyUsage"] = totalEnergyUsage;
    _data["totalEnergyCost"] = totalEnergyCost;
    if (devices != null) {
      _data["devices"] = devices?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Devices {
  String? deviceid;
  String? mNum;
  String? mName;
  double? totalenergycost;
  double? totalenergyusage;

  Devices(
      {this.deviceid,
      this.mNum,
      this.mName,
      this.totalenergycost,
      this.totalenergyusage});

  Devices.fromJson(Map<String, dynamic> json) {
    if (json["deviceid"] is String) {
      deviceid = json["deviceid"];
    }
    if (json["m_num"] is String) {
      mNum = json["m_num"];
    }
    if (json["m_name"] is String) {
      mName = json["m_name"];
    }
    if (json["totalenergycost"] is double) {
      totalenergycost = json["totalenergycost"];
    }
    if (json["totalenergyusage"] is double) {
      totalenergyusage = json["totalenergyusage"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["deviceid"] = deviceid;
    _data["m_num"] = mNum;
    _data["m_name"] = mName;
    _data["totalenergycost"] = totalenergycost;
    _data["totalenergyusage"] = totalenergyusage;
    return _data;
  }
}
