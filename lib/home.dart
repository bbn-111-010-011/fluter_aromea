// lib/home.dart


import 'UI/card1.dart';

/// Home ne fait plus de BottomNavigationBar.
/// Pour la fonctionnalité 1, il affiche simplement Ecran1 (Card1),
/// qui contient déjà un Scaffold, un AppBar et l'appel à l'API Platzi.
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Ecran1();
  }
}
