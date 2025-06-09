import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/init/lang/app_localizations.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:movie_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:movie_app/features/auth/presentation/widgets/social_login_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _onRegisterPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            SignUpRequested(
              _emailController.text.trim(),
              _passwordController.text.trim(),
              _nameController.text.trim(),
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
            context.go('/add-photo');
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
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Text(
                    localizations.translate('welcome'),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    controller: _nameController,
                    hintText: localizations.translate('fullName'),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/icons/addprofile.svg',
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.onSurface.withAlpha((0.7 * 255).round()),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.translate('fullNameRequired');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
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
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: localizations.translate('confirmPassword'),
                    obscureText: _obscureConfirmPassword,
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
                      onPressed: _toggleConfirmPasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localizations.translate('confirmPasswordRequired');
                      }
                      if (value != _passwordController.text) {
                        return localizations.translate('passwordsDoNotMatch');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: localizations.translate('termsPrefix'),
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: localizations.translate('termsAccept'),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: localizations.translate('termsReadRequest'),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: _onRegisterPressed,
                        text: localizations.translate('registerNow'),
                        isLoading: state is AuthLoading,
                      );
                    },
                  ),
                  const Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
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
                        localizations.translate('alreadyHaveAccount'),
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          localizations.translate('login'),
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