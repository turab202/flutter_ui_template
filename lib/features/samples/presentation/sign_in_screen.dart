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
// SIGN IN SCREEN
// Reference: centered logo, "Welcome back" heading,
// Google/Apple social buttons, or-divider, email + password
// fields, remember-me checkbox, forgot password, sign-in btn,
// "Don't have an account?" + terms footnote.
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

  bool _loading = false;
  bool _rememberMe = false;
  bool _showPassword = false;
  String? _emailError;
  String? _passwordError;

  late final AnimationController _fadeCtrl;
  late final AnimationController _slideCtrl;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    Future.delayed(const Duration(milliseconds: 60), () {
      if (mounted) {
        _fadeCtrl.forward();
        _slideCtrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _fadeCtrl.dispose();
    _slideCtrl.dispose();
    super.dispose();
  }

  bool _validate() {
    bool ok = true;
    final email = _emailController.text.trim();
    final pw = _passwordController.text;
    setState(() {
      _emailError = email.isEmpty
          ? 'Email address is required'
          : !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)
          ? 'Enter a valid email address'
          : null;
      _passwordError = pw.isEmpty
          ? 'Password is required'
          : pw.length < 8
          ? 'Password must be at least 8 characters'
          : null;
      if (_emailError != null || _passwordError != null) ok = false;
    });
    return ok;
  }

  Future<void> _signIn() async {
    if (!_validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;
    setState(() => _loading = false);
    showAppToast(
      context,
      message: 'Signed in successfully! (demo)',
      variant: AppToastVariant.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final reduce = AppMotion.shouldReduceMotion(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    final content = FadeTransition(
      opacity: reduce
          ? const AlwaysStoppedAnimation(1.0)
          : CurvedAnimation(parent: _fadeCtrl, curve: AppMotion.decelerate),
      child: SlideTransition(
        position: reduce
            ? const AlwaysStoppedAnimation(Offset.zero)
            : Tween<Offset>(
                begin: const Offset(0, 0.03),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _slideCtrl,
                  curve: AppMotion.decelerate,
                ),
              ),
        child: _Form(
          emailController: _emailController,
          passwordController: _passwordController,
          emailFocus: _emailFocus,
          passwordFocus: _passwordFocus,
          emailError: _emailError,
          passwordError: _passwordError,
          loading: _loading,
          rememberMe: _rememberMe,
          showPassword: _showPassword,
          onRememberMe: (v) => setState(() => _rememberMe = v ?? false),
          onTogglePassword: () =>
              setState(() => _showPassword = !_showPassword),
          onSignIn: _signIn,
          onForgotPassword: () =>
              showAppToast(context, message: 'Reset link sent (demo)'),
          onSocialTap: (p) =>
              showAppToast(context, message: 'Continue with $p (demo)'),
          onCreateAccount: () =>
              showAppToast(context, message: 'Sign up flow (demo)'),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: isTablet ? _tabletWrap(content) : _mobileWrap(content),
      ),
    );
  }

  Widget _mobileWrap(Widget child) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.lg,
    ),
    child: child,
  );

  Widget _tabletWrap(Widget child) => Center(
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
                color: AppColors.overlay.withValues(alpha: 0.08),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------
// Form content — exactly matches reference layout
// ----------------------------------------------------------
class _Form extends StatelessWidget {
  const _Form({
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.emailError,
    required this.passwordError,
    required this.loading,
    required this.rememberMe,
    required this.showPassword,
    required this.onRememberMe,
    required this.onTogglePassword,
    required this.onSignIn,
    required this.onForgotPassword,
    required this.onSocialTap,
    required this.onCreateAccount,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final String? emailError;
  final String? passwordError;
  final bool loading;
  final bool rememberMe;
  final bool showPassword;
  final ValueChanged<bool?> onRememberMe;
  final VoidCallback onTogglePassword;
  final VoidCallback onSignIn;
  final VoidCallback onForgotPassword;
  final ValueChanged<String> onSocialTap;
  final VoidCallback onCreateAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Logo + heading ────────────────────────────────
        _Logo(),
        const SizedBox(height: AppSpacing.xl),

        // ── Social buttons ────────────────────────────────
        _SocialBtn(
          icon: Icons.g_mobiledata_rounded,
          label: 'Continue with Google',
          onTap: () => onSocialTap('Google'),
        ),
        const SizedBox(height: AppSpacing.xs),
        _SocialBtn(
          icon: Icons.apple,
          label: 'Continue with Apple',
          onTap: () => onSocialTap('Apple'),
        ),

        // ── Or divider ────────────────────────────────────
        const SizedBox(height: AppSpacing.sm),
        const _OrDivider(),
        const SizedBox(height: AppSpacing.sm),

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
          semanticLabel: 'Email address',
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
              size: 20,
            ),
            onPressed: onTogglePassword,
            tooltip: showPassword ? 'Hide password' : 'Show password',
          ),
          semanticLabel: 'Password',
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
                onChanged: onRememberMe,
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

        // ── Sign In ───────────────────────────────────────
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Sign In',
          onPressed: loading ? null : onSignIn,
          isLoading: loading,
          semanticLabel: 'Sign in to your account',
        ),

        // ── Create account ────────────────────────────────
        const SizedBox(height: AppSpacing.sm),
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
                onTap: onCreateAccount,
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
        const SizedBox(height: AppSpacing.md),
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
// Logo block
// ----------------------------------------------------------
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.82),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.30),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(Icons.bolt_rounded, color: AppColors.background, size: 40),
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
class _SocialBtn extends StatelessWidget {
  const _SocialBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
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
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: AppColors.textPrimary),
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
// Or divider
// ----------------------------------------------------------
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Divider(color: AppColors.borderDefault, thickness: 1)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Text(
          'or',
          style: AppTypography.caption.copyWith(color: AppColors.textDisabled),
        ),
      ),
      Expanded(child: Divider(color: AppColors.borderDefault, thickness: 1)),
    ],
  );
}
