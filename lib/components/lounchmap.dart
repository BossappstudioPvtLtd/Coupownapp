import 'package:flutter/material.dart';

class MapLaunch extends StatefulWidget {
  final void Function()? onPressed;
  final List<Color> colorsList;
  final IconData? icon;
  final String data;
  const MapLaunch({super.key, this.onPressed, required this.colorsList, this.icon, required this.data});

  @override
  State<MapLaunch> createState() => _MapLaunchState();
}

class _MapLaunchState extends State<MapLaunch> {
  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
                    onPressed:widget.onPressed,
                    style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    ),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return  LinearGradient(
                          colors: widget.colorsList,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(widget.icon),
                          const SizedBox(width: 8),
                          Text(
                            widget.data,
                            style: const TextStyle(
                              color: Colors.white, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
  }
}