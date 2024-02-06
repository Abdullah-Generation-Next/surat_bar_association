import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  const CommonTextFormField({
    Key? key,
    required this.controller,
    required this.number,
    required this.maxlength,
    this.isPasswordField = true,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType number;
  final bool isPasswordField;
  final int maxlength;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  // textfild text = Get.put(textfild());
  bool isPasswordField = false;

  final ValueNotifier<bool> isFieldEmpty = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 35,
            child: ValueListenableBuilder(
              valueListenable: isFieldEmpty,
              builder: (context, value, child) => Container(
                width: double.infinity,
                // padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // border: Border.all(width: 2, color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: TextField(
                  keyboardType: widget.number,
                  maxLength: widget.maxlength,
                  autocorrect: true,
                  // autofocus: true,
                  // maxLengthEnforcement: MaxLengthEnforcement.none,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: widget.controller,
                  cursorColor: Colors.black87,
                  cursorHeight: 30,
                  cursorWidth: 1.5,
                  obscureText: isPasswordField,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      isFieldEmpty.value = true;
                    } else {
                      isFieldEmpty.value = false;
                    }
                  },
                  decoration: InputDecoration(
                      suffixIcon: widget.isPasswordField
                          ? CustomIconButton(
                        onPressed: (val) => setState(() => isPasswordField = val),
                      )
                          : const SizedBox(),
                      counterText: '',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff294472),width: 0.5),),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: value ? Colors.red : Colors.green,
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({Key? key, required this.onPressed}) : super(key: key);

  final void Function(bool) onPressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isButtonPressed = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() => isButtonPressed = !isButtonPressed);
        widget.onPressed(isButtonPressed);
      },
      splashRadius: 20.0,
      icon: Icon(
        isButtonPressed ? Icons.visibility_off : Icons.visibility,
        color: Color(0xff294472),
      ),
    );
  }
}

