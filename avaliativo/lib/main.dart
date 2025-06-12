import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'delivery.dart';


void main() {

  runApp(MaterialApp(
    home: DeliveryApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class DeliveryApp extends StatefulWidget {
  @override
  State<DeliveryApp> createState() => _DeliveryAppState();
}

class _DeliveryAppState extends State<DeliveryApp> {
  final DBHelper dbHelper = DBHelper();
  List<Delivery> deliveries = [];

  @override
  void initState() {
    super.initState();
    loadDeliveries();
  }

  Future<void> loadDeliveries() async {
    final data = await dbHelper.getDeliveries();
    setState(() {
      deliveries = data;
    });
  }

  void openForm({Delivery? delivery}) {
    final nomeController =
        TextEditingController(text: delivery?.nomeDestinatario ?? '');
    final enderecoController =
        TextEditingController(text: delivery?.endereco ?? '');
    final descricaoController =
        TextEditingController(text: delivery?.descricao ?? '');
    final statusController =
        TextEditingController(text: delivery?.status ?? '');

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nomeController,
                      decoration:
                          InputDecoration(labelText: 'Nome do Destinatário'),
                    ),
                    TextField(
                      controller: enderecoController,
                      decoration: InputDecoration(labelText: 'Endereço'),
                    ),
                    TextField(
                      controller: descricaoController,
                      decoration: InputDecoration(labelText: 'Descrição'),
                    ),
                    TextField(
                      controller: statusController,
                      decoration: InputDecoration(labelText: 'Status'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (delivery == null) {
                          await dbHelper.insertDelivery(Delivery(
                            nomeDestinatario: nomeController.text,
                            endereco: enderecoController.text,
                            descricao: descricaoController.text,
                            status: statusController.text,
                          ));
                        } else {
                          await dbHelper.updateDelivery(Delivery(
                            id: delivery.id,
                            nomeDestinatario: nomeController.text,
                            endereco: enderecoController.text,
                            descricao: descricaoController.text,
                            status: statusController.text,
                          ));
                        }
                        Navigator.of(context).pop();
                        loadDeliveries();
                      },
                      child: Text(delivery == null ? 'Adicionar' : 'Atualizar'),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de Entregas'),
      ),
      body: ListView.builder(
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          final item = deliveries[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(item.nomeDestinatario),
              subtitle: Text(
                  '${item.endereco}\n${item.descricao}\nStatus: ${item.status}'),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => openForm(delivery: item),
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await dbHelper.deleteDelivery(item.id!);
                        loadDeliveries();
                      },
                      icon: Icon(Icons.delete, color: Colors.red)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}