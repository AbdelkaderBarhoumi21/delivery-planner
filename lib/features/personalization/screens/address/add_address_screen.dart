import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScree extends StatelessWidget {
  const AddNewAddressScree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: UAppBar(
        title: Text(
          'Add New Address',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              //Name
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              //phone number
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),
              //street - postal code
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.building_31),
                        labelText: 'Street',
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.code),
                        labelText: 'Postal Code',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),

              //city -  state
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.building),
                        labelText: 'City',
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.activity),
                        labelText: 'State',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),
              //country
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.global),
                  labelText: 'Country',
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwSections),
              //save button
              AppElevatedButton(onPressed: () {}, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
