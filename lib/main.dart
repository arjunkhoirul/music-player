import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/player_screen.dart';
import 'models/song.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Set<Song> _favorites = {}; // Menggunakan Set untuk menghindari duplikasi
  Song? _currentSong;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Fungsi untuk menambah atau menghapus lagu dari favorit
  void _toggleFavorite(Song song) {
    setState(() {
      if (_favorites.any((favSong) => favSong.title == song.title && favSong.artist == song.artist)) {
        // Hapus jika sudah ada di favorit
        _favorites.removeWhere((favSong) => favSong.title == song.title && favSong.artist == song.artist);
      } else {
        // Tambah ke favorit jika belum ada
        _favorites.add(song);
      }
    });
  }

  // Fungsi untuk memilih lagu dan mengarah ke PlayerScreen
  void _selectSong(Song song) {
    setState(() {
      _currentSong = song;
      _selectedIndex = 1;  // Pindah ke PlayerScreen
    });
  }

  List<Widget> get _widgetOptions => [
    HomeScreen(
      onFavoriteToggle: _toggleFavorite,
      favorites: _favorites,
      onSongSelect: _selectSong,
    ),
    PlayerScreen(song: _currentSong),
    FavoritesScreen(
      favorites: _favorites,
      onRemove: _toggleFavorite,
      onSongSelect: _selectSong,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Player',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
