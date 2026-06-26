import 'package:flutter/material.dart';

void main() {
  runApp(const PrefeituraApp());
}

class PrefeituraApp extends StatelessWidget {
  const PrefeituraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prefeitura de Brazópolis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004A80), // Azul principal
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ResponsiveScaffold(),
    );
  }
}

class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({super.key});

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('Início', style: TextStyle(fontSize: 24))),
    Center(child: Text('Protocolos', style: TextStyle(fontSize: 24))),
    Center(child: Text('Notificações', style: TextStyle(fontSize: 24))),
    Center(child: Text('Menu', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prefeitura de Brazópolis'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Se a tela for larga (tablet ou paisagem), exibe NavigationRail (Sidebar)
          if (constraints.maxWidth >= 600) {
            return Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Início'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.assignment_outlined),
                      selectedIcon: Icon(Icons.assignment),
                      label: Text('Protocolos'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.notifications_outlined),
                      selectedIcon: Icon(Icons.notifications),
                      label: Text('Avisos'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.menu),
                      selectedIcon: Icon(Icons.menu),
                      label: Text('Menu'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _pages[_selectedIndex],
                ),
              ],
            );
          }
          
          // Se a tela for estreita (celular em pé), exibe o conteúdo normalmente
          return _pages[_selectedIndex];
        },
      ),
      // E exibe a NavigationBar na parte de baixo apenas em telas estreitas
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Início',
                ),
                NavigationDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment),
                  label: 'Protocolos',
                ),
                NavigationDestination(
                  icon: Icon(Icons.notifications_outlined),
                  selectedIcon: Icon(Icons.notifications),
                  label: 'Avisos',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu),
                  selectedIcon: Icon(Icons.menu),
                  label: 'Menu',
                ),
              ],
            );
          }
          // Retorna SizedBox vazio para telas largas (pois já usamos o NavigationRail)
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
