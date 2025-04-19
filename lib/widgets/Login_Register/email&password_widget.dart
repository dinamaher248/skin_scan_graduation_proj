import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmailPassWidget extends StatefulWidget {
  final String mailPassText;
  final IconData icon;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType; //  for custom keyboard type
  final bool readOnly;
  final VoidCallback? onTap;

  const EmailPassWidget({
    Key? key,
    required this.mailPassText,
    required this.icon,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<EmailPassWidget> createState() => _EmailPassWidgetState();
}

class _EmailPassWidgetState extends State<EmailPassWidget> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 6.6.h,
          width: 86.5.w,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.h),
            ),
            color: const Color.fromARGB(255, 231, 235, 250),
            child: TextFormField(
              controller: widget.controller,
              readOnly: widget.readOnly,
              obscureText: widget.mailPassText == 'Password' ||
                      widget.mailPassText == 'Confirm Password'
                  ? !isPasswordVisible
                  : false,
              cursorColor: const Color(0xFF34539D),
              keyboardType: widget.keyboardType ??
                  (widget.mailPassText == 'Email'
                      ? TextInputType.emailAddress
                      : TextInputType.text),
              decoration: InputDecoration(
                labelText: widget.mailPassText,
                labelStyle: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF989898),
                ),
                suffixIcon: widget.mailPassText == 'Password' ||
                        widget.mailPassText == 'Confirm Password'
                    ? IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      )
                    : null,
                prefixIcon: Icon(
                  widget.icon,
                  size: 4.3.w,
                  color: const Color(0xFF34539D),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
                errorText: widget.errorText, 
              ),
              onTap: widget.onTap,
            ),
          ),
        ),
      ],
    );
  }
}




/*import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmailPassWidget extends StatefulWidget {
  final String mailPassText;
  final IconData icon;
  final TextEditingController? controller;
  final String? errorText; //  for error text
 final VoidCallback? onTap;
  const EmailPassWidget({
    Key? key,
    required this.mailPassText,
    required this.icon,
     this.controller,
     this.errorText,
      this.onTap,
  }) : super(key: key);

  @override
  State<EmailPassWidget> createState() => _EmailPassWidgetState();
}

class _EmailPassWidgetState extends State<EmailPassWidget> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 6.6.h,
          width: 86.5.w,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.h),
            ),
            color: const Color.fromARGB(255, 231, 235, 250),
            child: TextFormField(
              controller: widget.controller,
               readOnly: widget.onTap != null,
              obscureText: widget.mailPassText == 'Password' ||
                  widget.mailPassText == 'Confirm Password' ? !isPasswordVisible : false,
              
              // obscureText: true, // لإخفاء كلمة المرور
              cursorColor: const Color(0xFF34539D),
              decoration: InputDecoration(
                labelText: widget.mailPassText,
                labelStyle: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF989898),
                ),
                suffixIcon: widget.mailPassText == 'Password' ||
                  widget.mailPassText == 'Confirm Password'
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
                prefixIcon: Icon(
                  widget.icon,
                  size: 4.3.w,
                  color: const Color(0xFF34539D),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80.w),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
              keyboardType: widget.mailPassText == 'Email'
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your ${widget.mailPassText?.toLowerCase()}';
                }
                if (widget.mailPassText == 'Email') {
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                } else if (widget.mailPassText == 'Password') {
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long ';
                  }
                }
                return null;
              },
            ),
          ),
        ),
        // إذا كان هناك نص خطأ، سيتم عرضه هنا:
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Colors.red, fontSize: 15.sp),
            ),
          ),
      ],
    );
  }
}
*/