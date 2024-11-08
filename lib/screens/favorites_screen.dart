import 'package:flutter/material.dart';
import '../models/song.dart';

class FavoritesScreen extends StatefulWidget {
  final Set<Song> favorites;
  final Function(Song) onRemove;
  final Function(Song) onSongSelect;

  FavoritesScreen({
    required this.favorites,
    required this.onRemove,
    required this.onSongSelect,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Song> filteredFavorites = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Inisialisasi daftar favorit yang difilter dengan semua favorit awal
    filteredFavorites = widget.favorites.toList();
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      // Filter favorit berdasarkan teks pencarian
      filteredFavorites = widget.favorites
          .where((song) =>
              song.title.toLowerCase().contains(query.toLowerCase()) ||
              song.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void handleRemoveFavorite(Song song) {
    // Hapus lagu dari favorit
    widget.onRemove(song);

    // Perbarui UI untuk mencerminkan perubahan pada daftar favorit
    setState(() {
      filteredFavorites = widget.favorites.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        title: Text("Recent favourites"),
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
                hintText: "Search favorite songs or artists...",
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
            child: filteredFavorites.isEmpty
                ? Center(
                    child: Text(
                      "No favorites found",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView(
                    children: filteredFavorites.map((song) {
                      return Card(
                        color: Colors.purple[700],
                        child: ListTile(
                          leading: Image.asset(song.imagePath, width: 50, height: 50),
                          title: Text(song.title, style: TextStyle(color: Colors.white)),
                          subtitle: Text(song.artist, style: TextStyle(color: Colors.white54)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              handleRemoveFavorite(song);
                            },
                          ),
                          onTap: () {
                            widget.onSongSelect(song);
                          },
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
