import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String lastMessage; // New parameter for the last message
  final void Function()? onTap;
  const UserTile(
      {super.key, required this.text, this.onTap, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    final firstLetter = text.split('');
    return ListTile(
      onTap: onTap,
      leading: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        child: Text(
          firstLetter[0].toUpperCase(),
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      title: Text(text),
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Theme.of(context).colorScheme.inversePrimary,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(lastMessage),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.inversePrimary,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}


// GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.secondary,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                   shape: BoxShape.circle, color: Colors.green),
//               padding: const EdgeInsets.all(12.0),
//               child: Text(
//                 firstLetter[0].toUpperCase(),
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Text(text),
//           ],
//         ),
//       ),
//     );