class SongModel {
  final String? name;
  final String? album;
  final String? artist;
   
   SongModel({this.album,this.artist,this.name});

   factory SongModel.fromJson(Map<String,dynamic> json){
    return SongModel(
      name: json['name'],
      album: json['album'],
      artist: json['artist']
    );
   }
}