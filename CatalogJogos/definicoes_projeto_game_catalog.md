# Definições do Projeto Game Catalog

## Visão Geral
Aplicativo Flutter para catálogo de jogos utilizando:
- Clean Architecture
- Riverpod (gerenciamento de estado)
- GoRouter (navegação)
- Dio (requisições HTTP)
- RAWG API (dados de jogos)
- SQLite (persistência local)
- SharedPreferences (configurações)
- Testes unitários, de widget e integração

---

# Membro 1 — Arquitetura & API

## Responsabilidades
- Estruturar o projeto em Clean Architecture.
- Configurar dependências do projeto.
- Integrar a API RAWG.
- Criar Models com json_serializable.
- Implementar DataSources e Repositories.
- Configurar Riverpod.

## Arquivos Principais
- dio_client.dart
- exceptions.dart
- game_model.dart
- game_remote_datasource.dart
- game_repository_impl.dart
- game_entity.dart
- game_repository.dart
- games_provider.dart

## Conceitos
### Model
Representação dos dados vindos da API.

### Entity
Representação da regra de negócio da aplicação.

### DataSource
Camada responsável por buscar dados externos.

### Repository
Abstração entre domínio e fonte de dados.

### Provider
Responsável por disponibilizar estados e dependências via Riverpod.

Responsável pela base do projeto. Os outros membros dependem do seu trabalho para começar.

  Responsabilidades
•	Criar a estrutura de pastas do projeto (Clean Architecture)
•	Configurar pubspec.yaml com todas as dependências
•	Integrar a API RAWG.io com Dio (ou outra API REST de jogos)
•	Criar os Models com json_serializable (GameModel, GenreModel, etc.)
•	Criar DataSource remoto e Repository da API
•	Configurar Riverpod: ProviderScope no main.dart e providers principais

📁 Estrutura de Arquivos
lib/
core/
network/	→ dio_client.dart
errors/	→ exceptions.dart
features/games/ data/
models/	→ game_model.dart, game_model.g.dart sources/	→ game_remote_datasource.dart repositories/	→ game_repository_impl.dart
domain/
entities/	→ game_entity.dart
repositories/	→ game_repository.dart (abstract)
presentation/
providers/	→ games_provider.dart


💻 Código de Referência
pubspec.yaml — dependências principais
dependencies: flutter_riverpod: ^2.4.0 go_router: ^13.0.0
dio: ^5.4.0 json_annotation: ^4.8.1 sqflite: ^2.3.0 shared_preferences: ^2.2.2 path: ^1.8.3

dev_dependencies: json_serializable: ^6.7.1 build_runner: ^2.4.7 flutter_test:
sdk: flutter integration_test:
sdk: flutter


lib/features/games/data/models/game_model.dart
import 'package:json_annotation/json_annotation.dart'; part 'game_model.g.dart';

@JsonSerializable() class GameModel {
final int id; final String name;
 
final String? backgroundImage; final double? rating;
final String? released;

const GameModel({ required this.id, required this.name, this.backgroundImage, this.rating, this.released,
});

factory GameModel.fromJson(Map<String, dynamic> json) =>
_$GameModelFromJson(json);

Map<String, dynamic> toJson() => _$GameModelToJson(this);
}

lib/features/games/data/sources/game_remote_datasource.dart
class GameRemoteDatasource { final Dio _dio;
static const _apiKey = 'SUA_CHAVE_RAWG'; GameRemoteDatasource(this._dio);
Future<List<GameModel>> getGames({String? search}) async { final response = await _dio.get(
'https://api.rawg.io/api/games', queryParameters: {
'key': _apiKey,
if (search != null) 'search': search, 'page_size': 20,
},
);
final results = response.data['results'] as List;
return results.map((e) => GameModel.fromJson(e)).toList();
}
}

lib/features/games/presentation/providers/games_provider.dart
final gamesProvider = FutureProvider.family<List<GameModel>, String?>( (ref, search) async {
final datasource = ref.read(gameDatasourceProvider); return datasource.getGames(search: search);
},
);

final gameDatasourceProvider = Provider((ref) {
final dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 10))); return GameRemoteDatasource(dio);
});

⚠️ Execute 'flutter pub run build_runner build' após criar os models para gerar os arquivos .g.dart


---

# Membro 2 — Telas & Navegação

## Responsabilidades
- Configurar GoRouter.
- Implementar navegação entre telas.
- Criar listagem de jogos.
- Criar tela de detalhes.
- Criar widgets reutilizáveis.

## Arquivos Principais
- app_router.dart
- game_list_page.dart
- game_detail_page.dart
- game_card.dart
- search_bar_widget.dart

## Conceitos

### GoRouter
Biblioteca de navegação baseada em rotas declarativas.

### Route Parameter
Parâmetro passado pela URL.

Exemplo:
```dart
/game/:id
```

### GameCard
Widget reutilizável para exibir informações de um jogo.

---

# Membro 3 — Favoritos & SQLite

## Responsabilidades
- Configurar banco SQLite.
- Criar CRUD de favoritos.
- Criar providers para favoritos.
- Implementar tela de favoritos.

## Arquivos Principais
- database_helper.dart
- favorite_local_datasource.dart
- favorite_repository.dart
- favorite_repository_impl.dart
- favorites_provider.dart
- favorites_page.dart

## Conceitos

### SQLite
Banco de dados local embarcado no dispositivo.

### DatabaseHelper
Singleton responsável por gerenciar a conexão com o banco.

### CRUD
- Create
- Read
- Update
- Delete

### FavoriteLocalDatasource
Fonte local responsável pelas operações de favoritos.

---

# Membro 4 — Configurações & SharedPreferences

## Responsabilidades
- Persistir tema.
- Aplicar tema dinâmico.
- Criar tela de configurações.
- Salvar preferências do usuário.

## Arquivos Principais
- preferences_service.dart
- theme_provider.dart
- settings_page.dart

## Conceitos

### SharedPreferences
Armazenamento simples baseado em chave e valor.

### ThemeNotifier
Controla o tema da aplicação utilizando Riverpod.

### ThemeMode
Modos disponíveis:
- light
- dark
- system

---

# Membro 5 — Testes

## Responsabilidades
- Criar testes unitários.
- Criar testes de widget.
- Criar testes de integração.
- Garantir estabilidade da aplicação.

## Estrutura
```text
test/
├── unit/
├── widget/
└── integration_test/
```

## Conceitos

### Teste Unitário
Valida uma unidade isolada de código.

### Teste de Widget
Valida comportamento visual e interação.

### Teste de Integração
Valida o fluxo completo da aplicação.

### Mockito
Biblioteca utilizada para mocks.

---

# Dependências

## Produção
- flutter_riverpod
- go_router
- dio
- json_annotation
- sqflite
- shared_preferences
- path

## Desenvolvimento
- json_serializable
- build_runner
- flutter_test
- integration_test

---

# Comandos Importantes

## Instalação
```bash
flutter pub get
```

## Gerar arquivos .g.dart
```bash
flutter pub run build_runner build
```

## Executar testes
```bash
flutter test
```

## Executar apenas testes unitários
```bash
flutter test test/unit/
```

## Executar testes de widget
```bash
flutter test test/widget/
```

## Executar teste de integração
```bash
flutter test integration_test/app_flow_test.dart
```

---

# Estrutura Geral do Projeto

```text
lib/
├── core/
│   ├── network/
│   ├── database/
│   ├── preferences/
│   └── router/
├── features/
│   ├── games/
│   ├── favorites/
│   └── settings/
└── main.dart
```

# Regras Importantes

1. Utilizar Clean Architecture.
2. Utilizar Riverpod para gerenciamento de estado.
3. Utilizar GoRouter para navegação.
4. Utilizar SQLite para favoritos.
5. Utilizar SharedPreferences para configurações.
6. Gerar arquivos .g.dart com build_runner.
7. Manter responsabilidades separadas por feature.
8. Garantir cobertura mínima dos testes especificados.
