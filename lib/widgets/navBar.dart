import 'package:flutter/material.dart';

// Paginas
import 'package:zoiao/view/PrincipalView.dart';
import 'package:zoiao/view/buscar.dart';
import 'package:zoiao/view/cadastrarCliente.dart';
import 'package:zoiao/view/cadastrarOculos.dart';
import 'package:zoiao/view/opcoes.dart';

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  int _selectedIndex = 0;

  final _screens = [
    PrincipalView(), // Pagina vendas,
    cadastrarCliente(), // Cadastrar cliente
    cadastrarOculos(), // Cadastrar Oculos
    BuscaPage(), // PAgina de Buscar
    Opcoes(), // Pagina responsavel por configurar o usuario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 110,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF7165d6),
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.point_of_sale),
              label: "Venda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Cliente",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration_sharp),
              label: "Oculos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Buscar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Opções",
            )
          ],
        ),
      ),
    );
  }
}
