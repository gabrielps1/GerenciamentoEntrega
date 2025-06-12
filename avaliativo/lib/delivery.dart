class Delivery {
  int? id;
  String nomeDestinatario;
  String endereco;
  String descricao;
  String status;

  Delivery({
    this.id,
    required this.nomeDestinatario,
    required this.endereco,
    required this.descricao,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome_destinatario': nomeDestinatario,
      'endereco': endereco,
      'descricao': descricao,
      'status': status,
    };
    if (id != null) {
      map['id_entrega'] = id;
    }
    return map;
  }

  factory Delivery.fromMap(Map<String, dynamic> map) {
    return Delivery(
      id: map['id_entrega'],
      nomeDestinatario: map['nome_destinatario'],
      endereco: map['endereco'],
      descricao: map['descricao'],
      status: map['status'],
    );
  }
}