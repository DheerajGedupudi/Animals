// // lib/pages/memory_game_page.dart
// import 'package:flutter/material.dart';
// import 'subtopic_detail_page.dart';
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter_tts/flutter_tts.dart';

// class MemoryGamePage extends StatefulWidget {
//   final String lessonTitle;
//   final String lessonImage;

//   const MemoryGamePage({super.key, required this.lessonTitle, required this.lessonImage});

//   @override
//   State<MemoryGamePage> createState() => _MemoryGamePageState();
// }

// class _MemoryGamePageState extends State<MemoryGamePage> {
//   late List<Map<String, dynamic>> cards;
//   List<int> selectedIndices = [];
//   int score = 0;
//   int matchesFound = 0;
//   bool gameCompleted = false;
//   late FlutterTts flutterTts;
//   bool isSpanish = false;

//   // Animal information for the game
//  final List<Map<String, dynamic>> animalInfo = [
//     {
//       'name': 'Horse',
//       'image': 'assets/images/horse.jpg',
//       'description': 'Horses can sleep both standing up and lying down.They have nearly 360-degree vision.'
//     },
//     {
//       'name': 'Elephant',
//       'image': 'assets/images/elephant.png',
//       'description': 'Elephants have the largest brain of any land animal. They use their trunk to grab objects.'
//     },
//     {
//       'name': 'Deer',
//       'image': 'assets/images/deer.jpg',
//       'description': 'Deer are herbivorous mammals known for their speed, agility, and excellent sense of smell.'
//     },
//     {
//       'name': 'Zebra',
//       'image': 'assets/images/zebra.jpg',
//       'description': 'Zebras are known for their unique black and white stripe patterns, which are like fingerprints, meaning no two zebras have the exact same pattern. They are herbivores, primarily grazing on grasses in various African habitats.'
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initializeGame();
//     _initTts();
//   }

// lib/pages/memory_game_page.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';

class MemoryGamePage extends StatefulWidget {
  final String lessonTitle;
  final String lessonImage;

  const MemoryGamePage({super.key, required this.lessonTitle, required this.lessonImage});

  @override
  State<MemoryGamePage> createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  late List<Map<String, dynamic>> cards;
  List<int> selectedIndices = [];
  int score = 0;
  int matchesFound = 0;
  bool gameCompleted = false;
  late FlutterTts flutterTts;
  bool isSpanish = false;
  late List<Map<String, dynamic>> animalInfo;

  final Map<String, List<Map<String, dynamic>>> lessonData = {
    'Herbivores': [
      {'name': 'Horse', 'image': 'assets/images/horse.jpg', 'description': 'Horses can sleep both standing up and lying down. They have nearly 360-degree vision.'},
      {'name': 'Deer', 'image': 'assets/images/deer.jpg', 'description': 'Deer are herbivorous mammals known for their speed, agility, and excellent sense of smell.'},
      {'name': 'Zebra', 'image': 'assets/images/zebra.jpg', 'description': 'Zebras are known for their unique black and white stripes, like fingerprints.'},
      {'name': 'Elephant', 'image': 'assets/images/elephant.jpg', 'description': 'Elephants are large herbivorous mammals known for their intelligence, long trunks, and strong social bonds.'},
    ],
    'Carnivores': [
      {'name': 'Lion', 'image': 'assets/images/lion.jpg', 'description': 'Lions are powerful predators known as the kings of the jungle.'},
      {'name': 'Tiger', 'image': 'assets/images/tiger.jpg', 'description': 'Tigers are solitary hunters with distinctive orange and black stripes.'},
      {'name': 'Cheetah', 'image': 'assets/images/cheetah.jpg', 'description': 'Cheetahs are the fastest land animals, known for their speed when chasing prey.'},
      {'name': 'Wolf', 'image': 'assets/images/wolf.jpg', 'description': 'Wolves live and hunt in packs, and are skilled carnivorous predators.'},
    ],
    'Omnivores': [
      {'name': 'Bear', 'image': 'assets/images/bear.jpg', 'description': 'Bears eat both plants and animals. They hibernate during winter.'},
      {'name': 'Pig', 'image': 'assets/images/pig.jpg', 'description': 'Pigs are intelligent omnivores with excellent sense of smell.'},
      {'name': 'Raccoon', 'image': 'assets/images/raccoon.jpg', 'description': 'Raccoons are clever omnivores who eat fruits, insects, and small animals.'},
       {'name': 'Chimpanzee','image': 'assets/images/chimpanzee.jpg','description': 'Chimpanzees eat fruits, leaves, insects, and sometimes small animals or eggs.'
  },
    ],
    'Rainforest': [
      {'name': 'Toucan', 'image': 'assets/images/toucan.jpg', 'description': 'Toucans live in rainforest canopies and are known for their colorful beaks.'},
      {'name': 'Jaguar', 'image': 'assets/images/jaguar.jpg', 'description': 'Jaguars are strong swimmers and apex predators in the rainforest.'},
      {'name': 'Sloth', 'image': 'assets/images/sloth.jpg', 'description': 'Sloths move slowly and spend most of their time hanging upside down in trees.'},
      {'name': 'Poison Dart Frog', 'image': 'assets/images/poison_frog.jpg', 'description': 'Poison dart frogs are small but brightly colored and toxic.'},
    ],
    'Desert': [
      {'name': 'Camel', 'image': 'assets/images/camel.jpg', 'description': 'Camels store fat in their humps and can survive long periods without water.'},
      {'name': 'Fennec Fox', 'image': 'assets/images/fennec.jpg', 'description': 'Fennec foxes have large ears that help dissipate heat in the desert.'},
      {'name': 'Meerkat', 'image': 'assets/images/meerkat.jpg', 'description': 'Meerkats live in groups and are known for standing on two legs to watch for danger.'},
      {'name': 'Gila Monster', 'image': 'assets/images/gila_monster.jpg', 'description': 'The Gila monster is one of the few venomous lizards and lives in the desert.'},
    ],
    'Butterfly': [
      {'name': 'Egg', 'image': 'assets/images/egg.jpg', 'description': 'Butterflies start as eggs on plant leaves.'},
      {'name': 'Caterpillar', 'image': 'assets/images/caterpillar.jpg', 'description': 'Caterpillars eat leaves and grow rapidly before becoming a pupa.'},
      {'name': 'Pupa', 'image': 'assets/images/pupa.jpg', 'description': 'The pupa stage is when a caterpillar forms a chrysalis to transform.'},
      {'name': 'Adult Butterfly', 'image': 'assets/images/adult_butterfly.jpg', 'description': 'The adult butterfly emerges from the chrysalis with colorful wings.'},
    ],
    'Frog': [
      {'name': 'Tadpole', 'image': 'assets/images/tadpole.jpg', 'description': 'Tadpoles live in water and gradually develop legs.'},
      {'name': 'Adult Frog', 'image': 'assets/images/frog_adult.jpg', 'description': 'Adult frogs can jump great distances and live on land or in water.'},
      {'name': 'Egg', 'image': 'assets/images/frog_egg.jpg', 'description': 'Frogs begin life as eggs laid in water in jelly-like clusters.'},
      {'name': 'Froglet', 'image': 'assets/images/froglet.jpg', 'description': 'Froglets have small tails and legs and are transitioning to adult frogs.'},
    ],
    'Producers & Consumers': [
      {'name': 'Sun', 'image': 'assets/images/sun.jpg', 'description': 'The sun is the primary source of energy for all life on Earth.'},
      {'name': 'Grass', 'image': 'assets/images/grass.jpg', 'description': 'Grass is a producer that uses sunlight to make its own food.'},
      {'name': 'Deer', 'image': 'assets/images/deer.jpg', 'description': 'Deer are herbivore consumers that feed on plants and grass.'},
      {'name': 'Eagle', 'image': 'assets/images/eagle.jpg', 'description': 'Eagles are top consumers that hunt small animals and fish.'},
    ]
  };

  @override
  void initState() {
    super.initState();
    animalInfo = lessonData[widget.lessonTitle] ?? [];
    _initializeGame();
    _initTts();
  }
  
  Future<void> _initTts() async {
    flutterTts = FlutterTts();
    
    try {
      // Initialize TTS with better settings
      await flutterTts.setVolume(1.0);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setPitch(1.0);
      
      // Set up completion listener
      flutterTts.setCompletionHandler(() {
        // Optional: Show feedback when speech completes
        print("TTS playback completed");
      });
      
      // Set up error listener
      flutterTts.setErrorHandler((msg) {
        print("TTS error: $msg");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Voice error: $msg"),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
      
      await _setLanguage();
    } catch (e) {
      print("Error initializing TTS: $e");
    }
  }

  Future<void> _setLanguage() async {
    await flutterTts.setLanguage(isSpanish ? 'es-ES' : 'en-US');
  }

  Future<void> _speak(String text) async {
    await _setLanguage();
    await flutterTts.stop();
    
    // Set volume and speech rate for better clarity
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(isSpanish ? 0.5 : 0.5); // Slower rate for better comprehension
    await flutterTts.setPitch(1.0);
    
    // Show loading indicator while preparing speech
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Loading voice..."),
        duration: Duration(milliseconds: 800),
      ),
    );
    
    // Add slight delay to ensure snackbar appears before speech starts
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Speak the text
    var result = await flutterTts.speak(text);
    
    // Check result and show error if needed
    if (result != 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sorry, voice playback failed. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  void _initializeGame() {
    // Create cards: one image card and one text card for each animal
    cards = [];
    for (var animal in animalInfo) {
      // Add image card
      cards.add({
        'type': 'image',
        'image': animal['image'],
        'name': animal['name'],
        'revealed': false,
        'matched': false,
        'info': animal,
      });
      
      // Add name card
      cards.add({
        'type': 'text',
        'name': animal['name'],
        'revealed': false,
        'matched': false,
        'info': animal,
      });
    }
    // Shuffle the cards
    cards.shuffle(Random());
  }

  void _onCardTap(int index) {
    // If game is completed, show info popup for any tap
    if (gameCompleted) {
      _showAnimalInfoPopup(cards[index]['info']);
      return;
    }
    
    // Normal game logic for in-progress game
    // Ignore if card is already revealed or matched
    if (cards[index]['revealed'] || cards[index]['matched'] || selectedIndices.length >= 2) {
      return;
    }

    setState(() {
      cards[index]['revealed'] = true;
      selectedIndices.add(index);
    });

    // Check for match when two cards are selected
    if (selectedIndices.length == 2) {
      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;

        int first = selectedIndices[0];
        int second = selectedIndices[1];

        // Match if the names are the same and the types are different
        bool isMatch = cards[first]['name'] == cards[second]['name'] && 
                      cards[first]['type'] != cards[second]['type'];

        if (isMatch) {
          // Match found
          setState(() {
            cards[first]['matched'] = true;
            cards[second]['matched'] = true;
            score += 100;
            matchesFound++;
            
            // Check if all pairs have been found
            if (matchesFound == animalInfo.length) {
              gameCompleted = true;
            }
          });
          
          // Show animal info popup
          _showAnimalInfoPopup(cards[first]['info']);
          
        } else {
          // No match
          setState(() {
            cards[first]['revealed'] = false;
            cards[second]['revealed'] = false;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Try again!"),
              duration: Duration(seconds: 1),
            ),
          );
        }
        selectedIndices.clear();
        
        // If game completed, show celebration
        if (gameCompleted) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _showGameCompletedDialog();
          });
        }
      });
    }
  }
  
  void _showAnimalInfoPopup(Map<String, dynamic> animal) {
    bool isSpeaking = false;
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF5F7FF), Color(0xFFE0F2FE)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 90, // Smaller image container
                  width: 90, // Smaller image container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      animal['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  animal['name'],
                  style: const TextStyle(
                    fontSize: 24, // Slightly smaller text
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E3192),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFBAE6FD), width: 2),
                  ),
                  child: Text(
                    animal['description'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Language: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E3192),
                      ),
                    ),
                    Switch(
                      value: isSpanish,
                      activeColor: Color(0xFFFF6B6B),
                      onChanged: (val) {
                        setDialogState(() {
                          isSpanish = val;
                        });
                        setState(() {
                          isSpanish = val;
                        });
                        _setLanguage();
                      },
                    ),
                    Text(
                      isSpanish ? "Spanish" : "English",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSpanish ? Color(0xFFFF6B6B) : Color(0xFF2E3192),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    setDialogState(() {
                      isSpeaking = true;
                    });
                    
                    _speak(animal['description']).then((_) {
                      if (context.mounted) {
                        setDialogState(() {
                          isSpeaking = false;
                        });
                      }
                    });
                  },
                  icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up),
                  label: Text(
                    isSpeaking ? "Stop" : "Play Voiceover",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSpeaking ? Color(0xFFFF6B6B) : Color(0xFFAAFFE5),
                    foregroundColor: Color(0xFF40196D),
                    elevation: 3,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    flutterTts.stop();
                    Navigator.pop(dialogContext);
                  },
                  child: const Text(
                    "Continue Playing",
                    style: TextStyle(
                      color: Color(0xFF2E3192),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((_) {
      // Ensure TTS stops when dialog closes
      flutterTts.stop();
    });
  }
  
  void _showGameCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF5C1), Color(0xFFFFDD9E)],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '🎉 Congratulations! 🎉', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26, 
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B6B),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'You matched all the animals!',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Final Score: $score',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color(0xFF2E3192),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'You can now tap any animal to learn more!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFAAFFE5),
                  foregroundColor: Color(0xFF40196D),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Continue Playing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Brain Challenger',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: Color(0xFF40196D),
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Color(0xFFFF6B6B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '$score pts',
                style: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Semi-transparent overlay for better readability
          Container(
            color: Colors.white.withOpacity(0.7),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Match Pictures With Names',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF40196D),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Card grid with container for better visibility
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade200, width: 1.5),
                      ),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          return GestureDetector(
                            onTap: () => _onCardTap(index),
                            child: Card(
                              elevation: card['matched'] ? 0 : 2,
                              margin: EdgeInsets.zero,
                              shadowColor: card['matched'] ? Color(0xFF4ECDC4).withOpacity(0.5) : Colors.black.withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: card['matched'] ? Color(0xFFAAFFE5) : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              color: card['matched'] 
                                  ? Color(0xFFAAFFE5) // Aqua mint for matched cards
                                  : Color(0xFFFF87AB), // Soft pink for unmatched cards
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    if (card['revealed'] && !card['matched'])
                                      BoxShadow(
                                        color: Color(0xFFAAFFE5).withOpacity(0.3),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                  ],
                                ),
                                child: card['revealed'] || card['matched']
                                    ? (card['type'] == 'image' 
                                        ? Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(6),
                                              child: Image.asset(
                                                card['image'],
                                                fit: BoxFit.cover,
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  card['name'],
                                                  style: TextStyle(
                                                    fontSize: card['name'].length > 5 ? 16 : 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF40196D),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          )
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFF87AB),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "Flip the card",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF40196D),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



