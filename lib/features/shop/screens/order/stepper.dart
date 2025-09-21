import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/bottom_sheet/address_bottom_sheet.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/bottom_sheet/trip_bottom_sheet.dart';
import 'package:flutter_ecommerce_app_v2/test_data.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int currentStep = 0;
  bool isCompleted = false;

  Future<void> contiuneStep() async {
    // Ouvrir la sheet quand on passe de Step 1 -> Step 2
    if (currentStep == 0) {
      final selection = await TripBottomSheet.show(
        context,
        vehicles: TestData.vehicles,
        orders: TestData.orders,
      );
    }
    if (currentStep == 1) {
      final ok = await AddressBottomSheet.showPending(context);
      if (ok == true) {
        setState(() => currentStep++); // ✅ incrémente
      }
      return;
    }

    // Sinon, continuer normalement
    if (currentStep < 2) {
      setState(() => currentStep++);
    }
  }

  cancelStep() {
    setState(() {
      if (currentStep > 0) {
        currentStep = currentStep - 1;
      }
    });
  }

  stepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlsBuilder(BuildContext context, details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(onPressed: details.onStepContinue, child: Text('Next')),
        if (currentStep == 1) Row(children: [Text("hello")]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      elevation: 0,

      type: StepperType.vertical,
      currentStep: currentStep,
      onStepContinue: contiuneStep,
      onStepCancel: cancelStep,
      onStepTapped: stepTapped,
      controlsBuilder: controlsBuilder,
      steps: [
        Step(
          title: Text("Trip Planner"),
          label: Text("Hello world"),
          subtitle: Text("Pending"),
          content: Text("The is the first Step"),
          isActive: currentStep >= 0,
          state: currentStep >= 0 ? StepState.complete : StepState.disabled,
          stepStyle: StepStyle(
            color: AppColors.primary,
            connectorColor: AppColors.primary,
            connectorThickness: 1,
          ),
        ),
        Step(
          title: Text("Package Process"),
          subtitle: Text("In-Transit"),
          content: Text("The is the second Step"),
          isActive: currentStep >= 1,
          state: currentStep >= 1 ? StepState.complete : StepState.disabled,
          stepStyle: StepStyle(
            color: AppColors.primary,
            connectorColor: AppColors.primary,
            connectorThickness: 1,
          ),
        ),
        Step(
          title: Text("On-Time"),
          subtitle: isCompleted == true ? Text("Completed") : Text("Error"),
          content: Text("The is the third Step"),
          isActive: currentStep >= 2,
          state: isCompleted == true ? StepState.complete : StepState.error,
          stepStyle: StepStyle(
            color: AppColors.primary,
            connectorColor: AppColors.primary,
            connectorThickness: 1,
          ),
        ),
      ],
    );
  }
}
