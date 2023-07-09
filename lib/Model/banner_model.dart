
class BannerModel {
    String? img;
    String? title;
    String? desc;

    BannerModel({this.img, this.title, this.desc});

    BannerModel.fromJson(Map<String, dynamic> json) {
        img = json["img"];
        title = json["title"];
        desc = json["desc"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["img"] = img;
        _data["title"] = title;
        _data["desc"] = desc;
        return _data;
    }

    BannerModel copyWith({
        String? img,
        String? title,
        String? desc,
    }) => BannerModel(
        img: img ?? this.img,
        title: title ?? this.title,
        desc: desc ?? this.desc,
    );
}