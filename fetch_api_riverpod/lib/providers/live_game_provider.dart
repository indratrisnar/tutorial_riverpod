import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fetch_api_riverpod/models/game.dart';
import 'package:fetch_api_riverpod/source/game_source.dart';

part 'live_game_provider.g.dart';

@riverpod
class LiveGameNotifier extends _$LiveGameNotifier {
  @override
  LiveGameState build() => const LiveGameState('', '', []);

  fetchLiveGames() async {
    state = const LiveGameState('loading', '', []);
    final games = await GameSource.getLive();
    if (games == null) {
      state = const LiveGameState('failed', 'Something went wrong', []);
    } else {
      state = LiveGameState('success', '', games);
    }
  }

  changeIsSaved(Game newGame) {
    int index = state.data.indexWhere((element) => element.id == newGame.id);
    state.data[index] = newGame;
    state = LiveGameState('success', '', [...state.data]);
  }
}

class LiveGameState extends Equatable {
  final String status;
  final String message;
  final List<Game> data;

  const LiveGameState(this.status, this.message, this.data);

  @override
  List<Object> get props => [status, message, data];
}
