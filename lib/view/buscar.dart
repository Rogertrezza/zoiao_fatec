import 'package:flutter/material.dart';
import 'package:zoiao/controller/buscarController.dart';

class BuscaPage extends StatefulWidget {
  const BuscaPage({Key? key}) : super(key: key);

  @override
  _BuscaPageState createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscaPage> {
  final BuscaController buscaController = BuscaController();
  TextEditingController _searchController = TextEditingController();
  String _tipoBusca = 'oculos'; // Inicia com busca por óculos

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {});
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecionar tipo de busca'),
          content: DropdownButton<String>(
            value: _tipoBusca,
            onChanged: (value) {
              setState(() {
                _tipoBusca = value!;
              });
              Navigator.of(context).pop();
            },
            items: <String>['cliente', 'venda', 'oculos']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream:
                    buscaController.buscar(_searchController.text, _tipoBusca),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro: ${snapshot.error}'),
                    );
                  }
                  // Exibir os resultados da busca
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data![index];
                      switch (_tipoBusca) {
                        case 'cliente':
                          return ListTile(
                            title: Text(data['nome']),
                            subtitle: Text(data['rg']),
                          );
                        case 'venda':
                          return ListTile(
                            title: Text(data['nota_fiscal']),
                            subtitle: Text(data['preco_venda']),
                          );
                        case 'oculos':
                          return ListTile(
                            title: Text(data['codigo']),
                            subtitle: Text(data['marca']),
                          );
                        default:
                          return SizedBox.shrink();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
