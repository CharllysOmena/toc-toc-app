# AGENTS.md — Guia Técnico do Projeto

> Documento base para desenvolvimento neste repositório. Use como fonte de verdade
> para arquitetura, padrões e convenções.

## 1. Visão Geral

Toc Toc — App Flutter genérico scaffold para validação de arquitetura. Home placeholder sem integração backend, servindo como base para features futuras com fluxo UDF e camadas bem definidas.

- **Nome:** Toc Toc
- **Plataformas:** Android e iOS
- **Framework:** Flutter `3.47.2` (stable) + Dart `3.13.2`
- **Estado atual:** em desenvolvimento, sem backend integrado (repositórios fake)

### Regras gerais de trabalho

- **Não adicione comentários ao código** a menos que sejam estritamente necessários.
- Siga as convenções desta documentação; em caso de dúvida, consulte as
  [recomendações oficiais de arquitetura Flutter](https://docs.flutter.dev/app-architecture).
- Rode `flutter analyze` e `flutter test` antes de finalizar qualquer alteração.

## 2. Stack de Dependências

| Biblioteca | Papel |
|---|---|
| `flutter_bloc` | Gerenciamento de estado (padrão BLoC / MVVM) |
| `freezed` + `freezed_annotation` | Geração de modelos imutáveis (eventos, estados, entities) |
| `json_serializable` + `json_annotation` | Serialização JSON de DTOs |
| `get_it` | Injeção de dependência (uso restrito ao composition root) |
| `go_router` | Navegação declarativa |
| `dio` | Cliente HTTP (interceptors, timeout, baseUrl) |
| `flutter_secure_storage` | Armazenamento seguro de credenciais/tokens |
| `intl` | Formatação de datas, números e moeda |
| `path_provider` | Acesso a diretórios do sistema de arquivos |
| `geolocator` | Permissões e captura de localização |
| `mask_text_input_formatter` | Máscaras de campos de formulário |
| `flutter_lints` | Conjunto de lints recomendado pelo time Flutter |

## 3. Arquitetura

Arquitetura em camadas seguindo as recomendações oficiais do Flutter
(UI → lógica → dados), com fluxo de dados unidirecional (UDF).

### 3.1 Camadas

- **UI layer (`presenter/`)** — Widgets "burros" que apenas renderizam estado e
  emitem eventos. Toda interação do usuário vira um evento (command) enviado ao
  ViewModel. Lógica permitida no widget: if simples para mostrar/ocultar, lógica
  de layout, animação e navegação simples.
- **Logic layer (ViewModel / BLoC)** — Encapsula toda a lógica de apresentação.
  Recebe repositórios por **injeção via construtor**, expõe comandos (eventos) e
  estado imutável. Não conhece widgets.
- **Data layer (`data/`)** — Responsável por fontes de dados (API, banco local,
  plugin de plataforma). Contém **repositories** (fonte da verdade) e **services**
  (implementações de acesso, ex.: HTTP, geolocalização).
- **Domain layer (`domain/`, opcional)** — Usada apenas quando há lógica de
  negócio complexa (use cases). Em apps CRUD simples pode ser omitida; se existir,
  entities e contratos (interfaces) vivem aqui.

### 3.2 Padrões obrigatórios

- **Repository pattern** — Uma classe de repositório por tipo de dado. Sempre
  declare a **interface abstrata no domain** e a implementação no data
  (`XRepository` → `XRepositoryImpl`). Isso permite fakes em testes e
  implementações por ambiente (dev/staging/prod).
- **Services com interface** — Serviços de infraestrutura (HTTP, storage, GPS)
  também declaram contrato abstrato e são injetados por ele.
- **UDF (Unidirectional Data Flow)** — Estado flui do data layer → logic → UI.
  Eventos fluem no sentido inverso. O repository é o **único** que muta dados
  (single source of truth).
- **SSOT / UI é função do estado** — Widgets nunca mantêm cópia duplicada de
  estado (ex.: `TextEditingController`s espelhando estado do BLoC). Forms e
  campos sincronizam a partir do estado; o estado é a única fonte de verdade.
- **Modelos imutáveis com freezed** — **Todos** os modelos (entities, DTOs,
  eventos, estados) são gerados com `freezed` (`copyWith`, `==`, `toString`,
  `toJson` automáticos). Proibido escrever `copyWith`/`==`/`toJson` à mão.
  Nunca classes mutáveis.
- **MVVM** — UI layer separada em ViewModel (BLoC) e View (widgets). Widgets não
  contêm lógica de negócio.
- **DTOs separados de domain models** (quando houver API) — Modelos de resposta
  da API (`data/models/*.dto.dart`) convertidos para entities do domínio. Nunca
  vazar DTO para a UI.

### 3.3 Injeção de Dependência (GetIt)

- `GetIt` é usado **apenas no composition root** (`app_module.dart`), nunca dentro
  de widgets ou no meio da árvore de widgets.
- Widgets recebem dependências via **construtor** ou `BlocProvider`.
- Acesso a `GetIt.I<T>()` é permitido somente em:
  1. `setupDependencies()` (registro de bindings);
  2. builders de rotas (`app_module.dart` / módulos de feature) para instanciar
     blocs com `registerFactory`.
- Escopos de registro:
  - `registerLazySingleton` → serviços e repositórios (estado global);
  - `registerFactory` → blocs (novo a cada acesso, vida atrelada ao widget).
- Cada feature expõe seu próprio módulo de DI (`*_module.dart` com
  `XxxDependencies.register(getIt)`), registrado no `setupDependencies`.

### 3.4 Regras de camadas (alinhadas à doc oficial do Flutter)

As camadas só se comunicam com a camada imediatamente abaixo/acima. A UI não
deve saber que a data layer existe, e vice-versa.

- **`domain/` é Dart puro** — Proibido importar `package:flutter/*`, plugins de
  plataforma (camera, geolocator, etc.), `data/` ou `presenter/`. Interfaces de
  repositório e entities usam apenas tipos do Dart SDK.
- **`data/` importa somente `domain/`** — Implementa os contratos
  (`XRepositoryImpl implements XRepository`). Nunca importa `presenter/`
  (utils de apresentação não pertencem ao data layer).
- **`presenter/` importa `domain/` e `data/`** — A direção da dependência aponta
  sempre para baixo; nenhuma camada importa quem está acima dela.
- **Inversão de dependência** — Blocs/ViewModels dependem das interfaces
  (`domain/`), nunca das implementações concretas; as implementações são
  injetadas via DI no composition root.
- **Por que**: `domain` limpo permite testar lógica sem plugins e trocar
  implementações por ambiente (dev/staging/prod) sem tocar em consumidores.
  Referência: [recomendações de arquitetura](https://docs.flutter.dev/app-architecture/recommendations).

## 4. Estrutura de Pastas

```
lib/
├── main.dart                  # Bootstrap: binding, orientação, DI, router, runApp
├── app_module.dart            # Composition root: GetIt global + rotas raiz
├── app_widget.dart            # Widget raiz (MaterialApp, theming, wrappers globais)
├── data/                      # Data layer
│   ├── models/                # DTOs (json_serializable)
│   ├── repositories/          # Implementações concretas (*Impl)
│   └── services/              # Implementações de serviços (http, storage, gps)
├── domain/                    # Domain layer (opcional)
│   ├── entities/              # Modelos de domínio (freezed)
│   ├── repositories/          # Interfaces abstratas de repositório
│   └── usecases/              # Use cases (apenas se necessário)
└── presenter/                 # UI layer (1 pasta por feature) — feature-first
    ├── <feature>/
    │   ├── bloc/              # *_bloc.dart, *_event.dart, *_state.dart (+ *.freezed.dart)
    │   ├── pages/             # Tela principal da feature
    │   ├── widgets/           # Widgets específicos da feature
    │   └── <feature>_module.dart  # DI + rotas da feature
    ├── shared/                # Código compartilhado entre features
    │   ├── themes.dart / colors.dart
    │   ├── masks.dart
    │   └── widgets/           # Widgets reutilizáveis (core)
    └── <outra_feature>/...
```

- **Organização por feature** dentro da UI layer: tudo de uma feature fica junto.
- Componentes compartilhados vão em `presenter/shared/`.
- Decisão do projeto: **feature-first** na UI layer, **layer-first** em `data/` e `domain/`.

## 5. Navegação (go_router)

- Rotas declarativas, agrupadas por feature (`XxxRoutes.routes`), combinadas no
  `AppRouter` central.
- **Passagem de dados entre telas**: `state.extra` com tipos concretos (nunca
  `Map<String, dynamic>` solto); crie um tipo/record para agrupar parâmetros.
- **Estado compartilhado entre telas de um mesmo fluxo**: `ShellRoute` com um
  `BlocProvider` no builder — todas as telas filhas consomem o mesmo BLoC.
- **Blocs por rota**: crie/obtenha o BLoC no builder da rota e injete via
  `BlocProvider`. Invoque o evento de inicialização no próprio builder
  (`..add(XxxEvent.init(...))`).
- Navegação após operações assíncronas deve usar `context.mounted` antes de
  acessar `context` (lint `use_build_context_synchronously`).

## 6. Gerenciamento de Estado (BLoC)

- Padrão: `class XxxBloc extends Bloc<XxxEvent, XxxState>`.
- **Eventos e estados com freezed** (sealed classes): estados imutáveis com
  variantes (`initial`, `loading`, `ready`, `error`), eventos com payloads tipados.
- Um handler único por bloc: `on<XxxEvent>((event, emit) => event.when(...))`
  delegando a métodos privados `_onXxx`.
- Regras:
  - Emitir sempre um estado **novo e imutável** (nunca mutar `state`);
  - Usar `copyWith`/`maybeMap`/`when` — nunca `is` + cast manual;
  - Recurso de câmera/streams/controllers: liberar no `close()` do bloc;
  - Bloc não conhece widgets, não recebe `BuildContext`;
  - UI consome com `BlocBuilder`/`BlocConsumer`/`BlocListener` e reage a estados.

## 7. Convenções de Código

- **Naming oficial** (recomendado pelo Flutter):
  - Tela: `XxxScreen` (ou `XxxPage`);
  - ViewModel: `XxxViewModel` (ou `XxxBloc` quando usado BLoC);
  - Repositório: `XxxRepository` (abstrato) / `XxxRepositoryImpl` (concreto);
  - Serviço: `XxxService` (abstrato) / `XxxApiService`, `XxxHttpClient`;
  - DTO: `XxxDto` (em `data/models/`);
  - Evitar nomes que colidam com classes do SDK Flutter (ex.: `Client`,
    `Controller`, `View` genéricos — sempre prefixar com o domínio da feature).
- **Arquivos**: snake_case (`login_bloc.dart`, `scheduling_page.dart`); classes
  PascalCase; constantes uppercase_snake.
- **Imutabilidade**: campos `final`, construtor `const` quando possível.
- **Widgets**: `const` sempre que possível; `StatelessWidget` por padrão,
  `StatefulWidget` apenas para estado efêmero local (controllers, focus).
- **Sem lógica de negócio em widgets**: delegate ao BLoC/ViewModel.
- **`GetIt.I<T>()` proibido em widgets** — acesso permitido apenas no
  `setupDependencies()` e nos builders de rota (`*_module.dart`).
- **Async gaps**: após `await`, verificar `context.mounted` antes de usar
  `context` (lint `use_build_context_synchronously`).
- **Regras de dependência**:
  - `presenter` pode importar `data` e `domain`; `domain` **não** importa
    `flutter`/`data`/`presenter`;
  - `data` importa `domain` (implementa contratos), nunca `presenter`;
  - imports relativos dentro da mesma feature; caminho completo (`package:`) para
    cruzar camadas.
- **Mensagens de commit**: a critério do time (Conventional Commits recomendado).
- **Código gerado** (`*.freezed.dart`, `*.g.dart`): versionado, não editar à mão.

## 8. Codegen (build_runner)

Sempre que alterar modelos freezed/json:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Após o codegen, rode `flutter analyze` — arquivos gerados desatualizados causam
erros de compilação silenciosos.

## 9. Testes

**Obrigatório** — novas features devem incluir testes (recomendação oficial:
"Strongly recommend" testar componentes separadamente e em conjunto):

- **Unit tests** para **cada** bloc, repository e service (lógica método a
  método), usando **fakes** das interfaces abstratas (nunca mocks de classes
  concretas). Fakes exigem interfaces enxutas com entradas/saídas bem definidas.
- **Widget tests** para as views: renderização por estado, eventos emitidos,
  navegação entre telas e **resolução de DI** (particularmente importante).
- Blocs devem ser testáveis sem plugins de plataforma (injetar fakes).
- Fakes vivem em `test/helpers/` ou `test/fakes/`.

```bash
flutter test
```

## 10. Análise Estática (lints)

- Base: `package:flutter_lints/flutter.yaml` (lints recomendados pelo time
  Flutter) via `analysis_options.yaml`.
- Regras adicionais ativas:
  `use_build_context_synchronously`, `prefer_const_constructors`,
  `prefer_single_quotes`, `unnecessary_this`, `discarded_futures`.
- No CI, rodar `flutter analyze --fatal-infos` — o pipeline falha se houver
  qualquer info/warning (nunca desabilitar lint individual sem justificativa
  comentada).

## 11. CI/CD

Não configurado no momento. Quando existir, pipeline mínimo recomendado para cada push/PR:

1. `flutter pub get`
2. `dart run build_runner build --delete-conflicting-outputs`
3. `flutter analyze --fatal-infos`
4. `flutter test`

## 12. Configuração por Ambiente

- Ambientes: `dev` via `--dart-define=ENV=dev` (staging/prod previstos, sem backend no momento).
- `Dio` configurado com `baseUrl`, `timeout` e **interceptors** (auth, logging,
  erros) no composition root — nunca `Dio()` cru no meio do código.
- Credenciais e tokens nunca em código: `flutter_secure_storage` + variáveis de
  ambiente.
- Implementações de repositório por ambiente (fake em dev, real quando houver backend)
  selecionadas no `setupDependencies`.

## 13. Plataforma

- **Permissões**: declarar apenas as necessárias em
  `android/app/src/main/AndroidManifest.xml` e `ios/Runner/Info.plist`
  (câmera, localização, etc.), com strings de uso em português.
- **Assets**: declarados em `pubspec.yaml` (imagens, fontes, modelos).
- **Versão/versionName**: `pubspec.yaml` (`version: X.Y.Z+build`).
- `minSdk`/`targetSdk`, assinatura de release e Firebase a definir quando necessário.

## 14. Checklist — Adicionar Nova Feature

1. Definir entities de domínio (freezed) em `domain/entities/`;
2. Declarar interface do repositório em `domain/repositories/`;
3. Implementar em `data/repositories/` (e `data/services/` se houver acesso externo);
4. DTOs + mapeamento, se houver API;
5. Criar `bloc/` (`*_event.dart`, `*_state.dart`, `*_bloc.dart` via freezed);
6. Criar `pages/` e `widgets/` da feature (UI burra, consome bloc);
7. Registrar DI + rotas no `*_module.dart` da feature e importar no `app_module.dart`;
8. Escrever testes (unit do bloc/repository + widget das telas);
9. Rodar `build_runner`, `flutter analyze` e `flutter test`.

## 15. Comandos Úteis

```bash
flutter pub get                                  # instalar dependências
dart run build_runner build --delete-conflicting-outputs  # codegen
flutter analyze                                  # análise estática
flutter test                                     # testes
flutter run --dart-define=ENV=dev                # executar com ambiente
```

## 16. Gaps e Pendências Conhecidas

- Sem backend integrado — repositórios em modo fake
- Sem pipeline CI/CD
- Sem configuração de flavors/signing de release
- Feature `home` genérica como scaffold inicial (placeholder)
- Permissões de plataforma (câmera/localização) ainda não declaradas

Ao iniciar um novo projeto a partir deste template, validar conformidade com a
[doc oficial de arquitetura](https://docs.flutter.dev/app-architecture/recommendations):

- [ ] Camadas definidas (UI + Data; Domain apenas se houver lógica complexa)
- [ ] Repository pattern com interfaces abstratas em `domain/`
- [ ] Services com contratos abstratos
- [ ] `domain/` puro (sem `flutter`/plugins)
- [ ] Modelos todos via freezed (sem `copyWith`/`==` manuais)
- [ ] `GetIt` apenas no composition root
- [ ] Testes (unit por camada + widget) com fakes
- [ ] `flutter analyze --fatal-infos` limpo
- [ ] Dio configurado (baseUrl, interceptors) no composition root
