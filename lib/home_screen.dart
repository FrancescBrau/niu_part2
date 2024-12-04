import 'package:flutter/material.dart';
import 'package:niu_part2/features/global_position/global_position_screen.dart';
import 'package:niu_part2/features/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkTheme,
    required databaseRepository,
  });

  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavBarIndex = 1;
  List<Widget> _navBarWidgets = [];
  final List<String> _titles = ['Global Position', 'Profile'];

  @override
  void initState() {
    super.initState();
    _navBarWidgets = [
      const GlobalPositionScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedNavBarIndex]),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Icon(
              widget.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: _navBarWidgets[_selectedNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Global Position',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedNavBarIndex,
        onTap: (int index) {
          setState(() {
            _selectedNavBarIndex = index;
          });
        },
      ),
    );
  }
}
