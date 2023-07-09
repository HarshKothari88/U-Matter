
class UserModel {
    String? name;
    int? age;
    int? weight;
    int? height;
    String? gender;

    UserModel({this.name, this.age, this.weight, this.height, this.gender});

    UserModel.fromJson(Map<String, dynamic> json) {
        name = json["name"];
        age = json["age"];
        weight = json["weight"];
        height = json["height"];
        gender = json["gender"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["name"] = name;
        _data["age"] = age;
        _data["weight"] = weight;
        _data["height"] = height;
        _data["gender"] = gender;
        return _data;
    }

    UserModel copyWith({
        String? name,
        int? age,
        int? weight,
        int? height,
        String? gender,
    }) => UserModel(
        name: name ?? this.name,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        gender: gender ?? this.gender,
    );
}