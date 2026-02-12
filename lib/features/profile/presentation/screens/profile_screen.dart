import 'package:flutter/material.dart';
import 'package:gde/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme.dart';
import '../../../../core/theme/theme_controller.dart';
import '../../../../core/utils/country_utils.dart';
import '../../../../core/widgets/shimmer_skeletons.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../presentation/providers/profile_providers.dart';

/// Экран профиля пользователя.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;
  bool _isEmailLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(currentProfileProvider);

    return Scaffold(
      body: SafeArea(
        child: profileAsync.when(
          loading: () => const ProfileSkeleton(),
          error: (_, _) => _buildAuthPrompt(context),
          data: (profile) {
            if (profile == null) return _buildAuthPrompt(context);

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Avatar
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.primary,
                          backgroundImage: profile.avatarUrl != null
                              ? NetworkImage(profile.avatarUrl!)
                              : null,
                          child: profile.avatarUrl == null
                              ? const Icon(
                                  Icons.person_rounded,
                                  size: 48,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(height: 16),
                        // Name
                        Text(
                          profile.displayName ??
                              AppLocalizations.of(context)!.diasporaMember,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Origin / City
                        Text(
                          [
                            if (profile.originCountry != null)
                              AppLocalizations.of(context)!.fromCountry(
                                countryDisplay(profile.originCountry!),
                              ),
                            if (profile.currentCity != null)
                              AppLocalizations.of(
                                context,
                              )!.inCity(profile.currentCity!),
                          ].join(' · '),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Stats cards
                        _buildInfoCard(
                          context: context,
                          icon: Icons.public_rounded,
                          color: AppColors.primary,
                          label: AppLocalizations.of(context)!.originCountry,
                          value: profile.originCountry != null
                              ? countryDisplay(profile.originCountry!)
                              : AppLocalizations.of(context)!.notSet,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          context: context,
                          icon: Icons.location_city_rounded,
                          color: AppColors.secondary,
                          label: AppLocalizations.of(context)!.currentCity,
                          value:
                              profile.currentCity ??
                              AppLocalizations.of(context)!.notSet,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          context: context,
                          icon: Icons.calendar_today_rounded,
                          color: AppColors.accent,
                          label: AppLocalizations.of(context)!.joined,
                          value: _formatDate(profile.createdAt),
                        ),

                        const SizedBox(height: 32),

                        // ─── Theme Switching ──────────────────────
                        _buildThemeSection(context),
                        const SizedBox(height: 24),

                        // My Events
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => context.push('/my-events'),
                            icon: const Icon(Icons.event_available_rounded),
                            label: Text(AppLocalizations.of(context)!.myEvents),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Edit Profile
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => context.push('/onboarding'),
                            icon: const Icon(Icons.edit_rounded),
                            label: Text(
                              AppLocalizations.of(context)!.editProfile,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Sign Out
                        SizedBox(
                          width: double.infinity,
                          child: TextButton.icon(
                            onPressed: () => _handleSignOut(),
                            icon: Icon(
                              Icons.logout_rounded,
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                            label: Text(
                              AppLocalizations.of(context)!.signOut,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outlineVariant,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ─── Auth prompt ──────────────────────────────────────────

  Widget _buildAuthPrompt(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.joinCommunity,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.signInSubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 28),

            // ─── OAuth buttons ────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _handleGoogleSignIn(),
                icon: const Icon(Icons.g_mobiledata_rounded, size: 24),
                label: Text(l10n.signInWithGoogle),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _handleAppleSignIn(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                icon: const Icon(Icons.apple_rounded, size: 22),
                label: Text(l10n.signInWithApple),
              ),
            ),

            const SizedBox(height: 20),

            // ─── Divider ──────────────────────────────────────
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.divider)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    l10n.orContinueWithEmail,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: AppColors.divider)),
              ],
            ),
            const SizedBox(height: 20),

            // ─── Email / Password form ────────────────────────
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: l10n.email,
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true,
                fillColor: AppColors.cardDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
              ),
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: l10n.password,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                filled: true,
                fillColor: AppColors.cardDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
              ),
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isEmailLoading ? null : () => _handleEmailAuth(),
                child: _isEmailLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_isSignUp ? l10n.signUp : l10n.signIn),
              ),
            ),
            const SizedBox(height: 8),

            // Toggle sign-in ↔ sign-up
            TextButton(
              onPressed: () => setState(() => _isSignUp = !_isSignUp),
              child: Text(
                _isSignUp ? l10n.alreadyHaveAccount : l10n.dontHaveAccount,
                style: const TextStyle(color: AppColors.primary, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Auth handlers ────────────────────────────────────────

  Future<void> _handleGoogleSignIn() async {
    try {
      await ref.read(signInWithGoogleProvider.future);
    } catch (e) {
      if (!mounted) return;
      _showAuthError(e.toString());
    }
  }

  Future<void> _handleAppleSignIn() async {
    try {
      await ref.read(signInWithAppleProvider.future);
    } catch (e) {
      if (!mounted) return;
      _showAuthError(e.toString());
    }
  }

  Future<void> _handleEmailAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) return;

    setState(() => _isEmailLoading = true);

    try {
      final credentials = (email: email, password: password);
      if (_isSignUp) {
        await ref.read(signUpWithEmailProvider(credentials).future);
      } else {
        await ref.read(signInWithEmailProvider(credentials).future);
      }
      ref.invalidate(currentProfileProvider);
    } catch (e) {
      if (!mounted) return;
      _showAuthError(e.toString());
    } finally {
      if (mounted) setState(() => _isEmailLoading = false);
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await ref.read(signOutProvider.future);
      ref.invalidate(currentProfileProvider);
    } catch (e) {
      if (!mounted) return;
      _showAuthError(e.toString());
    }
  }

  void _showAuthError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ─── UI helpers ───────────────────────────────────────────

  Widget _buildThemeSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeControllerProvider);
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCard(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.adaptiveDivider(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette_rounded, size: 20, color: cs.primary),
              const SizedBox(width: 8),
              Text(
                l10n.theme,
                style: TextStyle(
                  color: cs.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: const Icon(Icons.brightness_auto_rounded, size: 18),
                  label: Text(l10n.themeSystem),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: const Icon(Icons.light_mode_rounded, size: 18),
                  label: Text(l10n.themeLight),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: const Icon(Icons.dark_mode_rounded, size: 18),
                  label: Text(l10n.themeDark),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (selected) {
                ref
                    .read(themeControllerProvider.notifier)
                    .setThemeMode(selected.first);
              },
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.adaptiveCard(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.adaptiveDivider(context)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
