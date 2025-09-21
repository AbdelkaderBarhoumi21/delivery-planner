import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/edit_profile/widgets/user_profile_with_edit_icon.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //user profilfe with edit icon
              AppUserProfileWithEditIcon(),

              SizedBox(height: AppSizes.spaceBtwSections),
              //divider
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),

              //account settings heading
              AppSectionHeading(
                title: 'Account Settings',
                showActionsButtons: false,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),

              AppUserDetailsRow(
                title: 'Name',
                value: 'Abdelkader',
                onTap: () {},
              ),
              AppUserDetailsRow(
                title: 'Username',
                value: 'Barhoumi',
                onTap: () {},
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              //divider
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),
              //Profile Settings
              AppSectionHeading(
                title: 'Profile Settings',
                showActionsButtons: false,
              ),
              SizedBox(height: AppSizes.spaceBtwItems),
              AppUserDetailsRow(title: 'User ID', value: '23176', onTap: () {}),
              AppUserDetailsRow(
                title: 'Email',
                value: 'abdelkaderbarhoumi21@gmail.com',
                onTap: () {},
              ),
              AppUserDetailsRow(
                title: 'Phone Number',
                value: '+2162077996005',
                onTap: () {},
              ),
              AppUserDetailsRow(title: 'Gender', value: 'Male', onTap: () {}),
              SizedBox(height: AppSizes.spaceBtwItems),

              //divider
              Divider(),
              SizedBox(height: AppSizes.spaceBtwItems),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Close Account",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.apply(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppUserDetailsRow extends StatelessWidget {
  const AppUserDetailsRow({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    this.icon = Iconsax.arrow_right_34,
  });
  final String title, value;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.spaceBtwItems / 1.5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: Icon(icon, size: AppSizes.iconSm)),
          ],
        ),
      ),
    );
  }
}
