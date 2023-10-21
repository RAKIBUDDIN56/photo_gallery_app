import 'package:flutter/material.dart';

class PhotoDownloadButton extends StatefulWidget {
  final IconData iconData;
  final Function onPressed;

  const PhotoDownloadButton(
      {super.key, required this.iconData, required this.onPressed});

  @override
  State<PhotoDownloadButton> createState() => _PhotoDownloadButtonState();
}

class _PhotoDownloadButtonState extends State<PhotoDownloadButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder?>(const CircleBorder()),
        backgroundColor: MaterialStateProperty.all<Color?>(Colors.white),
      ),
      child: Icon(
        widget.iconData,
      ),
      onPressed: () => widget.onPressed(),
    );
  }
}
