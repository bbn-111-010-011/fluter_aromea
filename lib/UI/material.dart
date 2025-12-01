void main() {
// Si vous avez mytheme.dart fourni par Moodle, utilisez-le ici :
// return MaterialApp(title: 'TD2', theme: MyTheme.darkTheme, home: const Home());


final baseDark = ThemeData.dark();
final textTheme = GoogleFonts.robotoTextTheme(baseDark.textTheme);


return MaterialApp(
title: 'Fonctionalité 1',
theme: baseDark.copyWith(
textTheme: textTheme,
appBarTheme: AppBarTheme(
titleTextStyle: textTheme.headline6?.copyWith(fontSize: 20),
),
),
home: const Home(),
);
}
}


class Home extends StatefulWidget {
const Home({Key? key}) : super(key: key);


@override
State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
int _currentIndex = 0;


static const List<Widget> _pages = <Widget>[
GeneratedTasksPage(),
];


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('TD2 - Gestion de tâches', style: Theme.of(context).textTheme.headline6),
),
body: _pages[_currentIndex],
bottomNavigationBar: BottomNavigationBar(
currentIndex: _currentIndex,
onTap: (i) => setState(() => _currentIndex = i),
items: const [
BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Générées'),
],
),
);
}
}