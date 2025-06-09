import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/init/lang/app_localizations.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';

class ShellScreen extends StatefulWidget {
  final Widget child;

  const ShellScreen({
    super.key,
    required this.child,
  });

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    _homeBloc.add(LoadMovies());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    return BlocProvider.value(
      value: _homeBloc,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: widget.child,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.onSurface.withAlpha((0.1 * 255).round()),
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              color: theme.colorScheme.surface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context: context,
                    icon: 'assets/icons/home.svg',
                    label: localizations.translate('home'),
                    path: '/home',
                    index: 0,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: 'assets/icons/profilshell.svg',
                    label: localizations.translate('profile'),
                    path: '/profile',
                    index: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String icon,
    required String label,
    required String path,
    required int index,
  }) {
    final isSelected = _isSelected(context, path);
    final theme = Theme.of(context);
    final color = isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface;

    return GestureDetector(
      onTap: () => _onItemTapped(index, context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.colorScheme.onSurface.withAlpha((0.1 * 255).round()),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withAlpha((0.2 * 255).round()),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSelected(BuildContext context, String path) {
    final location = GoRouterState.of(context).uri.path;
    return location.startsWith(path);
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/profile');
        break;
    }
  }
} 