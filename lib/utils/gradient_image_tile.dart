import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sanskriti/utils/image_builder.dart';

class GradientTile extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final VoidCallback onTap;

  const GradientTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 200,
            child: Stack(children: [
              imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.fill,
                      frameBuilder: imageBuilder,
                      width: MediaQuery.of(context).size.width - 20,
                    )
                  : const Icon(Icons.image),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 0.9, 1],
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
