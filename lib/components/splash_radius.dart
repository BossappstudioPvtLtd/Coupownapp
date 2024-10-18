import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_Pointer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SpalshRipple extends HookWidget {
  //final Shop shop;

  const SpalshRipple({Key? key,
  // required this.shop
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Independent controllers for each ripple with different timings
    final controllers = List.generate(4, (i) => useAnimationController(duration: Duration(seconds: i == 0 ? 3 : i == 1 ? 4 : i == 2 ? 5 : 2), ));

    // Independent animations with varying Tween values for radius and opacity
    final animations = [
      [ useAnimation(Tween<double>(begin: 0, end: 400).animate(CurvedAnimation(parent: controllers[0], curve: Curves.easeOut))),
                useAnimation(Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: controllers[0], curve: Curves.easeOut))),
              ],
      [ useAnimation(Tween<double>(begin: 0, end: 500).animate(CurvedAnimation(parent: controllers[1], curve: Curves.easeOut))),
                useAnimation(Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: controllers[1], curve: Curves.easeOut))),
              ],
      [ useAnimation(Tween<double>(begin: 0, end: 600).animate(CurvedAnimation(parent: controllers[2], curve: Curves.easeOut))),
                useAnimation(Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: controllers[2], curve: Curves.easeOut))),
              ],
    ];

    // Center circle animation remains constant
    final centerCircleRadiusAnimation = useAnimation(Tween<double>(begin: 0, end: 40).animate( CurvedAnimation(parent: controllers[3], curve: Curves.easeInOut),));
  // Start animations with delays for each ripple
    useEffect(() {controllers[0].repeat();Timer(const Duration(milliseconds: 600), () => controllers[1].repeat());Timer(const Duration(milliseconds: 1200), () => controllers[2].repeat()); controllers[3].repeat(reverse: true);
    return () => controllers.forEach((controller) => controller.dispose());}, []);

    final currentUser = FirebaseAuth.instance.currentUser;
    String? selectedFilter;
     return  Stack(children:[
        
          // Ripple effect with separate animation timings
          Center( child: CustomPaint( painter: MyPainter(
                animations[0][0], animations[0][1], 1.0, // First ripple
                animations[1][0], animations[1][1], 1.0, // Second ripple
                animations[2][0], animations[2][1], 1.0, // Third ripple
                centerCircleRadiusAnimation,
              ),
            ),
          ),
          // User profile image
          Center( child: Material( color: appColorPrimary, elevation: 20,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),child: currentUser == null
                      ? const Center(child: Text('No user logged in'))
                       : ClipRRect(  borderRadius: BorderRadius.circular(100.0),
                          child: CachedNetworkImage( imageUrl: currentUser.photoURL ?? '',width: 50, height: 50, fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.person,size: 20,),
                      ),
                    ),
            ),
          ),
        ],
      
    );
  }
}
