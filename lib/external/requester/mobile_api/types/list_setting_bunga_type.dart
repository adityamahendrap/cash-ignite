class ListSettingBunga {
  SettingBunga? activebunga;
  List<SettingBunga>? settingbungas;

  ListSettingBunga({this.activebunga, this.settingbungas});

  ListSettingBunga.fromJson(Map<String, dynamic> json) {
    activebunga = json['activebunga'] != null
        ? new SettingBunga.fromJson(json['activebunga'])
        : null;
    if (json['settingbungas'] != null) {
      settingbungas = <SettingBunga>[];
      json['settingbungas'].forEach((v) {
        settingbungas!.add(new SettingBunga.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activebunga != null) {
      data['activebunga'] = this.activebunga!.toJson();
    }
    if (this.settingbungas != null) {
      data['settingbungas'] =
          this.settingbungas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SettingBunga {
  int? id;
  double? persen;
  int? isaktif;

  SettingBunga({this.id, this.persen, this.isaktif});

  SettingBunga.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    persen = json['persen'];
    isaktif = json['isaktif'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['persen'] = this.persen;
    data['isaktif'] = this.isaktif;
    return data;
  }
}
