import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    // Use SizedBox for white space instead of Container
    return Column(
      children: [
        SizedBox(
          height: screenheight * 0.08,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => selectHandler(), // Fix the issue here
            style: ButtonStyle(
              textStyle:
                  MaterialStateProperty.all(TextStyle(color: Colors.white)),
              backgroundColor: MaterialStateProperty.all(
                Color(0xFF000080),
              ),
            ),
            child: Text(
              answerText,
              style: TextStyle(
                  color: Colors.white, fontSize: screenheight * 0.022),
            ),
          ),
        ),
        SizedBox(
          height: screenheight * 0.029,
        ),
      ],
    );
  }
}
