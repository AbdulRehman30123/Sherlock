class Today {
  String? status;
  String? time;
  String? useremail;
  Today({this.status, this.time, this.useremail});

  Today.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    time = json["time"];
    useremail = json["userid"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["status"] = this.status;
    data["time"] = this.time;
    data["userid"] = this.useremail;

    return data;
  }
}
