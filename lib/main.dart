import 'package:flutter/material.dart';

void main() {
  runApp(const MySocialApp());
}

class MySocialApp extends StatelessWidget {
  const MySocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MySocial',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int page = 0;

  final List<String> posts = [
    'https://picsum.photos/id/1011/700/700',
    'https://picsum.photos/id/1015/700/700',
    'https://picsum.photos/id/1025/700/700',
  ];

  final List<bool> liked = [false, false, false];

  void addPost() {
    setState(() {
      posts.insert(
        0,
        'https://picsum.photos/id/${30 + posts.length}/700/700',
      );
      liked.insert(0, false);
      page = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(
        posts: posts,
        liked: liked,
        onLike: (index) {
          setState(() {
            liked[index] = !liked[index];
          });
        },
      ),
      const ReelsPage(),
      const SearchPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: screens[page],
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (index) {
          if (index == 2) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo),
                        title: const Text('Rasm joylash'),
                        onTap: () {
                          Navigator.pop(context);
                          addPost();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.video_library),
                        title: const Text('Reels joylash'),
                        onTap: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Reels yuklash keyingi bosqichda qo‘shiladi',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (index == 3) {
            setState(() {
              page = 2;
            });
          } else if (index == 4) {
            setState(() {
              page = 3;
            });
          } else {
            setState(() {
              page = index;
            });
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.video_library_outlined),
            selectedIcon: Icon(Icons.video_library),
            label: 'Reels',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined),
            selectedIcon: Icon(Icons.add_box),
            label: 'Post',
          ),
          NavigationDestination(
            icon: Icon
