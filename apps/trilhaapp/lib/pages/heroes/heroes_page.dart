import 'package:flutter/material.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:trilhaapp/service/repositories/marvel/marvel_repository.dart';

class HeroesPage extends StatefulWidget {
  const HeroesPage({super.key});

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  ScrollController _scrollController = ScrollController();
  late MarvelRepository marvelRepository;
  CharactersModel characters = CharactersModel();
  int offset = 0;
  var loading = false;

  @override
  void initState() {
    marvelRepository = MarvelRepository();
    loadData();
    _scrollController.addListener(() {
      var positionToLoadMore = 0.7 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels >= positionToLoadMore) {
        loadData();
      }
    });
    super.initState();
  }

  loadData() async {
    if (loading) return;
    if (characters.data == null || characters.data!.results == null) {
      characters = await marvelRepository.fetchCharacters(offset);
    } else {
      setState(() {
        loading = true;
      });
      offset = characters.data!.count! + offset;
      var tempList = await marvelRepository.fetchCharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
      loading = false;
    }
    setState(() {});
  }

  int countAllHeroes() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int countCurrentHeroes() {
    try {
      return characters.data!.count! + offset;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("Heróis: ${countCurrentHeroes()}/${countAllHeroes()}")),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: (characters.data == null ||
                        characters.data!.results == null)
                    ? 0
                    : characters.data!.results!.length,
                itemBuilder: (_, index) {
                  var character = characters.data!.results![index];
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          "${character.thumbnail!.path}.${character.thumbnail!.extension}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  character.description!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            !loading
                ? ElevatedButton(
                    onPressed: () {
                      loadData();
                    },
                    child: const Text("Próxima"),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
