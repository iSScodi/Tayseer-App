import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tayseer__app/screens/MunicipalityDetails_screen.dart';

class MunicipalityInfo {
  final int id;
  final String name;
  final String imagePath;

  MunicipalityInfo({required this.id, required this.name, required this.imagePath});

  factory MunicipalityInfo.fromJson(Map<String, dynamic> json) {
    return MunicipalityInfo(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
    );
  }
}

Future<List<MunicipalityInfo>> fetchMunicipalities() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/municipalities/'));

  if (response.statusCode == 200) {
    final List jsonData = jsonDecode(response.body);
    return jsonData.map((item) => MunicipalityInfo.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load municipalities');
  }
}

class AllMunicipalitiesScreen extends StatefulWidget {
  final String userName;
  const AllMunicipalitiesScreen({super.key, required this.userName});

  @override
  State<AllMunicipalitiesScreen> createState() => _AllMunicipalitiesScreenState();
}

class _AllMunicipalitiesScreenState extends State<AllMunicipalitiesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoading = true;
  List<MunicipalityInfo> _allMunicipalities = [];
  Set<int> followedMunicipalityIds = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
    _loadMunicipalities();
  }

  Future<void> _loadMunicipalities() async {
    try {
      final data = await fetchMunicipalities();
      setState(() {
        _allMunicipalities = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading municipalities: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMunicipalities = _allMunicipalities
        .where((m) => m.name.toLowerCase().contains(_searchQuery))
        .toList();

    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          "Hello ${widget.userName} 😊, Join your municipality\nConnect to people",
          style: const TextStyle(
            color: Color.fromARGB(255, 247, 225, 155),
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search municipality...',
              filled: true,
              fillColor: const Color.fromARGB(153, 209, 186, 144),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : filteredMunicipalities.isEmpty
                  ? const Center(
                      child: Text(
                        "No matching municipalities found.",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredMunicipalities.length,
                      itemBuilder: (context, index) {
                        final info = filteredMunicipalities[index];
                        final isJoined = followedMunicipalityIds.contains(info.id);

                        return Card(
                          color: const Color.fromARGB(255, 219, 216, 202),
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    info.imagePath,
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        info.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 71, 54, 0),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                if (isJoined) {
                                                  followedMunicipalityIds.remove(info.id);
                                                } else {
                                                  followedMunicipalityIds.add(info.id);
                                                }
                                              });

                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    isJoined
                                                        ? 'You left ${info.name}.'
                                                        : 'You joined ${info.name}!',
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              isJoined ? Icons.check_circle : Icons.favorite_border,
                                              size: 18,
                                            ),
                                            label: Text(isJoined ? "Joined" : "Join"),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color.fromARGB(188, 109, 62, 43),
                                              foregroundColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              textStyle: const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.arrow_forward_ios),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MunicipalityDetailsScreen(id: info.id),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}