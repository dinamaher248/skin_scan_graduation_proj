// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:audio_waveforms/audio_waveforms.dart'; // Library for displaying audio waveforms

// class VoiceMessage extends StatefulWidget {
//   @override
//   _VoiceMessageState createState() => _VoiceMessageState();
// }

// class _VoiceMessageState extends State<VoiceMessage> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;

//   // Placeholder for audio file path
//   String audioPath = 'assets/audio/sample_audio.mp3';

//   @override
//   void initState() {
//     super.initState();

//     // Listen to audio player's state
//     _audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == PlayerState.playing;
//       });
//     });

//     _audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });

//     _audioPlayer.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       decoration: BoxDecoration(
//         color: Colors.deepPurpleAccent,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
//             onPressed: () async {
//               if (isPlaying) {
//                 await _audioPlayer.pause();
//               } else {
//                 await _audioPlayer.setSource(DeviceFileSource(audioPath)); // Use the correct audio source
//                 await _audioPlayer.resume();
//               }
//             },
//           ),
//           // Waveform display
//           AudioFileWaveforms(
//             audioPath: audioPath, // Specify the audio path
//             playerWaveStyle: PlayerWaveStyle(
//               liveWaveColor: Colors.white,
//               fixedWaveColor: Colors.white60,
//             ),
//             size: Size(100, 50),
//             playerController: _audioPlayer, // Use the AudioPlayer directly
//           ),
//           SizedBox(width: 10),
//           // Duration and time
//           Text(
//             "${position.inSeconds} / ${duration.inSeconds}",
//             style: TextStyle(color: Colors.white),
//           ),
//           SizedBox(width: 20),
//           // Time of message (e.g., 10:45 PM)
//           Text(
//             "10:45 م",
//             style: TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }
