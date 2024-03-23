
import 'package:get/get.dart';
import 'package:audio_service/audio_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class playController extends GetxController{
  final AudioQuery =  OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var playIndex = 0.obs;
  var isPlay = false.obs;
  var duration = "".obs;
  var position = "".obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
 @override

 void onInit(){
  super.onInit();
  checkPermission();
  
 }
  UpdatePosition() {
  audioPlayer.durationStream.listen((event) { 
    duration.value = Duration(milliseconds: event!.inMilliseconds).toString(); // Convertir la durée en millisecondes en une chaîne
    max.value = event.inSeconds.toDouble(); // Récupérer la durée en secondes
  });

  audioPlayer.positionStream.listen((event) { 
    position.value = Duration(milliseconds: event!.inMilliseconds).toString(); // Convertir la position en millisecondes en une chaîne
    value.value = event.inSeconds.toDouble(); // Récupérer la position en secondes
  });
}

 changeDurationToSeconds(seconds){
  var duration = Duration(seconds: seconds);
  audioPlayer.seek(duration);
 }
 playSong(String? uri,index) {
  playIndex.value = index;
  try {
    if (uri != null) {
     audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(uri))
     );
      audioPlayer.play();
      isPlay(true);
      UpdatePosition();
    } else {
      // Gérer le cas où l'URI est null
    }
  } catch (e, stackTrace) {
    // Gérer l'exception ici
    print("Une erreur s'est produite : $e");
    print("StackTrace : $stackTrace");
  }
}
checkPermission() async {
  var perm = await Permission.storage.request();
  while (!perm.isGranted) {
    perm = await Permission.storage.request();
  }
  // Une fois la permission accordée, vous pouvez ajouter d'autres actions ici si nécessaire.
}

}