import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math; // Import dart:math

class JobOffer extends StatefulWidget {
   final void Function()? onTap;
  const JobOffer({super.key, this.onTap});

  @override
  State<JobOffer> createState() => _JobOfferState();
}

class _JobOfferState extends State<JobOffer>
  with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: const Duration(seconds: 1))..repeat(reverse: true); 
    _colorAnimation = ColorTween( begin: Colors.orange,end: Colors.purple,).animate(_animationController);
    _rotationAnimation = Tween<double>(begin: 7, end: 2 * math.pi) .animate(_animationController);
  }

  @override
  void dispose() {
     _animationController.dispose(); // Dispose of controller
    super.dispose();
  }

  void _onProject() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Project clicked')),
    );
  }

  void _onUnproject() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unproject clicked')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder( animation: _animationController, builder: (context, child) {
                return Transform.rotate( angle: _rotationAnimation.value,
                  child: ClipPath(clipper: StarClipper(8), // Banner type star with 8 points
                    child: InkWell(onTap:widget.onTap ,
                      child: Container( height: 50, width: 50,color: _colorAnimation.value, // Apply animated color
                        child: const Center( 
                          child: Text( "Job",style: TextStyle(color: appColorPrimary, fontSize: 10, fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
 }
}

// Custom StarClipper class
class StarClipper extends CustomClipper<Path> {
  final int points;

  StarClipper(this.points);

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;
    final double radius = halfWidth;
    final double innerRadius = radius / 2.5;
    final double angle = (2 * math.pi) / points; // Use math.pi

    for (int i = 0; i < points; i++) {
      double outerAngle = angle * i;
      double innerAngle = outerAngle + angle / 15;

      double x1 = halfWidth + radius * math.cos(outerAngle); // Use math.cos
      double y1 = halfHeight + radius * math.sin(outerAngle); // Use math.sin

      double x2 = halfWidth + innerRadius * math.cos(innerAngle); // Use math.cos
      double y2 = halfHeight + innerRadius * math.sin(innerAngle); // Use math.sin

      if (i == 0) {
        path.moveTo(x1, y1);
      } else {
        path.lineTo(x1, y1);
      }
      path.lineTo(x2, y2);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
