import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/features/auth/presentation/providers/auth_providers.dart';
import 'package:global_diaspora_events/features/profile/presentation/providers/profile_providers.dart';
import 'package:go_router/go_router.dart';

import 'package:global_diaspora_events/features/social/presentation/providers/social_providers.dart';

class ProfileScreen extends ConsumerWidget {
  final String? userId;

  const ProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final isCurrentUser = userId == null || userId == currentUser?.id;
    final targetUserId = userId ?? currentUser?.id;

    final userProfileAsync = isCurrentUser
        ? ref.watch(userProfileProvider)
        : ref.watch(profileByIdProvider(targetUserId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: userProfileAsync.when(
        data: (profile) {
          if (profile == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No profile found.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push(
                      '/edit-profile',
                    ), // Should handle creating a profile
                    child: const Text('Create Profile'),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profile.avatarUrl != null
                      ? NetworkImage(profile.avatarUrl!)
                      : null,
                  child: profile.avatarUrl == null
                      ? Text(
                          (profile.displayName ?? 'U')[0].toUpperCase(),
                          style: const TextStyle(fontSize: 40),
                        )
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  profile.displayName ?? 'Display Name',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  profile.email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                if (profile.currentCity != null ||
                    profile.countryOfOrigin != null) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (profile.currentCity != null)
                        Chip(
                          avatar: const Icon(Icons.location_city, size: 16),
                          label: Text(profile.currentCity!),
                        ),
                      if (profile.countryOfOrigin != null) ...[
                        const SizedBox(width: 8),
                        Chip(
                          avatar: const Icon(Icons.flag, size: 16),
                          label: Text(profile.countryOfOrigin!),
                        ),
                      ],
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                if (profile.bio != null) ...[
                  Text('About', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    profile.bio!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                ],
                if (isCurrentUser) ...[
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.push('/edit-profile'),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade100,
                        foregroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        await ref.read(authRepositoryProvider).signOut();
                        if (context.mounted) {
                          context.go('/login');
                        }
                      },
                      child: const Text('Sign Out'),
                    ),
                  ),
                ] else ...[
                  _FollowButton(targetUserId: targetUserId!),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _FollowButton extends ConsumerStatefulWidget {
  final String targetUserId;

  const _FollowButton({required this.targetUserId});

  @override
  ConsumerState<_FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends ConsumerState<_FollowButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isFollowingAsync = ref.watch(
      isFollowingProvider(widget.targetUserId),
    );

    return isFollowingAsync.when(
      data: (isFollowing) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() => _isLoading = true);
                    try {
                      final repo = ref.read(socialRepositoryProvider);
                      if (isFollowing) {
                        await repo.unfollowUser(widget.targetUserId);
                      } else {
                        await repo.followUser(widget.targetUserId);
                      }
                      ref.invalidate(isFollowingProvider(widget.targetUserId));
                      ref.invalidate(
                        followersCountProvider(widget.targetUserId),
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Error: $e')));
                      }
                    } finally {
                      if (mounted) setState(() => _isLoading = false);
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing
                  ? Colors.grey.shade300
                  : Theme.of(context).primaryColor,
              foregroundColor: isFollowing ? Colors.black : Colors.white,
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(isFollowing ? 'Unfollow' : 'Follow'),
          ),
        );
      },
      loading: () => const SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: null, child: Text('Loading...')),
      ),
      error: (e, st) => Text('Error: $e'),
    );
  }
}
