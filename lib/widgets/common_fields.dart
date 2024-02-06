import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'media_query_sizes.dart';

//=============================================================================
//===================Common TextField Login/Forgot Password====================

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.number,
    required this.hintText,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType number;
  final String hintText;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            widget.labelText,
            textScaleFactor: 1,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Container(
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.r,
                  spreadRadius: 0.1.r,
                )
              ]),
          child: TextField(
            autocorrect: true,
            textAlign: TextAlign.start,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            controller: widget.controller,
            keyboardType: widget.number,
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).textScaleFactor * 12,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 12,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenwidth(context, dividedby: 25.w),
                vertical: screenheight(context, dividedby: 75.h),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.r),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//=============================================================================
//========================Common TextField Edit Profile========================

class CommonEditTextField extends StatefulWidget {
  const CommonEditTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.number,
    required this.hintText,
    this.inputFormatters,
    this.length
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType number;
  final String hintText;
  final inputFormatters;
  final int? length;

  @override
  State<CommonEditTextField> createState() => _CommonEditTextFieldState();
}

class _CommonEditTextFieldState extends State<CommonEditTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            widget.labelText,
            textScaleFactor: 0.8,
            style:
                TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Container(
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            color: Colors.white12,
          ),
          child: TextFormField(
            autocorrect: true,
            textAlign: TextAlign.start,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            controller: widget.controller,
            keyboardType: widget.number,
            maxLength: widget.length,
            inputFormatters: widget.inputFormatters,
            style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor * 10,),
            decoration: InputDecoration(
              counterText: "",
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.white54,
                fontSize: MediaQuery.of(context).textScaleFactor * 10,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenwidth(context, dividedby: 25.w),
                vertical: screenheight(context, dividedby: 75.h),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.r),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//=============================================================================
//========================Common RadioButton Edit Profile========================

class CommonRadioButton extends StatefulWidget {
  const CommonRadioButton(
      {super.key,
      required this.labelText,
      required this.radioText1,
      required this.radioText2});

  final String labelText;
  final String radioText1;
  final String radioText2;

  @override
  State<CommonRadioButton> createState() => _CommonRadioButtonState();
}

class _CommonRadioButtonState extends State<CommonRadioButton> {
  int _radioSelected = 1;
  late String radioVal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            widget.labelText,
            textScaleFactor: 0.8,
            style:
                TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              value: 1,
              groupValue: _radioSelected,
              activeColor: Colors.white38,
              fillColor: MaterialStateProperty.all(Colors.white),
              onChanged: (value) {
                setState(() {
                  _radioSelected = value!;
                  radioVal = 'male';
                });
              },
            ),
            Text(
              widget.radioText1,
              textScaleFactor: 0.9,
              style: TextStyle(color: Colors.white),
            ),
            Radio(
              value: 2,
              groupValue: _radioSelected,
              activeColor: Colors.white38,
              fillColor: MaterialStateProperty.all(Colors.white),
              onChanged: (value) {
                setState(() {
                  _radioSelected = value!;
                  radioVal = 'female';
                });
              },
            ),
            Text(
              widget.radioText2,
              textScaleFactor: 0.9,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ],
    );
  }
}

//=============================================================================
//========================Common Password TextField===========================

class CommonPasswordTextField extends StatefulWidget {


  const CommonPasswordTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.number,
    required this.hintText,
    required this.isPasswordField, this.function,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType number;
  final String hintText;
  final bool isPasswordField;
  final String  Function(String?)? function;

  @override
  State<CommonPasswordTextField> createState() =>
      _CommonPasswordTextFieldState();
}

class _CommonPasswordTextFieldState extends State<CommonPasswordTextField> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            widget.labelText,
            textScaleFactor: 1,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Container(
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.r,
                  spreadRadius: 0.1.r,
                )
              ]),
          child: TextFormField(
            validator: widget.function,
            autocorrect: true,
            textAlign: TextAlign.start,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.done,
            controller: widget.controller,
            keyboardType: widget.number,
            obscureText: passwordVisible,
            // onChanged: (value) {
            //   if (value.isEmpty) {
            //     isFieldEmpty.value = true;
            //   } else {
            //     isFieldEmpty.value = false;
            //   }
            // },
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).textScaleFactor * 12,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: MediaQuery.of(context).textScaleFactor * 12,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenwidth(context, dividedby: 25.w),
                vertical: screenheight(context, dividedby: 55.h),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              // alignLabelWithHint: false,
              // filled: true,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.r),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
          ),
        ),
      ],
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
        isButtonPressed ? Icons.visibility_rounded : Icons.visibility_off_rounded,
        color: Colors.black,
      ),
    );
  }
}

//=============================================================================
//=========================Common Contact Us TextField=========================

class CommonContactTextField extends StatefulWidget {
  const CommonContactTextField({super.key,
    required this.controller,
    required this.labelText,
    required this.number,
    required this.hintText,
    this.validation, this.length});

  final TextEditingController controller;
  final String labelText;
  final TextInputType number;
  final String hintText;
  final validation;
  final int? length;

  @override
  State<CommonContactTextField> createState() => _CommonContactTextFieldState();
}

class _CommonContactTextFieldState extends State<CommonContactTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            widget.labelText,
            textScaleFactor: 0.8,
            style:
            TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        SizedBox(
          // constraints: BoxConstraints(),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(10.r)),
          //   color: Color(0xffeeeeee),
          //   border: Border.all(color: Colors.black12)
          // ),
          child: TextFormField(
            autocorrect: true,
            textAlign: TextAlign.start,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            controller: widget.controller,
            keyboardType: widget.number,
            maxLength:  widget.length,
            style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).textScaleFactor * 12
            ),
            validator: widget.validation,
            decoration: InputDecoration(
              fillColor: Color(0xffeeeeee),
              filled: true,
              counterText: "",
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
                fontSize: MediaQuery.of(context).textScaleFactor * 10,
                fontWeight: FontWeight.w500
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenwidth(context, dividedby: 25.w),
                vertical: screenheight(context, dividedby: 75.h),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
            ),
          ),
        ),
        // if (widget.validation != null)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 8.0),
        //     child: Text(
        //       widget.validation(widget.controller.text) ?? '',
        //       style: TextStyle(
        //         color: Colors.red, // Customize the color
        //         fontSize: 12.0, // Customize the font size
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
