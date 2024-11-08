import 'package:flutter/material.dart';
import '../models/song.dart';

class PlayerScreen extends StatelessWidget {
  final Song? song;

  PlayerScreen({this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        title: Text("Now Playing"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: song == null
          ? Center(
              child: Text(
                "No song selected",
                style: TextStyle(color: Colors.white),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cover Art
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(song!.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Song Title
                Text(
                  song!.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),

                // Artist Name
                Text(
                  song!.artist,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),

                // Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: 0.3, // Example progress
                        backgroundColor: Colors.white30,
                        color: Colors.amber,
                        minHeight: 5,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "1:24",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "3:45",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // Playback Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous, size: 40, color: Colors.white),
                      onPressed: () {
                        // Logic for skipping to previous song
                      },
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.amber,
                      child: IconButton(
                        icon: Icon(Icons.play_arrow, size: 40, color: Colors.white),
                        onPressed: () {
                          // Logic for playing/pausing song
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.skip_next, size: 40, color: Colors.white),
                      onPressed: () {
                        // Logic for skipping to next song
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                
                // Additional Controls (Like, Shuffle, Repeat)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.white),
                      onPressed: () {
                        // Logic to add to favorites
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shuffle, color: Colors.white),
                      onPressed: () {
                        // Logic to shuffle songs
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.repeat, color: Colors.white),
                      onPressed: () {
                        // Logic to repeat song
                      },
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
