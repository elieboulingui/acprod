import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:acprod/page/playController.dart';

class Player extends StatelessWidget {
  final SongModel data;

  const Player({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<playController>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 250,
              width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: QueryArtworkWidget(
                id: data.id,
                type: ArtworkType.AUDIO,
                artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                nullArtworkWidget: const Icon(
                  Icons.music_note,
                  size: 48,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.vertical(top: Radius.circular(17)),
              ),
              child: Column(
                children: [
                  Text(
                    data.displayNameWOExt,
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(height: 23),
                  Text(
                    data.artist.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(height: 23),
                  Obx(() => Row(
                        children: [
                          Text(
                            controller.position.value,
                            style: TextStyle(color: Color.fromARGB(255, 146, 179, 0)),
                          ),
                          Expanded(
                            child: Slider(
                              thumbColor: Color.fromARGB(31, 0, 16, 247),
                              activeColor: Color.fromARGB(255, 241, 0, 48),
                              inactiveColor: Color.fromARGB(255, 255, 0, 0),
                              value: controller.value.value,
                              onChanged: (newvalue) {
                                controller.changeDurationToSeconds(newvalue.toInt());
                                newvalue = newvalue;
                              },
                            ),
                          ),
                          Text(
                            controller.duration.value,
                            style: TextStyle(color: Color.fromARGB(255, 255, 185, 180)),
                          ),
                        ],
                      )),
                  SizedBox(height: 1),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.skip_previous_rounded, size: 40),
                          ),
                          IconButton(
                            onPressed: () {
                              if (controller.isPlay.value) {
                                controller.audioPlayer.pause();
                                controller.isPlay(false);
                              } else {
                                controller.audioPlayer.play();
                                controller.isPlay(true);
                              }
                            },
                            icon: controller.isPlay.value ? Icon(Icons.pause, size: 29) : Icon(Icons.play_arrow, size: 54),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.skip_next_rounded, size: 29),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
