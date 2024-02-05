import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lexus_app/theme/style.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, right: 2, left: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(1, 2), // Shadow position (x, y)
            blurRadius: 1.0, // Spread of the shadow
            spreadRadius: 1.0, // Offset of the shadow
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'test question?',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: '1)option1   ',
                      style: TextStyle(
                        height: 1.5,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '2)option2    ',
                        ),
                        TextSpan(
                          text: '3)option3    ',
                        ),
                        TextSpan(
                          text: '4)option4    ',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: (isSelected == false)
                    ? const Icon(
                        Icons.check_circle_outline,
                        size: 28,
                        color: Colors.black54,
                      )
                    : const Icon(
                        Icons.check_circle,
                        size: 28,
                        color: Style.primary,
                      ))
          ],
        ),
      ),
    );
  }
}
