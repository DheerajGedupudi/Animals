import 'package:flutter/material.dart';
import 'memory_game_page.dart';
import 'desert_game_page.dart';
import 'forest_game_page.dart';
import 'arctic_game_page.dart';
import 'ocean_game_page.dart';
import '../widgets/subtopic_card.dart';

class JungleLessonsPage extends StatefulWidget {
  const JungleLessonsPage({super.key});

  @override
  State<JungleLessonsPage> createState() => _JungleLessonsPageState();
}

class _JungleLessonsPageState extends State<JungleLessonsPage> {
  final List<String> topics = ['Animals', 'Habitats', 'Life Cycles', 'Food Chain'];
  int selectedTopicIndex = 0;

  final Map<String, List<Map<String, String>>> subtopics = {
    'Animals': [
      {'title': 'Herbivores', 'image': 'assets/images/herbivore.png'},
      {'title': 'Carnivores', 'image': 'assets/images/carnivore.png'},
      {'title': 'Omnivores', 'image': 'assets/images/omnivore.png'},
    ],
    'Life Cycles': [
      {'title': 'Butterfly', 'image': 'assets/images/butterfly.png'},
      {'title': 'Frog', 'image': 'assets/images/frog.png'},
    ],
    'Food Chain': [
      {'title': 'Producers & Consumers', 'image': 'assets/images/foodchain.png'},
    ]
  };

  @override
  Widget build(BuildContext context) {
    String currentTopic = topics[selectedTopicIndex];
    
    return Scaffold(
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
          
          // Semi-transparent overlay
          Container(
            color: Colors.white.withOpacity(0.5),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Jungle Lessons',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                      shadows: const [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: topics.map((topic) {
                      final isSelected = topic == currentTopic;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChoiceChip(
                          label: Text(topic),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() => selectedTopicIndex = topics.indexOf(topic));
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(child: _buildContentForTopic(currentTopic)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentForTopic(String topic) {
    if (topic == 'Habitats') {
      return Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE9A3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5A946), width: 5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHabitatColumn("Desert", "assets/images/habitat_desert.png"),
                _buildHabitatColumn("Forest", "assets/images/habitat_forest.png"),
                _buildHabitatColumn("Ocean", "assets/images/habitat_ocean.png"), // Optional/future
                _buildHabitatColumn("Arctic", "assets/images/habitat_arctic.png"),
              ],
            ),
          ),

          // Explore button → default to Desert
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DesertAnimalsApp()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.green.shade700, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Explore all animals in different habitats',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Other non-habitat topics
    final List<Map<String, String>> currentSubtopics = subtopics[topic]!;
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: currentSubtopics.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final subtopic = currentSubtopics[index];
        return SubtopicCard(
          title: subtopic['title']!,
          image: subtopic['image']!,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MemoryGamePage(
                  lessonTitle: subtopic['title']!,
                  lessonImage: subtopic['image']!,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHabitatColumn(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        Widget destination;
        if (title == "Desert") {
          destination = const DesertAnimalsApp();
        } else if (title == "Forest") {
          destination = const ForestAnimalsApp();
        }else if (title == "Ocean") {
          destination = const OceanAnimalsApp();
        }else if (title == "Arctic") {
          destination = const ArcticAnimalsApp();
        } 
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Coming soon: $title")),
          );
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destination),
        );
      },
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF764A1C), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5E3710),
            ),
          ),
        ],
      ),
    );
  }
}
