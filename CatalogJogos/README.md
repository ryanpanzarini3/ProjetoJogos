# CatalogJogos - Flutter Project

Projeto de catálogo de jogos desenvolvido como atividade avaliativa.

## Estrutura do Projeto (Clean Architecture)

A estrutura segue os princípios da Clean Architecture, dividida por features:

- `lib/core`: Componentes compartilhados, utilitários, tratamento de erros e configuração de API.
- `lib/features/`: Cada funcionalidade do sistema (jogos, favoritos, configurações).
  - `data/`: Repositórios (implementação), fontes de dados (API/Local) e models.
  - `domain/`: Entidades e interfaces de repositórios.
  - `presentation/`: Telas (pages), widgets e providers (Riverpod).

## Atribuições da Equipe

- **Membro 1 — Arquitetura & API**: Configuração base, Dio, Models, Repositories API e Providers principais.
- **Membro 2 — Telas principais**: Listagem de jogos, Detalhes e GoRouter.
- **Membro 3 — Persistência local**: SQLite para favoritos e integração na tela de detalhes.
- **Membro 4 — Configurações & SharedPreferences**: Tema, idioma e persistência de preferências.
- **Membro 5 — Testes**: Testes unitários, de widget e de integração.

## Dependências Principais

- **Riverpod**: Gerenciamento de estado.
- **GoRouter**: Navegação.
- **Dio**: Consumo de API.
- **SQLite (sqflite)**: Persistência local estruturada.
- **SharedPreferences**: Persistência de configurações simples.
- **Freezed / JSON Serializable**: Geração de código para models.

## Como começar

1. Execute `flutter pub get` para instalar as dependências.
2. Execute `flutter pub run build_runner build` para gerar os arquivos automáticos.
