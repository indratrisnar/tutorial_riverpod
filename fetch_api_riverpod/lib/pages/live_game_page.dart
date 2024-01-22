import 'package:extended_image/extended_image.dart';
import 'package:fetch_api_riverpod/models/game.dart';
import 'package:fetch_api_riverpod/providers/genre_provider.dart';
import 'package:fetch_api_riverpod/providers/live_game_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveGamePage extends ConsumerStatefulWidget {
  const LiveGamePage({super.key});

  @override
  ConsumerState<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends ConsumerState<LiveGamePage> {
  List<String> genres = [
    'Shooter',
    'MMOARPG',
    'ARPG',
    'Strategy',
    'Fighting',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(liveGameNotifierProvider.notifier).fetchLiveGames();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Games'),
      ),
      body: Column(
        children: [
          Consumer(builder: (context, wiRef, child) {
            String genreSelected = wiRef.watch(genreNotifierProvider);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: genres.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        onPressed: () {
                          ref.read(genreNotifierProvider.notifier).change(e);
                        },
                        label: Text(
                          e,
                          style: TextStyle(
                            color: genreSelected == e
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        backgroundColor: genreSelected == e
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Expanded(
            child: Consumer(
              builder: (context, wiRef, child) {
                LiveGameState state = wiRef.watch(liveGameNotifierProvider);
                if (state.status == '') return const SizedBox.shrink();
                if (state.status == 'loading') {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.status == 'failed') {
                  return Center(
                    child: Text(state.message),
                  );
                }
                List<Game> list = state.data;
                String genreSelected = wiRef.watch(genreNotifierProvider);
                List<Game> games = list
                    .where((element) => element.genre == genreSelected)
                    .toList();
                return GridView.builder(
                  itemCount: games.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    Game game = games[index];
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ExtendedImage.network(
                            game.thumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              ref
                                  .read(liveGameNotifierProvider.notifier)
                                  .changeIsSaved(
                                    game.copyWith(isSaved: !game.isSaved),
                                  );
                            },
                            icon: game.isSaved
                                ? const Icon(
                                    Icons.bookmark,
                                    color: Colors.blue,
                                  )
                                : const Icon(
                                    Icons.bookmark_border,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
