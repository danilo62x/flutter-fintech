# Flutter Wallet

> Carteira e banco digital em Flutter

[![Licença: MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-blue.svg)](./LICENSE) ![Grátis](https://img.shields.io/badge/pre%C3%A7o-Gr%C3%A1tis-brightgreen)

Carteira/banco digital em Flutter 3.44 + Material 3, com 8 telas e tema claro/escuro: carteira com cartão de saldo e ações rápidas; transações com filtros; cartões com limite e fatura; enviar Pix com teclado numérico; receber com QR Code desenhado em CustomPaint; extrato com gráfico donut de gastos; adicionar cartão com preview ao vivo; e perfil/segurança. Arquitetura em camadas com MVVM, go_router, intl para moeda.

## 🧱 Stack

- Flutter 3.44
- Dart 3
- Material 3
- go_router
- provider
- intl

## ✨ Recursos

- Flutter 3.44 (último stable) via FVM
- Material 3 com tema claro e escuro
- Arquitetura em camadas (data/domain/ui) + MVVM
- Navegação declarativa com go_router
- Modelos com JSON (fromJson/toJson) + serviço http
- Cartão com saldo, ações rápidas e extrato
- Layout responsivo (mobile, tablet, desktop)
- Android · iOS · Web · Windows + testes de widget

## 🖥️ Telas

![Carteira](screenshots/fintech.png)
![Transações](screenshots/fintech-2.png)
![Cartões](screenshots/fintech-3.png)
![Enviar Pix](screenshots/fintech-4.png)
![Receber Pix](screenshots/fintech-5.png)
![Extrato](screenshots/fintech-6.png)

## 🚀 Como rodar

Requer o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (canal stable).

```bash
flutter pub get
flutter run
```

Para rodar na web: `flutter run -d chrome`. Para gerar o APK: `flutter build apk`.

## ❤️ Apoie o projeto

Curtiu e quer ajudar a manter os templates gratuitos? Faça uma doação (escolha o valor e a forma de pagamento):

**➡️ https://template.dev.br/doar?template=flutter-fintech**

## 🔗 Mais templates

Veja o catálogo completo (grátis e premium) em **https://template.dev.br**

## 📄 Licença

[MIT](./LICENSE) © 2026 Danilo Quinelato
