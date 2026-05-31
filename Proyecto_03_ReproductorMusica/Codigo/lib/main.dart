import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Reproductor',
      theme: ThemeData.dark(),
      home: const MusicPlayer(),
    );
  }
}

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  final AudioPlayer player = AudioPlayer();

  int indiceCancion = 0;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  bool loadingSong = false;

  List<String> canciones = [
    'assets/cancion.mp3',
    'assets/cancion1.mp3',
    'assets/cancion2.mp3',
    'assets/cancion3.mp3',
  ];

  List<String> portadas = [
    'assets/portada.jpg',
    'assets/portada1.jpg',
    'assets/portada2.jpg',
    'assets/portada3.jpg',
  ];

  List<String> nombresCanciones = [
    'NORMAL (Explicit Ver.)',
    'Sin Ti',
    'Algo Mágico',
    'Boy With Luv',
  ];

  List<String> artistas = [
    'BTS',
    'Morat, Jay Wheeler',
    'Rauw Alejandro',
    'BTS',
  ];

  bool get isPlaying => player.playing;

  @override
  void initState() {
    super.initState();

    cargarCancion();

    player.playerStateStream.listen((state) {

      if (state.processingState == ProcessingState.completed) {
        siguienteCancion();
      }

      setState(() {});
    });

    player.durationStream.listen((d) {

      if (d != null) {

        setState(() {
          duration = d;
        });
      }
    });

    player.positionStream.listen((p) {

      setState(() {
        position = p;
      });
    });
  }

  Future<void> cargarCancion() async {

    duration = Duration.zero;
    position = Duration.zero;

    await player.setAsset(
      canciones[indiceCancion],
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playMusic() async {

    await player.play();
  }

  void pauseMusic() async {

    await player.pause();
  }

  void replayMusic() async {

    await player.seek(Duration.zero);

    await player.play();
  }

  void siguienteCancion() async {

    if (loadingSong) return;

    loadingSong = true;

    indiceCancion++;

    if (indiceCancion >= canciones.length) {
      indiceCancion = 0;
    }

    await player.stop();

    await player.seek(Duration.zero);

    await cargarCancion();

    await player.play();

    loadingSong = false;

    setState(() {});
  }

  void anteriorCancion() async {

    if (loadingSong) return;

    loadingSong = true;

    indiceCancion--;

    if (indiceCancion < 0) {
      indiceCancion = canciones.length - 1;
    }

    await player.stop();

    await player.seek(Duration.zero);

    await cargarCancion();

    await player.play();

    loadingSong = false;

    setState(() {});
  }

  String formatDuration(Duration d) {

    String minutes =
        d.inMinutes.remainder(60).toString().padLeft(2, '0');

    String seconds =
        d.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(

        children: [

          AnimatedContainer(

            duration: const Duration(milliseconds: 700),

            decoration: BoxDecoration(

              image: DecorationImage(

                image: AssetImage(
                  portadas[indiceCancion],
                ),

                fit: BoxFit.cover,
              ),
            ),
          ),

          BackdropFilter(

            filter: ImageFilter.blur(
              sigmaX: 30,
              sigmaY: 30,
            ),

            child: Container(

              decoration: BoxDecoration(

                gradient: LinearGradient(

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [

                    Colors.deepPurple.withOpacity(0.35),

                    Colors.black.withOpacity(0.75),

                    Colors.black.withOpacity(0.95),
                  ],
                ),
              ),
            ),
          ),

          Center(

            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    AnimatedContainer(

                      duration: const Duration(milliseconds: 500),

                      width: isPlaying ? 260 : 240,
                      height: isPlaying ? 260 : 240,

                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(22),

                        boxShadow: [

                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.45),
                            blurRadius: 40,
                            spreadRadius: 6,
                          ),
                        ],

                        image: DecorationImage(

                          image: AssetImage(
                            portadas[indiceCancion],
                          ),

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(

                      nombresCanciones[indiceCancion],

                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(

                      artistas[indiceCancion],

                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(

                      width: 430,

                      child: Column(

                        children: [

                          Slider(

                            min: 0,

                            max: duration.inSeconds > 0
                                ? duration.inSeconds.toDouble()
                                : 1,

                            value: position.inSeconds
                                .clamp(
                                  0,
                                  duration.inSeconds > 0
                                      ? duration.inSeconds
                                      : 1,
                                )
                                .toDouble(),

                            activeColor: Colors.deepPurpleAccent,

                            inactiveColor: Colors.white24,

                            onChanged: (value) async {

                              final newPosition = Duration(
                                seconds: value.toInt(),
                              );

                              await player.seek(newPosition);
                            },
                          ),

                          Row(

                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                            children: [

                              Text(
                                formatDuration(position),
                              ),

                              Text(
                                duration.inSeconds > 0
                                    ? formatDuration(duration)
                                    : "00:00",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        IconButton(

                          onPressed: anteriorCancion,

                          icon: const Icon(
                            Icons.skip_previous,
                          ),

                          iconSize: 55,

                          color: Colors.white,
                        ),

                        const SizedBox(width: 10),

                        IconButton(

                          onPressed: replayMusic,

                          icon: const Icon(
                            Icons.replay,
                          ),

                          iconSize: 40,

                          color: Colors.white70,
                        ),

                        const SizedBox(width: 10),

                        Container(

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepPurpleAccent,
                            boxShadow: [

                              BoxShadow(
                                color: Colors.deepPurpleAccent
                                    .withOpacity(0.45),
                                blurRadius: 20,
                              ),
                            ],
                          ),

                          child: IconButton(

                            onPressed: () {

                              if (isPlaying) {

                                pauseMusic();

                              } else {

                                playMusic();
                              }
                            },

                            icon: Icon(

                              isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,

                              color: Colors.white,
                            ),

                            iconSize: 60,
                          ),
                        ),

                        const SizedBox(width: 10),

                        IconButton(

                          onPressed: siguienteCancion,

                          icon: const Icon(
                            Icons.skip_next,
                          ),

                          iconSize: 55,

                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(width: 50),

                Container(

                  width: 320,
                  height: 500,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    color: Colors.white.withOpacity(0.06),

                    borderRadius: BorderRadius.circular(25),

                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const Text(

                        "Fila de reproducción",

                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Expanded(

                        child: ListView.builder(

                          itemCount: nombresCanciones.length,

                          itemBuilder: (context, index) {

                            return GestureDetector(

                              onTap: () async {

                                if (loadingSong) return;

                                loadingSong = true;

                                indiceCancion = index;

                                await player.stop();

                                await player.seek(Duration.zero);

                                await cargarCancion();

                                await player.play();

                                loadingSong = false;

                                setState(() {});
                              },

                              child: AnimatedContainer(

                                duration: const Duration(
                                  milliseconds: 300,
                                ),

                                margin: const EdgeInsets.only(
                                  bottom: 12,
                                ),

                                padding: const EdgeInsets.all(10),

                                decoration: BoxDecoration(

                                  color: index == indiceCancion
                                      ? Colors.deepPurpleAccent
                                          .withOpacity(0.20)
                                      : Colors.transparent,

                                  borderRadius:
                                      BorderRadius.circular(15),
                                ),

                                child: Row(

                                  children: [

                                    ClipRRect(

                                      borderRadius:
                                          BorderRadius.circular(12),

                                      child: Image.asset(

                                        portadas[index],

                                        width: 60,
                                        height: 60,

                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(

                                      child: Column(

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [

                                          Text(

                                            nombresCanciones[index],

                                            style: TextStyle(

                                              color: index ==
                                                      indiceCancion
                                                  ? Colors.white
                                                  : Colors.white70,

                                              fontWeight:
                                                  FontWeight.bold,

                                              fontSize: 15,
                                            ),

                                            overflow:
                                                TextOverflow.ellipsis,
                                          ),

                                          const SizedBox(height: 4),

                                          Text(

                                            artistas[index],

                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),

                                            overflow:
                                                TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),

                                    if (index == indiceCancion &&
                                        isPlaying)

                                      const Icon(
                                        Icons.graphic_eq,
                                        color: Colors.greenAccent,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}