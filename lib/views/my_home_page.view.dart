import 'package:flutter/material.dart';
import 'package:interfone_digital/services/auth_service.dart';
import 'package:interfone_digital/utils/providers.dart';
import 'package:interfone_digital/views/chats_page.view.dart';
import 'package:interfone_digital/views/config_page.view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title = 'Interfone Digital'});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int initialPage = 0;
  late PageController _pageController;

  final authService = getIt<AuthService>();

  logout() async {
    await authService.logout();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Center(child: Text(widget.title)),
        ),
        body: PageView(
          controller: _pageController,
          children: const [
            ConfigPage(),
            ChatsPage(),
          ],
          onPageChanged: (index) {
            setState(() {
              initialPage = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: initialPage,
          onTap: (index) {
            setState(() {
              initialPage = index;
              _pageController.animateToPage(initialPage,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            });
          },
          selectedItemColor: Colors.greenAccent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
            ),
          ],
        ));
  }
}
