class MySongModel {
  final String? name;
  final String? album;
  final String? artist;
   
   MySongModel({this.album,this.artist,this.name});

   factory MySongModel.fromJson(Map<String,dynamic> json){
    return MySongModel(
      name: json['name'],
      album: json['album'],
      artist: json['artist']
    );
   }
}