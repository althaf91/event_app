import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Color color;
  final String name;
  final bool selected;
  const CategoryItem({super.key,required this.color,required this.name,required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right:8),
      decoration: BoxDecoration(
        color: selected ? color.withOpacity(0.5) : color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Icon(
            Icons.trip_origin_rounded,
            color: color,
            size:18,
          ),
           const SizedBox(width: 5,),
           Text(name,style:const TextStyle(
              fontFamily: 'SFUIText',
              fontSize: 14,
              fontWeight: FontWeight.w500
          ))
        ],
      ),
    );
  }
}
