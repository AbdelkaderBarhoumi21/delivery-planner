import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/edit_profile/edit_profile_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppUserProfileTile extends StatelessWidget {
  const AppUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        "Abdelkader Barhoumi",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        "abdelkaderbarhoumi21@gmail.com",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => EditProfileScreen()),
        icon: Icon(Iconsax.edit),
      ),
    );
  }
}
