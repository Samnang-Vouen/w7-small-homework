import 'package:flutter/foundation.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(_onPlayerChanged);
  }

  final SongRepository songRepository;
  final PlayerState playerState;

  bool _initialized = false;
  List<Song> _songs = const [];

  List<Song> get songs => _songs;

  Song? get currentSong => playerState.currentSong;

  void init() {
    if (_initialized) return;
    _initialized = true;

    _songs = songRepository.fetchSongs();
    notifyListeners();
  }

  bool isPlaying(Song song) => playerState.currentSong == song;

  void play(Song song) {
    playerState.start(song);
  }

  void stop() {
    playerState.stop();
  }

  void _onPlayerChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    playerState.removeListener(_onPlayerChanged);
    super.dispose();
  }
}
