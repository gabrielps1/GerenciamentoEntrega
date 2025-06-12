📦 App de Gerenciamento de Entregas - Flutter + SQLite
Este é um aplicativo Flutter simples para gerenciar entregas de produtos, com banco de dados local utilizando SQLite. O objetivo é permitir o controle de entregas através das operações básicas de CRUD (Criar, Ler, Atualizar e Deletar).

🧱 Funcionalidades
📋 Listar entregas cadastradas.

➕ Adicionar nova entrega com informações do destinatário, endereço, descrição e status.

📝 Editar entrega existente.

🗑️ Excluir entrega do banco de dados.

🗃️ Estrutura do Banco de Dados (SQLite)
A aplicação utiliza uma tabela chamada entregas com os seguintes campos:

| Campo               | Tipo    | Descrição                        |
| ------------------- | ------- | -------------------------------- |
| `id_entrega`        | INTEGER | Identificador único da entrega   |
| `nome_destinatario` | TEXT    | Nome do destinatário da entrega  |
| `endereco`          | TEXT    | Endereço de destino              |
| `descricao`         | TEXT    | Descrição do produto entregue    |
| `status`            | TEXT    | Status da entrega (ex: Pendente) |


🛠️ Tecnologias Utilizadas
Flutter (framework de desenvolvimento mobile)

SQLite (banco de dados local)

sqflite (plugin Flutter para SQLite)

path_provider (para localizar diretórios no dispositivo)
