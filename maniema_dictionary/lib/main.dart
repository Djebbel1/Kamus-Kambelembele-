import 'package:flutter/material.dart';

void main() {
  runApp(const KamusKambelembeleApp());
}

class KamusKambelembeleApp extends StatelessWidget {
  const KamusKambelembeleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kamus Kambelembele',
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

  String sourceLanguage = 'Kyenye Kasenga';
  String targetLanguage = 'Français';

  String result = '';
  String sourceExample = '';
  String targetExample = '';

  final List<String> languages = [
    'Kyenye Kasenga',
    'Français',
    'Swahili',
    'English',
  ];

  void searchWord() {
    final word = searchController.text.trim();

    if (word.isEmpty) {
      setState(() {
        result = '';
        sourceExample = '';
        targetExample = '';
      });
      return;
    }

    setState(() {
      result = 'Résultat de démonstration pour « $word »';
      sourceExample = 'Exemple dans $sourceLanguage';
      targetExample = 'Exemple traduit en $targetLanguage';
    });
  }

  void invertLanguages() {
    if (sourceLanguage == targetLanguage) return;

    setState(() {
      final temporary = sourceLanguage;
      sourceLanguage = targetLanguage;
      targetLanguage = temporary;
    });
  }

  void clearSearch() {
    searchController.clear();

    setState(() {
      result = '';
      sourceExample = '';
      targetExample = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kamus Kambelembele',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Historique',
            onPressed: () {},
            icon: const Icon(Icons.history),
          ),
          IconButton(
            tooltip: 'Favoris',
            onPressed: () {},
            icon: const Icon(Icons.star_border),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 20,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),

                      const Icon(
                        Icons.menu_book_rounded,
                        size: 64,
                      ),

                      const SizedBox(height: 12),

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
                        'Recherchez un mot dans une langue et obtenez sa traduction.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 28),

                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Langues',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 16),

                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      initialValue: sourceLanguage,
                                      decoration: InputDecoration(
                                        labelText: 'Langue source',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                          sourceLanguage = value;
                                        });
                                      },
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  IconButton(
                                    tooltip: 'Inverser les langues',
                                    onPressed: invertLanguages,
                                    icon: const Icon(
                                      Icons.swap_horiz,
                                      size: 30,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      initialValue: targetLanguage,
                                      decoration: InputDecoration(
                                        labelText: 'Langue cible',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => searchWord(),
                        decoration: InputDecoration(
                          labelText: 'Rechercher un mot',
                          hintText: 'Écrivez un mot ici...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (searchController.text.isNotEmpty)
                                IconButton(
                                  tooltip: 'Effacer',
                                  onPressed: clearSearch,
                                  icon: const Icon(Icons.clear),
                                ),
                              IconButton(
                                tooltip: 'Rechercher',
                                onPressed: searchWord,
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),

                      const SizedBox(height: 24),

                      if (result.isNotEmpty)
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Résultat',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                Text(
                                  result,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 18),

                                const Divider(),

                                const SizedBox(height: 12),

                                Text(
                                  'Exemple — $sourceLanguage',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  sourceExample,
                                  style: const TextStyle(fontSize: 16),
                                ),

                                const SizedBox(height: 14),

                                Text(
                                  'Traduction — $targetLanguage',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  targetExample,
                                  style: const TextStyle(fontSize: 16),
                                ),

                                const SizedBox(height: 18),

                                Wrap(
                                  alignment: WrapAlignment.end,
                                  spacing: 4,
                                  children: [
                                    IconButton(
                                      tooltip: 'Écouter',
                                      onPressed: () {},
                                      icon: const Icon(Icons.volume_up),
                                    ),
                                    IconButton(
                                      tooltip: 'Ajouter aux favoris',
                                      onPressed: () {},
                                      icon: const Icon(Icons.star_border),
                                    ),
                                    IconButton(
                                      tooltip: 'Partager',
                                      onPressed: () {},
                                      icon: const Icon(Icons.share),
                                    ),
                                    IconButton(
                                      tooltip: 'Copier',
                                      onPressed: () {},
                                      icon: const Icon(Icons.copy),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 24),

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

                      const SizedBox(height: 30),

                      const Text(
                        'Kyenye Kasenga • Français • Swahili • English',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Mode hors connexion',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}