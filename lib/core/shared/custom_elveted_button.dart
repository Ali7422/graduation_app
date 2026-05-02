import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_text_theme.dart';

class AnimatedGlassButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  final String colorType; // "red" or "green"

  const AnimatedGlassButton({
    super.key,
    required this.title,
    required this.colorType,
    this.onPressed,
  });

  @override
  State<AnimatedGlassButton> createState() => _AnimatedGlassButtonState();
}

class _AnimatedGlassButtonState extends State<AnimatedGlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        late Color color1;
        late Color color2;

        if (widget.colorType == "red") {
          color1 = Color.lerp(
            const Color.fromARGB(255, 255, 3, 40),
            const Color.fromARGB(255, 250, 92, 7),
            _controller.value,
          )!;
          color2 = Color.lerp(
            const Color.fromARGB(255, 250, 7, 7),
            const Color.fromARGB(255, 5, 68, 216),
            1 - _controller.value,
          )!;
        } else if (widget.colorType == "green") {
           color1 = Color.lerp(
            const Color.fromARGB(255, 14, 111, 238),
            const Color.fromARGB(255, 29, 254, 228),
            _controller.value,
          )!;
          color2 = Color.lerp(const Color.fromARGB(255, 37, 205, 57), Colors.greenAccent, 1 - _controller.value)!;
        } else {
          color1 = Color.lerp(
            Colors.blueAccent,
            Colors.cyanAccent,
            _controller.value,
          )!;
          color2 = Color.lerp(Colors.blue, Colors.cyan, 1 - _controller.value)!;
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color1.withOpacity(0.6), color2.withOpacity(0.3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: TextStyleHelper.font18WhiteBold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
