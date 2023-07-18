import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class RestApiPhoto extends StatefulWidget {
  RestApiPhoto({super.key});

  @override
  State<RestApiPhoto> createState() => _RestApiPhotoState();
}

class _RestApiPhotoState extends State<RestApiPhoto> {
  List<Photo> photolist = [];

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 2),
      maxNrOfCacheObjects: 200,
    ),
  );

  Future<List<Photo>> getPostApi() async {
    final responce = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var Data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map i in Data) {
        Photo photo = Photo(id: i["id"], title: i["title"], url: i["url"]);
        photolist.add(photo);
      }
      return photolist;
    } else {
      return photolist;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
                return ListView.builder(
                    itemCount: photolist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      "Number: ${snapshot.data![index].id.toString()}"),
                                  content: CachedNetworkImage(
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    imageUrl: snapshot.data![index].url.toString(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    key: UniqueKey(),
                                    width: 50,
                                    height: 50,

                                    cacheManager: customCacheManager,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter:
                                            const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                      ),

                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Close"))
                                  ],
                                );
                              });
                        },
                        title: Text(
                            "Number: ${snapshot.data![index].id.toString()}", style: const TextStyle(fontWeight: FontWeight.bold),),
                        leading:  CachedNetworkImage(
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            imageUrl: snapshot.data![index].url.toString(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          key: UniqueKey(),
                          cacheManager: customCacheManager,

                          width: 50,
                          height: 50,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter:
                                  const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                            ),

                          ),
                        ),

                        subtitle: Text(snapshot.data![index].title.toString()),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }


}

class Photo {
  String title, url;
  int id;

  Photo({required this.title, required this.url, required this.id});
}
