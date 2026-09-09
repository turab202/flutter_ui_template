import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../../../core/widgets/app_text_field.dart';

// ============================================================
// SIGN IN SCREEN — Sample Screen
// Demonstrates: branding, form fields, validation, loading state,
// error state, social auth buttons, responsive layout.
// All values from design tokens only.
// ============================================================

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  bool _rememberMe = false;
  String? _emailError;
  String? _passwordError;
  bool _showPassword = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: AppMotion.decelerate,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _slideController,
            curve: AppMotion.decelerate,
          ),
        );

    // Staggered entrance
    Future.delayed(const Duration(milliseconds: 80), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  bool _validate() {
    bool ok = true;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      if (email.isEmpty) {
        _emailError = 'Email address is required';
        ok = false;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        _emailError = 'Enter a valid email address';
        ok = false;
      } else {
        _emailError = null;
      }

      if (password.isEmpty) {
        _passwordError = 'Password is required';
        ok = false;
      } else if (password.length < 8) {
        _passwordError = 'Password must be at least 8 characters';
        ok = false;
      } else {
        _passwordError = null;
      }
    });
    return ok;
  }

  Future<void> _handleSignIn() async {
    if (!_validate()) return;

    setState(() => _isLoading = true);

    // Simulate network delay — no real auth
    await Future.delayed(const Duration(milliseconds: 1800));

    if (!mounted) return;
    setState(() => _isLoading = false);

    showAppToast(
      context,
      message: 'Signed in successfully! (demo)',
      variant: AppToastVariant.success,
    );
  }

  void _handleForgotPassword() {
    showAppToast(
      context,
      message: 'Password reset link sent (demo)',
      variant: AppToastVariant.neutral,
    );
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = AppMotion.shouldReduceMotion(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    Widget formContent = FadeTransition(
      opacity: reduceMotion
          ? const AlwaysStoppedAnimation(1.0)
          : _fadeAnimation,
      child: SlideTransition(
        position: reduceMotion
            ? const AlwaysStoppedAnimation(Offset.zero)
            : _slideAnimation,
        child: _SignInForm(
          emailController: _emailController,
          passwordController: _passwordController,
          emailFocus: _emailFocus,
          passwordFocus: _passwordFocus,
          emailError: _emailError,
          passwordError: _passwordError,
          isLoading: _isLoading,
          rememberMe: _rememberMe,
          showPassword: _showPassword,
          onRememberMeChanged: (v) => setState(() => _rememberMe = v ?? false),
          onShowPasswordChanged: () =>
              setState(() => _showPassword = !_showPassword),
          onSignIn: _handleSignIn,
          onForgotPassword: _handleForgotPassword,
          onSocialSignIn: (provider) => showAppToast(
            context,
            message: 'Continue with $provider (demo)',
            variant: AppToastVariant.neutral,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: isTablet
            ? _TabletLayout(formContent: formContent)
            : _MobileLayout(formContent: formContent),
      ),
    );
  }
}

// ----------------------------------------------------------
// Mobile layout: full-screen scrollable form
// ----------------------------------------------------------
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.formContent});
  final Widget formContent;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.lg,
      ),
      child: formContent,
    );
  }
}

// ----------------------------------------------------------
// Tablet layout: centered card with max-width cap
// ----------------------------------------------------------
class _TabletLayout extends StatelessWidget {
  const _TabletLayout({required this.formContent});
  final Widget formContent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: AppRadius.lgAll,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: formContent,
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// The form content (shared between mobile/tablet)
// ----------------------------------------------------------
class _SignInForm extends StatelessWidget {
  const _SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.emailError,
    required this.passwordError,
    required this.isLoading,
    required this.rememberMe,
    required this.showPassword,
    required this.onRememberMeChanged,
    required this.onShowPasswordChanged,
    required this.onSignIn,
    required this.onForgotPassword,
    required this.onSocialSignIn,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final String? emailError;
  final String? passwordError;
  final bool isLoading;
  final bool rememberMe;
  final bool showPassword;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onShowPasswordChanged;
  final VoidCallback onSignIn;
  final VoidCallback onForgotPassword;
  final ValueChanged<String> onSocialSignIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Branding ──────────────────────────────────────
        _BrandHeader(),
        const SizedBox(height: AppSpacing.xl),

        // ── Social auth ───────────────────────────────────
        _SocialButton(
          label: 'Continue with Google',
          icon: Icons.g_mobiledata_rounded,
          onTap: () => onSocialSignIn('Google'),
        ),
        const SizedBox(height: AppSpacing.xs),
        _SocialButton(
          label: 'Continue with Apple',
          icon: Icons.apple,
          onTap: () => onSocialSignIn('Apple'),
        ),

        // ── Divider ───────────────────────────────────────
        const SizedBox(height: AppSpacing.md),
        _OrDivider(),
        const SizedBox(height: AppSpacing.md),

        // ── Email ─────────────────────────────────────────
        AppTextField(
          controller: emailController,
          focusNode: emailFocus,
          label: 'Email address',
          hint: 'you@company.com',
          errorText: emailError,
          prefixIcon: const Icon(Icons.mail_outline_rounded),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => passwordFocus.requestFocus(),
          semanticLabel: 'Email address input',
        ),
        const SizedBox(height: AppSpacing.xs),

        // ── Password ──────────────────────────────────────
        AppTextField(
          controller: passwordController,
          focusNode: passwordFocus,
          label: 'Password',
          hint: 'Enter your password',
          errorText: passwordError,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          obscureText: !showPassword,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onSignIn(),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: AppColors.textSecondary,
            ),
            onPressed: onShowPasswordChanged,
            tooltip: showPassword ? 'Hide password' : 'Show password',
          ),
          semanticLabel: 'Password input',
        ),

        // ── Remember me + Forgot ──────────────────────────
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: Checkbox(
                value: rememberMe,
                onChanged: onRememberMeChanged,
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Remember me',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Semantics(
              label: 'Forgot password',
              button: true,
              child: GestureDetector(
                onTap: onForgotPassword,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxs,
                    vertical: AppSpacing.xs,
                  ),
                  child: Text(
                    'Forgot password?',
                    style: AppTypography.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // ── Sign in button ────────────────────────────────
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Sign In',
          onPressed: isLoading ? null : onSignIn,
          isLoading: isLoading,
          semanticLabel: 'Sign in to your account',
        ),

        // ── Sign up link ──────────────────────────────────
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Semantics(
              label: 'Create a new account',
              button: true,
              child: GestureDetector(
                onTap: () => showAppToast(
                  context,
                  message: 'Sign up flow (demo)',
                  variant: AppToastVariant.neutral,
                ),
                child: Text(
                  'Create account',
                  style: AppTypography.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        // ── Terms ─────────────────────────────────────────
        const SizedBox(height: AppSpacing.lg),
        Text(
          'By signing in you agree to our Terms of Service and Privacy Policy.',
          style: AppTypography.small.copyWith(color: AppColors.textDisabled),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ----------------------------------------------------------
// Brand header
// ----------------------------------------------------------
class _BrandHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo mark
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, Color(0xFF004499)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 36),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Welcome back',
          style: AppTypography.h1.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Sign in to your workspace',
          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ----------------------------------------------------------
// Social auth button
// ----------------------------------------------------------
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderDefault),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: AppColors.textPrimary),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// "Or" divider
// ----------------------------------------------------------
class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.borderDefault, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            'or',
            style: AppTypography.caption.copyWith(
              color: AppColors.textDisabled,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.borderDefault, thickness: 1)),
      ],
    );
  }
}
