import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/core/base/base_state.dart';
import 'package:movie_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:movie_app/features/profile/presentation/widgets/limited_offer_bottom_sheet.dart';
import 'package:movie_app/core/extensions/string_extensions.dart';
import 'package:movie_app/core/init/lang/localization_cubit.dart';
import 'package:movie_app/core/init/lang/app_localizations.dart';
import 'package:movie_app/core/init/theme/theme_cubit.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final bool shouldRefresh;
  
  const ProfileScreen({
    super.key,
    this.shouldRefresh = false,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    _profileBloc.add(LoadProfile());

    if (widget.shouldRefresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _profileBloc.add(LoadProfile());
      });
    }
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  void _showLimitedOfferBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const LimitedOfferBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    return BlocProvider.value(
      value: _profileBloc,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surface,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withAlpha((0.25 * 255).round()),
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.onSurface.withAlpha((0.2 * 255).round()),
                width: 0.5,
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
              onPressed: () => context.go('/home'),
            ),
          ),
          title: Text(
            localizations.translate('profile'),
            style: theme.textTheme.titleLarge,
          ),
          centerTitle: false,
          actions: [
            const SizedBox(width: 48),
            TextButton.icon(
              onPressed: () => _showLimitedOfferBottomSheet(context),
              style: TextButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              icon: SvgPicture.asset(
                'assets/icons/diamon.svg',
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
                width: 16,
                height: 16,
              ),
              label: Text(
                localizations.translate('limitedOffer'),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              );
            }

            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _profileBloc.add(LoadProfile()),
                      child: Text(localizations.translate('retry')),
                    ),
                  ],
                ),
              );
            }

            if (state is ProfileLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile Header
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.surface,
                            image: state.user.photoUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(state.user.photoUrl!.fixImageUrl),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: state.user.photoUrl == null
                              ? Icon(
                                  Icons.person,
                                  color: theme.colorScheme.onSurface.withAlpha((0.5 * 255).round()),
                                  size: 40,
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.name,
                                style: theme.textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.user.email,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/add-photo');
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            localizations.translate('addProfilePhoto'),
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Favorite Movies Section
                    Row(
                      children: [
                        Text(
                          localizations.translate('favorites'),
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (state.favoriteMovies.isEmpty)
                      Center(
                        child: Text(
                          localizations.translate('noFavorites'),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                          ),
                        ),
                      )
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: state.favoriteMovies.length,
                        itemBuilder: (context, index) {
                          final movie = state.favoriteMovies[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: movie.posterUrl?.fixImageUrl ?? 'https://picsum.photos/300/450',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: theme.colorScheme.surface,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        color: theme.colorScheme.surface,
                                        child: Center(
                                          child: Icon(
                                            Icons.broken_image_outlined,
                                            color: theme.colorScheme.onSurface.withAlpha((0.5 * 255).round()),
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.title ?? '',
                                style: theme.textTheme.titleSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                movie.genre ?? '',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          );
                        },
                      ),
                    // Language Switch
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.language,
                          color: theme.colorScheme.onSurface,
                        ),
                        title: Text(
                          localizations.translate('language'),
                          style: theme.textTheme.titleMedium,
                        ),
                        trailing: BlocBuilder<LocalizationCubit, Locale>(
                          builder: (context, locale) {
                            final isTurkish = locale.languageCode == 'tr';
                            return Switch(
                              value: isTurkish,
                              onChanged: (value) {
                                context.read<LocalizationCubit>().changeLocale(
                                  value ? 'tr' : 'en',
                                );
                              },
                              activeColor: theme.colorScheme.primary,
                            );
                          },
                        ),
                      ),
                    ),
                    // Theme Switch
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.dark_mode,
                          color: theme.colorScheme.onSurface,
                        ),
                        title: Text(
                          localizations.translate('darkMode'),
                          style: theme.textTheme.titleMedium,
                        ),
                        trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, themeMode) {
                            final isDark = themeMode == ThemeMode.dark;
                            return Switch(
                              value: isDark,
                              onChanged: (value) {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                              activeColor: theme.colorScheme.primary,
                            );
                          },
                        ),
                      ),
                    ),
                    
                    // Logout Button
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: theme.colorScheme.error,
                        ),
                        title: Text(
                          localizations.translate('logout'),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(localizations.translate('logoutConfirmation')),
                              content: Text(localizations.translate('logoutConfirmationMessage')),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(localizations.translate('cancel')),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context.read<AuthBloc>().add(SignOutRequested());
                                    context.go('/login');
                                  },
                                  child: Text(
                                    localizations.translate('logout'),
                                    style: TextStyle(color: theme.colorScheme.error),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
} 