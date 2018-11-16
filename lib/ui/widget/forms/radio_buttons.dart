import 'package:flutter/material.dart';
import 'package:nigiru_kun/utils/effects/no_splach_factory.dart';

class RadioItem<T> {
  final T id;
  final String label;

  RadioItem({this.id, this.label});
}

class RadioButtons<T> extends StatelessWidget {
  final List<RadioItem<T>> items;
  final ValueChanged<T> onChange;
  final T value;
  final TextStyle labelTextStyle;

  RadioButtons({
    @required this.items,
    this.onChange,
    this.value,
    this.labelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items
          .map((item) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  child: Row(
                    children: [
                      Radio<T>(
                        value: item.id,
                        groupValue: value,
                        onChanged: onChange,
                      ),
                      Text(
                        item.label,
                        style: labelTextStyle,
                      ),
                    ],
                  ),
                  onTap: () => onChange(item.id),
                  splashFactory: const NoSplashFactory(),
                ),
              ))
          .toList(),
    );
  }
}
