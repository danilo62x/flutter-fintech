# Flutter Wallet

[Read in English](./README.md)

[![Licença: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE) ![Grátis](https://img.shields.io/badge/price-free-brightgreen)

Flutter Wallet é um template gratuito de carteira e banco digital construído com Flutter 3.44 e Material 3. São 8 telas com tema claro e escuro: home da carteira com cartão de saldo e ações rápidas, lista de transações com filtros, gestão de cartão com limite e fatura, fluxo de envio de Pix com teclado numérico próprio, tela de recebimento com QR Code desenhado em CustomPaint, extrato com gráfico donut de gastos por categoria, formulário de adicionar cartão com preview ao vivo e perfil com opções de segurança. Todos os dados são mocks locais, então o app roda sem backend, e os serviços http indicam onde uma API real entraria. Faz parte da faixa gratuita do catálogo [template.dev.br](https://template.dev.br).

## Telas

8 telas mais um shell com navegação inferior (`lib/ui/features/shell/home_shell.dart`):

- Carteira (`wallet_screen.dart`): cartão de saldo, ações rápidas e atividade recente.
- Transações (`transactions_screen.dart`): histórico completo de transações com filtros.
- Cartões (`card_detail_screen.dart`): detalhe do cartão de crédito com limite e fatura.
- Enviar Pix (`send_screen.dart`): fluxo de transferência com seleção de contato e teclado numérico.
- Receber Pix (`receive_screen.dart`): QR Code renderizado por um painter de CustomPaint (`qr_painter.dart`).
- Extrato (`statement_screen.dart`): gastos por categoria em gráfico donut (`donut_chart.dart`).
- Adicionar cartão (`add_card_screen.dart`): formulário de cartão com preview ao vivo.
- Perfil (`profile_screen.dart`): dados da conta e opções de segurança.

### Capturas de tela

A pasta `screenshots/` tem 16 capturas. Uma amostra:

![Carteira](screenshots/fintech.png)
![Transações](screenshots/fintech-2.png)
![Cartões](screenshots/fintech-3.png)
![Enviar Pix](screenshots/fintech-4.png)
![Receber Pix](screenshots/fintech-5.png)
![Extrato](screenshots/fintech-6.png)

## Stack

- Flutter 3.44, canal stable (fixado via FVM no `.fvmrc`)
- Dart SDK `^3.12.2`
- Material 3 (`useMaterial3: true`, `ColorScheme.fromSeed`)
- go_router `^17.3.0`: navegação declarativa
- provider `^6.1.5+1`: gerenciamento de estado (view models MVVM)
- http `^1.6.0`: camada de serviços de API
- intl `^0.20.3`: formatação de moeda e datas
- cupertino_icons `^1.0.8`
- flutter_lints `^6.0.0` (dev)

As versões exatas resolvidas estão no `pubspec.lock`. Plataformas incluídas no repositório: Android, iOS, web e Windows.

## Requisitos

- Flutter SDK, canal stable. O lockfile exige Flutter 3.38 ou mais novo; o template foi construído com a 3.44.
- Dart 3.12.2 ou mais novo (vem junto com o Flutter SDK).
- Ferramentas da plataforma alvo: Android Studio e Android SDK, Xcode para iOS, Chrome para web, ou Visual Studio com o workload de C++ para Windows.
- Opcional: [FVM](https://fvm.app). O repositório tem um `.fvmrc` fixando o canal stable, então `fvm use` seleciona um SDK compatível.

## Como rodar

```bash
flutter pub get
flutter run
```

Escolha o dispositivo com `flutter run -d chrome` (web), `flutter run -d windows`, ou um id listado em `flutter devices`.

Builds de release:

```bash
flutter build apk       # Android
flutter build ipa       # iOS (exige macOS e Xcode)
flutter build web       # Web
flutter build windows   # Windows
```

Com FVM, prefixe os comandos: `fvm flutter pub get`, `fvm flutter run`. Rode os testes de widget com `flutter test`.

## Estrutura do projeto

```
lib/
  main.dart              # ponto de entrada
  app.dart               # MaterialApp.router, temas claro/escuro
  core/
    router.dart          # tabela de rotas do go_router
    theme.dart           # tema Material 3 (cor seed, temas de componentes)
  data/
    models/              # modelos de API com fromJson/toJson
    repositories/        # carteira, cartões, contatos, extrato (dados mock)
    services/            # stubs de serviço de API com http
  domain/
    models/              # Transaction, PaymentCard, Contact, CategorySpend
  ui/
    core/widgets/        # widgets compartilhados, gráfico donut, painter de QR
    features/<feature>/  # views/ (telas) e view_models/ por funcionalidade
```

## Tema e personalização

O tema fica em `lib/core/theme.dart`. Os esquemas claro e escuro são gerados a partir de uma única cor seed:

```dart
static const Color seed = Color(0xFF3B2FB0); // indigo/violeta
```

Troque `seed` para mudar a cara do app inteiro: `ColorScheme.fromSeed` deriva todas as cores de superfície e destaque para os dois brilhos. A família de fonte é Roboto, definida no mesmo arquivo, junto com temas de componentes para app bar, botões preenchidos e cards (cantos arredondados, elevação zero). O `app.dart` passa `AppTheme.light()` e `AppTheme.dark()` para o `MaterialApp.router`, então o app segue o tema do sistema. Valores e datas são formatados com `intl`.

## Gerenciamento de estado

MVVM com provider. Cada tela tem um view model `ChangeNotifier` em `lib/ui/features/<feature>/view_models/`, criado com `ChangeNotifierProvider` nas definições de rota em `lib/core/router.dart`. Os view models leem dos repositórios em `lib/data/repositories/`, que retornam dados mock através dos serviços em `lib/data/services/`.

## Apoie o projeto

Este template é gratuito e tem licença MIT. As doações mantêm os templates gratuitos atualizados a cada versão nova do Flutter: https://template.dev.br/doar?template=flutter-fintech

## Mais templates

O catálogo completo, com templates grátis e premium, está em https://template.dev.br.

## Licença

[MIT](./LICENSE), © 2026 Danilo Quinelato.
