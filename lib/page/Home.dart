 import 'package:acprod/page/Play.dart';
import 'package:acprod/page/playController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(playController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search),)
        ],
        centerTitle: true, 
        backgroundColor: Colors.brown, 
        title: Text("ac music",style: TextStyle(color: Colors.blue),),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.AudioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (BuildContext context,  snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(snapshot.hasError){
            return Text("Error: ${snapshot.error}");
          } else if(snapshot.data == null || snapshot.data!.isEmpty){
            return Center(
              child: Text("No songs found"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final song = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child:Obx(()=> ListTile(
                        title: Text(song.title ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(song.artist ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                        leading:QueryArtworkWidget(id: snapshot.data![index].id, type: ArtworkType.AUDIO,
                        nullArtworkWidget: Icon(Icons.music_note,color: const Color.fromARGB(255, 180, 1, 1),size: 32,),),
                        trailing: controller.playIndex.value == index && controller.isPlay.value ? const Icon(Icons.play_arrow,color: Colors.red,):null,
                       onTap: () {
  Get.to(() => Player(data: snapshot.data![index]));
  controller.playSong(snapshot.data![index].uri, index);
}

                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}