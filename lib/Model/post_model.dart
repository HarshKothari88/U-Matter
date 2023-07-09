
class PostsModel {
    String? uid;
    String? name;
    String? profileImg;
    String? caption;
    String? img;
    int? likes;
    String? time;

    PostsModel({this.uid, this.name, this.profileImg, this.caption, this.img, this.likes, this.time});

    PostsModel.fromJson(Map<String, dynamic> json) {
        uid = json["uid"];
        name = json["name"];
        profileImg = json["profileImg"];
        caption = json["caption"];
        img = json["img"];
        likes = json["likes"];
        time = json["time"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["uid"] = uid;
        _data["name"] = name;
        _data["profileImg"] = profileImg;
        _data["caption"] = caption;
        _data["img"] = img;
        _data["likes"] = likes;
        _data["time"] = time;
        return _data;
    }

    PostsModel copyWith({
        String? uid,
        String? name,
        String? profileImg,
        String? caption,
        String? img,
        int? likes,
        String? time,
    }) => PostsModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        profileImg: profileImg ?? this.profileImg,
        caption: caption ?? this.caption,
        img: img ?? this.img,
        likes: likes ?? this.likes,
        time: time ?? this.time,
    );
}