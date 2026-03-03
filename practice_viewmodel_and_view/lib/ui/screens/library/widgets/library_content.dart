import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/songs/song.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSettingsState settingsState = context.watch<AppSettingsState>();
    final LibraryViewModel viewModel = context.watch<LibraryViewModel>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text('Library', style: AppTextStyles.heading),
          const SizedBox(height: 50),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.songs.length,
              itemBuilder: (context, index) {
                final song = viewModel.songs[index];
                final isPlaying = viewModel.isPlaying(song);

                return SongTile(
                  song: song,
                  isPlaying: isPlaying,
                  onTap: () => viewModel.play(song),
                  onStop: viewModel.stop,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: isPlaying
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Playing', style: TextStyle(color: Colors.amber)),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: onStop,
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text(
                    'STOP',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
