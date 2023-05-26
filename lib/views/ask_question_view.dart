import 'package:flutter/material.dart';

class AskQuestionView extends StatelessWidget {
  final Function() onTap;
  final Function() onPan;
  final bool isDisappear;
  final bool allowSave;

  const AskQuestionView({
    Key? key,
    required this.onTap,
    required this.onPan,
    required this.isDisappear,
    required this.allowSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return allowSave
        ? const Center(
            child: Text('Cảm ơn'),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Tôi có đẹp trai không?'),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onTap,
                    child: buildButton(title: 'Yes'),
                  ),
                  if (!isDisappear) ...[
                    const SizedBox(
                      width: 32,
                    ),
                    Draggable(
                      feedback: Material(child: buildButton(title: 'No')),
                      childWhenDragging: const SizedBox(),
                      child: buildButton(title: 'No'),
                      onDraggableCanceled: (velocity, offset) {
                        onPan.call();
                      },
                    ),
                  ]
                ],
              )
            ],
          );
  }

  Widget buildButton({required String title}) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.blue,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
