import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_widgets.dart';
import '../view_models/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth =
                constraints.maxWidth >= 720 ? 560 : constraints.maxWidth;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                  children: <Widget>[
                    _ProfileHeader(vm: vm),
                    const SizedBox(height: 22),
                    _Section(
                      title: 'Conta',
                      children: <Widget>[
                        SettingsNavTile(
                          icon: Icons.person_outline,
                          title: 'Dados pessoais',
                          subtitle: 'Nome, CPF e contato',
                        ),
                        SettingsNavTile(
                          icon: Icons.key_outlined,
                          title: 'Minhas chaves Pix',
                          subtitle: '3 chaves cadastradas',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: 'Segurança',
                      children: <Widget>[
                        SettingsSwitchTile(
                          icon: Icons.fingerprint,
                          title: 'Biometria',
                          subtitle: 'Desbloqueio por digital',
                          value: vm.biometrics,
                          onChanged: vm.setBiometrics,
                        ),
                        SettingsNavTile(
                          icon: Icons.password_outlined,
                          title: 'Alterar senha',
                          subtitle: 'Última troca há 3 meses',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: 'Notificações',
                      children: <Widget>[
                        SettingsSwitchTile(
                          icon: Icons.notifications_none,
                          title: 'Push',
                          subtitle: 'Alertas de transações',
                          value: vm.notifications,
                          onChanged: vm.setNotifications,
                        ),
                        SettingsSwitchTile(
                          icon: Icons.mail_outline,
                          title: 'E-mail',
                          subtitle: 'Resumo semanal',
                          value: vm.emailAlerts,
                          onChanged: vm.setEmailAlerts,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: 'Preferências',
                      children: <Widget>[
                        SettingsSwitchTile(
                          icon: Icons.dark_mode_outlined,
                          title: 'Tema escuro',
                          subtitle: 'Seguir o sistema',
                          value: vm.darkMode,
                          onChanged: vm.setDarkMode,
                        ),
                        SettingsNavTile(
                          icon: Icons.language,
                          title: 'Idioma',
                          subtitle: 'Português (Brasil)',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: const Text('Sair da conta'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.vm});

  final ProfileViewModel vm;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primary,
            Color.alphaBlend(
              scheme.tertiary.withValues(alpha: 0.55),
              scheme.primary,
            ),
          ],
        ),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white.withValues(alpha: 0.22),
            child: Text(
              vm.initials,
              style: textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  vm.name,
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  vm.email,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.star, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        vm.plan,
                        style: textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: textTheme.labelLarge?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
