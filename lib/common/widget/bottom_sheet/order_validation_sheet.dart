import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/textfields/text_field.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';

class AddressBottomSheet {
  /// Ouvre la bottom-sheet et renvoie:
  /// - true  : si l'utilisateur tape "Save Address"
  /// - false : si l'utilisateur ferme via la croix
  /// - null  : si la sheet est fermée par un autre moyen
  //! show packages process bottom sheet
  static Future<bool?> showPending(BuildContext context) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final labelCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final stateCtrl = TextEditingController();
    final zipCtrl = TextEditingController();

    try {
      final result = await Get.bottomSheet<bool>(
        Container(
          padding: AppPadding.screenPadding,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Stop', style: theme.textTheme.titleMedium),
                  ),
                  IconButton(
                    onPressed: () => Get.back(result: false),
                    icon: Icon(
                      Icons.close,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<String>(
                  value: 'ORD-01',
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Order ID',
                    hintText: 'Choisir un ordre',
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),

                    prefixIcon: Icon(
                      Icons.delivery_dining_rounded,
                      color: AppColors.primary,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.primary.withOpacity(.25),
                      ),
                    ),
                    // champ activé (non focus)
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.primary.withOpacity(.25),
                      ),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                  ),

                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(12),

                  elevation: 8,
                  menuMaxHeight: 280,

                  // icône flèche
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  iconEnabledColor: AppColors.primary,
                  iconSize: 22,

                  style: Theme.of(context).textTheme.bodyMedium,

                  items: ['ORD-01', 'ORD-02'].map((v) {
                    return DropdownMenuItem(
                      value: v,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(v),
                      ),
                    );
                  }).toList(),

                  // pour afficher l’état d’erreur via validator si besoin
                  validator: (val) => (val == null) ? 'Obligatoire' : null,

                  onChanged: (v) {
                    /* setState(...) */
                  },
                ),
              ),

              SizedBox(height: AppSizes.spaceBtwInputFields),
              CustomTextField(
                controller: addressCtrl,
                label: 'COD',
                icon: Icons.location_on_outlined,
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),
              CustomTextField(
                controller: cityCtrl,
                label: 'SKU',
                icon: Icons.location_city_outlined,
              ),
              SizedBox(height: AppSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: stateCtrl,
                      label: 'Serial Number',
                      icon: Icons.map_outlined,
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwInputFields),
                  Expanded(
                    child: CustomTextField(
                      controller: zipCtrl,
                      label: 'Qunatity',
                      icon: Icons.pin_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Pas de validation -> on renvoie simplement true
                    Get.back(result: true);
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems / 2),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Cancel",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.apply(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
        isScrollControlled: true,
      );

      return result; // true / false / null
    } finally {
      // Nettoyage
      labelCtrl.dispose();
      addressCtrl.dispose();
      cityCtrl.dispose();
      stateCtrl.dispose();
      zipCtrl.dispose();
    }
  }

  //show trip
  static Future<bool?> showTrip(BuildContext context) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final labelCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final stateCtrl = TextEditingController();
    final zipCtrl = TextEditingController();

    try {
      final result = await Get.bottomSheet<bool>(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add New Address',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(result: false), // annuler
                        icon: Icon(
                          Icons.close,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Champs non validés (juste pour l'UI)
                  CustomTextField(
                    controller: labelCtrl,
                    label: 'Label (e.g. Home, Office)',
                    icon: Icons.label_outline,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: addressCtrl,
                    label: 'Full Address',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: cityCtrl,
                    label: 'City',
                    icon: Icons.location_city_outlined,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: stateCtrl,
                          label: 'State',
                          icon: Icons.map_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomTextField(
                          controller: zipCtrl,
                          label: 'Zip Code',
                          icon: Icons.pin_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Pas de validation -> on renvoie simplement true
                        Get.back(result: true);
                      },
                      child: const Text(
                        'Save Address',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isScrollControlled: true,
      );

      return result; // true / false / null
    } finally {
      // Nettoyage
      labelCtrl.dispose();
      addressCtrl.dispose();
      cityCtrl.dispose();
      stateCtrl.dispose();
      zipCtrl.dispose();
    }
  }
}
