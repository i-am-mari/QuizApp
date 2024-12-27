import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Result extends StatefulWidget {
  final int resultScore;
  final Function resetHandler;

  const Result(this.resultScore, this.resetHandler, {Key? key})
      : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _buttonAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start off-screen
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Remark Logic
  String get resultPhrase {
    if (widget.resultScore >= 41) return 'You are awesome!';
    if (widget.resultScore >= 31) return 'Pretty likeable!';
    if (widget.resultScore >= 21) return 'You need to work more!';
    if (widget.resultScore >= 1) return 'You need to work hard!';
    return 'This is a poor score!';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Result Phrase
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 1),
              child: Text(
                resultPhrase,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Score
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 1),
              child: Text(
                'Score: ${widget.resultScore}',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black54,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Restart Button with Slide Transition
            SlideTransition(
              position: _buttonAnimation,
              child: TextButton(
                onPressed: () => widget.resetHandler(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF34e89e), Color(0xFF0f3443)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 24.0),
                  child: const Text(
                    'Restart Quiz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
