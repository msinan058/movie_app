import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/init/lang/app_localizations.dart';
import 'package:movie_app/core/init/lang/localization_cubit.dart';
import 'package:movie_app/core/init/theme/theme_cubit.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:movie_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:movie_app/features/auth/presentation/widgets/social_login_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = _prefs.getBool('remember_me') ?? false;
      if (_rememberMe) {
        _emailController.text = _prefs.getString('remembered_email') ?? '';
      }
    });
  }

  Future<void> _saveRememberMe() async {
    await _prefs.setBool('remember_me', _rememberMe);
    if (_rememberMe) {
      await _prefs.setString('remembered_email', _emailController.text);
    } else {
      await _prefs.remove('remembered_email');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _saveRememberMe();
      context.read<AuthBloc>().add(
            SignInRequested(
              _emailController.text.trim(),
              _passwordController.text.trim(),
              _rememberMe,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: theme.colorScheme.error,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          } else if (state is Authenticated) {
            context.go('/home');
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, themeMode) {
                            return TextButton.icon(
                              onPressed: () {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                              icon: Icon(
                                themeMode == ThemeMode.light 
                                    ? Icons.dark_mode 
                                    : Icons.light_mode,
                              ),
                              label: Text(
                                themeMode == ThemeMode.light
                                    ? 'Dark Mode'
                                    : 'Light Mode',
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {
                            final cubit = context.read<LocalizationCubit>();
                            cubit.changeLocale(cubit.state.languageCode == 'tr' ? 'en' : 'tr');
                          },
                          icon: const Icon(Icons.language),
                          label: Text(localizations.translate('language')),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    localizations.translate('welcomeBack'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    controller: _emailController,
                    hintText: localizations.translate('email'),
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/icons/email.svg',
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.translate('emailRequired');
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return localizations.translate('invalidEmail');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: localizations.translate('password'),
                    obscureText: _obscurePassword,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/icons/lock.svg',
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/hidepass.svg',
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.translate('passwordRequired');
                      }
                      if (value.length < 6) {
                        return localizations.translate('passwordMinLength');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text(
                        localizations.translate('rememberMe'),
                        style: theme.textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          localizations.translate('forgotPassword'),
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: _onLoginPressed,
                        text: localizations.translate('login'),
                        isLoading: state is AuthLoading,
                      );
                    },
                  ),
                  const Spacer(flex: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(
                        onPressed: () {},
                        iconPath: 'assets/icons/google.svg',
                      ),
                      const SizedBox(width: 16),
                      SocialLoginButton(
                        onPressed: () {},
                        iconPath: 'assets/icons/apple.svg',
                      ),
                      const SizedBox(width: 16),
                      SocialLoginButton(
                        onPressed: () {},
                        iconPath: 'assets/icons/facebook.svg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localizations.translate('dontHaveAccount'),
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        child: Text(
                          localizations.translate('register'),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 