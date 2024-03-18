import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAssignment extends StatelessWidget {
  CreateAssignment({super.key});
  int activeStep = 2;
  int activeStep2 = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EasyStepper(
                activeStep: activeStep,
                lineStyle: LineStyle(
                  lineLength: 100,
                  lineThickness: 6,
                  lineSpace: 4,
                  lineType: LineType.normal,
                  defaultLineColor: Colors.purple.shade300,
                  //   progress: progress,
                  // progressColor: Colors.purple.shade700,
                ),
                borderThickness: 10,
                internalPadding: 15,
                loadingAnimation: 'assets/loading_circle.json',
                steps: const [
                  EasyStep(
                    icon: Icon(CupertinoIcons.info),
                    title: 'Info',
                    lineText: 'Add Paper Info',
                  ),
                  EasyStep(
                    icon: Icon(Icons.question_mark_outlined),
                    title: 'Question',
                    lineText: 'Select Question',
                  ),
                  EasyStep(
                    icon: Icon(CupertinoIcons.eye),
                    title: 'View',
                    lineText: 'View Paper',
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
