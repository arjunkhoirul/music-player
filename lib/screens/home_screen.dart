import 'package:flutter/material.dart';
import '../models/song.dart';

class HomeScreen extends StatefulWidget {
  final Function(Song) onFavoriteToggle;
  final Set<Song> favorites;
  final Function(Song) onSongSelect;

  HomeScreen({
    required this.onFavoriteToggle,
    required this.favorites,
    required this.onSongSelect,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Song> songs = [
    Song(
        title: "I'm Good (Blue)",
        artist: "David Guetta & Bebe Rexha",
        imagePath: 'assets/images/song1.jpeg'),
    Song(
        title: "Under the Influence",
        artist: "Chris Brown",
        imagePath: 'assets/images/song2.jpeg'),
    Song(
        title: "Forget Me",
        artist: "Lewis Capaldi",
        imagePath: 'assets/images/song3.jpeg'),
  ];

  List<Song> filteredSongs = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredSongs = songs; // Awalnya, tampilkan semua lagu
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      // Filter lagu berdasarkan teks pencarian
      filteredSongs = songs
          .where((song) =>
              song.title.toLowerCase().contains(query.toLowerCase()) ||
              song.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void toggleFavorite(Song song) {
    setState(() {
      widget.onFavoriteToggle(song);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        title: Text("Trending right now"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => updateSearchQuery(query),
              decoration: InputDecoration(
                hintText: "Search songs or artists...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.deepPurple[700],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSongs.length,
              itemBuilder: (context, index) {
                Song song = filteredSongs[index];
                bool isFavorite = widget.favorites.contains(song);

                return Card(
                  color: Colors.deepPurple[700],
                  child: ListTile(
                    leading: Image.asset(song.imagePath, width: 50, height: 50),
                    title:
                        Text(song.title, style: TextStyle(color: Colors.white)),
                    subtitle: Text(song.artist,
                        style: TextStyle(color: Colors.white54)),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        toggleFavorite(song);
                      },
                    ),
                    onTap: () {
                      widget.onSongSelect(song);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
