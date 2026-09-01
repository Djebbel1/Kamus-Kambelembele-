import 'package:flutter/material.dart';

void main() {
  runApp(const ManiemaDictionaryApp());
}

class ManiemaDictionaryApp extends StatelessWidget {
  const ManiemaDictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maniema Dictionary',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  String targetLanguage = 'Français';

  final List<String> languages = [
    'Français',
    'Swahili',
    'English',
    'Kyenye Kasenga',
  ];

  String searchResult = '';
  String exampleSource = '';
  String exampleTarget = '';

  void searchWord() {
    final word = searchController.text.trim();

    if (word.isEmpty) {
      setState(() {
        searchResult = '';
        exampleSource = '';
        exampleTarget = '';
      });
      return;
    }

    // Données de démonstration uniquement.
    // Les véritables données linguistiques seront intégrées ensuite.
    setState(() {
      searchResult = 'Résultat pour : $word';
      exampleSource = 'Exemple dans la langue source';
      exampleTarget = 'Exemple traduit en $targetLanguage';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Maniema Dictionary',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              const Text(
                'Dictionnaire des langues du Maniema',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Recherchez un mot et choisissez la langue de traduction.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 28),

              TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => searchWord(),
                decoration: InputDecoration(
                  labelText: 'Rechercher un mot',
                  hintText: 'Ex. : mot en Kyenye Kasenga',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: searchWord,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: targetLanguage,
                decoration: InputDecoration(
                  labelText: 'Langue cible',
                  prefixIcon: const Icon(Icons.translate),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                items: languages.map((language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    targetLanguage = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              if (searchResult.isNotEmpty)
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Résultat',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          searchResult,
                          style: const TextStyle(fontSize: 18),
                        ),

                        const SizedBox(height: 15),

                        const Divider(),

                        const SizedBox(height: 10),

                        const Text(
                          'Exemple',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          exampleSource,
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          exampleTarget,
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 18),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              tooltip: 'Audio',
                              onPressed: () {},
                              icon: const Icon(Icons.volume_up),
                            ),
                            IconButton(
                              tooltip: 'Favori',
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border),
                            ),
                            IconButton(
                              tooltip: 'Partager',
                              onPressed: () {},
                              icon: const Icon(Icons.share),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.star_border),
                      label: const Text('Favoris'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.history),
                      label: const Text('Historique'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Mode hors connexion disponible',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}