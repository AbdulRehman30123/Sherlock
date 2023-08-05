class Team {
  String? id;
  Team({
    this.id,
  });

  Team.fromJson(Map<String, dynamic> json) {
    id = json["id"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;

    return data;
  }
}
