 import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = "/ProfileScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: context.height * 0.03),

              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.blackOne,
                  backgroundImage: const AssetImage("assets/images/gamer (1).png"),
                ),
              ),
              SizedBox(height: context.height * 0.02),

              // Username
              Text(
                Supabase.instance.client.auth.currentUser?.userMetadata?['full_name'] ?? "Podcast Listener",
                style: TextStyleHelper.font24WhiteBold,
              ),
              SizedBox(height: context.height * 0.005),
              Text(
                Supabase.instance.client.auth.currentUser?.email ?? "listener@podcast.app",
                style: TextStyleHelper.font14GreyRegular,
              ),
              SizedBox(height: context.height * 0.04),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(context, "12", "Subscribed"),
                  _buildStatItem(context, "48", "Listened"),
                  _buildStatItem(context, "5", "Downloads"),
                ],
              ),
              SizedBox(height: context.height * 0.04),

              // Settings List
              _buildSettingsItem(
                context,
                icon: Icons.notifications_outlined,
                title: "Notifications",
                trailing: Switch(
                  value: true,
                  onChanged: (_) {},
                  activeColor: AppColors.gold,
                ),
              ),
              _buildSettingsItem(
                context,
                icon: Icons.dark_mode_outlined,
                title: "Dark Mode",
                trailing: Switch(
                  value: true,
                  onChanged: (_) {},
                  activeColor: AppColors.gold,
                ),
              ),
              _buildSettingsItem(
                context,
                icon: Icons.download_outlined,
                title: "Download Quality",
                subtitle: "High",
                onTap: () {},
              ),
              _buildSettingsItem(
                context,
                icon: Icons.language,
                title: "Language",
                subtitle: "English",
                onTap: () {},
              ),
              _buildSettingsItem(
                context,
                icon: Icons.info_outline,
                title: "About",
                onTap: () {},
              ),
              _buildSettingsItem(
                context,
                icon: Icons.logout,
                title: "Logout",
                iconColor: AppColors.red,
                titleColor: AppColors.red,
                onTap: () async {
                  await Supabase.instance.client.auth.signOut();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/LoginScreen",
                      (route) => false,
                    );
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String count, String label) {
    return Container(
      width: context.width * 0.26,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.blackOne,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blackFour, width: 1),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyleHelper.font24WhiteBold.copyWith(
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyleHelper.font14GreyRegular,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? iconColor,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.blackOne,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor ?? AppColors.gold),
        title: Text(
          title,
          style: TextStyleHelper.font16WhiteBold.copyWith(
            color: titleColor ?? Colors.white,
          ),
        ),
        subtitle: subtitle != null
            ? Text(subtitle, style: TextStyleHelper.font14GreyRegular)
            : null,
        trailing: trailing ??
            (onTap != null
                ? const Icon(Icons.arrow_forward_ios, color: AppColors.gray, size: 16)
                : null),
      ),
    );
  }
}
