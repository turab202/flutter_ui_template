import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
// 🎨 PROJECT-SPECIFIC — sample content only
// ============================================================

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: AppMotion.screenTransition,
    );
    Future.delayed(const Duration(milliseconds: 60), () {
      if (mounted) _fadeCtrl.forward();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  bool _validate() {
    final email = _emailController.text.trim();
    final pw = _passwordController.text;
    String? emailErr;
    String? pwErr;
    if (email.isEmpty) {
      emailErr = 'Email address is required';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emailErr = 'Enter a valid email address';
    }
    if (pw.isEmpty) {
      pwErr = 'Password is required';
    } else if (pw.length < 8) {
      pwErr = 'Password must be at least 8 characters';
    }
    setState(() {
      _emailError = emailErr;
      _passwordError = pwErr;
    });
    return emailErr == null && pwErr == null;
  }

  Future<void> _signIn() async {
    if (!_validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1600));
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

    Widget content = FadeTransition(
      opacity: reduce
          ? const AlwaysStoppedAnimation(1.0)
          : CurvedAnimation(parent: _fadeCtrl, curve: AppMotion.decelerate),
      child: _SignInForm(
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
        onTogglePassword: () => setState(() => _showPassword = !_showPassword),
        onSignIn: _signIn,
        onForgotPassword: () =>
            showAppToast(context, message: 'Reset link sent (demo)'),
        onSocialTap: (p) =>
            showAppToast(context, message: 'Continue with $p (demo)'),
        onCreateAccount: () =>
            showAppToast(context, message: 'Sign up flow (demo)'),
        onTermsTap: () =>
            showAppToast(context, message: 'Terms of Service (demo)'),
        onPrivacyTap: () =>
            showAppToast(context, message: 'Privacy Policy (demo)'),
      ),
    );

    return SafeArea(
      child: isTablet ? _tabletLayout(content) : _mobileLayout(content),
    );
  }

  Widget _mobileLayout(Widget child) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.lg,
    ),
    child: child,
  );

  Widget _tabletLayout(Widget child) => Center(
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

// ============================================================
// SIGN IN FORM
// ============================================================

class _SignInForm extends StatelessWidget {
  const _SignInForm({
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
    required this.onTermsTap,
    required this.onPrivacyTap,
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
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _WorkSpaceLogo(),
        const SizedBox(height: AppSpacing.lg),

        Text(
          'Welcome back',
          style: AppTypography.h1.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Sign in to your workspace to continue\nwhere you left off.',
          style: AppTypography.body.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.md),

        // ── Email ──────────────────────────────────────────
        Text(
          'Email address',
          style: AppTypography.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: AppTypography.weightMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        AppTextField(
          controller: emailController,
          focusNode: emailFocus,
          hint: 'alex.johnson@company.com',
          errorText: emailError,
          // 🎨 primary-coloured icon
          prefixIcon: const Icon(Icons.mail_outline_rounded, color: AppColors.primary),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) => passwordFocus.requestFocus(),
          semanticLabel: 'Email address',
        ),
        const SizedBox(height: AppSpacing.xs),

        // ── Password ───────────────────────────────────────
        Text(
          'Password',
          style: AppTypography.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: AppTypography.weightMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        AppTextField(
          controller: passwordController,
          focusNode: passwordFocus,
          hint: 'Enter your password',
          errorText: passwordError,
          // 🎨 primary-coloured icon
          prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
          obscureText: !showPassword,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => onSignIn(),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              // 🎨 primary-coloured visibility toggle
              color: AppColors.primary,
            ),
            onPressed: onTogglePassword,
            tooltip: showPassword ? 'Hide password' : 'Show password',
          ),
          semanticLabel: 'Password',
        ),

        // ── Remember me + Forgot ───────────────────────────
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
                  borderRadius: BorderRadius.circular(AppRadius.sm / 2),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Remember me',
                style: AppTypography.caption.copyWith(
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
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: AppTypography.weightSemibold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // ── Sign In button ─────────────────────────────────
        const SizedBox(height: AppSpacing.xs),
        AppButton(
          label: 'Sign In',
          onPressed: loading ? null : onSignIn,
          isLoading: loading,
          semanticLabel: 'Sign in to your account',
        ),

        // ── OR divider ─────────────────────────────────────
        const SizedBox(height: AppSpacing.sm),
        const _OrDivider(),
        const SizedBox(height: AppSpacing.sm),

        // ── Social buttons ─────────────────────────────────
        _SocialButton(
          icon: const _GoogleIcon(),
          label: 'Continue with Google',
          onTap: () => onSocialTap('Google'),
        ),
        const SizedBox(height: AppSpacing.xs),
        _SocialButton(
          icon: const Icon(Icons.apple, size: 22, color: AppColors.textPrimary),
          label: 'Continue with Apple',
          onTap: () => onSocialTap('Apple'),
        ),

        // ── Create account ─────────────────────────────────
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?  ",
              style: AppTypography.caption.copyWith(
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
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: AppTypography.weightSemibold,
                  ),
                ),
              ),
            ),
          ],
        ),

        // ── Terms ──────────────────────────────────────────
        const SizedBox(height: AppSpacing.sm),
        _TermsText(onTermsTap: onTermsTap, onPrivacyTap: onPrivacyTap),
      ],
    );
  }
}

// ============================================================
// WORKSPACE LOGO
// ============================================================

class _WorkSpaceLogo extends StatelessWidget {
  const _WorkSpaceLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.30),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 40),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'WorkSpace',
          style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Better teams. Greater results.',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ============================================================
// SOCIAL BUTTON
// ============================================================

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: Material(
        color: AppColors.background,
        borderRadius: AppRadius.smAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.smAll,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: AppRadius.smAll,
              border: Border.all(color: AppColors.borderDefault),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 32, height: 32, child: icon),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  label,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// OR DIVIDER
// ============================================================

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.borderDefault, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            'or continue with',
            style: AppTypography.caption.copyWith(color: AppColors.textDisabled),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.borderDefault, thickness: 1),
        ),
      ],
    );
  }
}

// ============================================================
// GOOGLE ICON — polished brand badge with layered depth
// ============================================================

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/google_logo.svg',
        width: 22,
        height: 22,
        fit: BoxFit.contain,
      ),
    );
  }
}

// ============================================================
// TERMS TEXT
// ============================================================

class _TermsText extends StatelessWidget {
  const _TermsText({required this.onTermsTap, required this.onPrivacyTap});

  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  @override
  Widget build(BuildContext context) {
    final base = AppTypography.small.copyWith(color: AppColors.textDisabled);
    final link = AppTypography.small.copyWith(color: AppColors.primary);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: base,
        children: [
          const TextSpan(text: 'By signing in, you agree to our '),
          TextSpan(
            text: 'Terms of Service',
            style: link,
            recognizer: TapGestureRecognizer()..onTap = onTermsTap,
          ),
          const TextSpan(text: '\nand '),
          TextSpan(
            text: 'Privacy Policy',
            style: link,
            recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
