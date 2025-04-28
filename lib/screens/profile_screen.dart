import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../providers/user_provider.dart';
import '../models/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider _profileProvider;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _profileProvider.fetchProfile(
        _userProvider.user?.id ?? '', _userProvider.token ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          if (profileProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final Profile? profile = profileProvider.profile;
          if (profile == null) {
            return const Center(child: Text('Failed to load profile.'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profile.avatarUrl),
              ),
              const SizedBox(height: 16),
              Text(profile.fullName,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('@${profile.username}',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(profile.email),
              const SizedBox(height: 16),
              Text(profile.bio),
              // TODO: Add edit profile button and functionality
            ],
          );
        },
      ),
    );
  }
}
