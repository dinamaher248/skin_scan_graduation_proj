import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/Mapping/mapping_users.dart';
import '../../../../core/helper/token.dart';
import '../../../chat/presentation/view/chat.dart';

class Users extends StatefulWidget {
  const Users({super.key});
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool is_doctor = false;
  String currentUserId = "";
  //   void Is() async {
  //   String ROLE = await Tokens.getRole(await Tokens.retrieve('access_token'));
  //   if (ROLE == "Doc") is_doctor = true;
  // }
  List<Widget> history = [];
  bool isLoading = true;
  List<MappingUsers> userInfo = [];

  @override
  void initState() {
    super.initState();
    getUserRoleAndId();
  }

  Future<void> getUserRoleAndId() async {
    String role = await Tokens.getRole(await Tokens.retrieve('access_token'));
    String id = await Tokens.getId(await Tokens.retrieve('access_token'));

    setState(() {
      is_doctor = (role == "Doc");
      currentUserId = id;
    });

    callEndPoint();
  }

  List<Widget> _listUsers(responseJson) {
    List<Widget> historyList = [];

    var mapResponse = mapjson(responseJson);
    for (var value in mapResponse) {
      if (value.userName != null && value.Id != currentUserId) {
        // Skip users with null usernames
        historyList.add(_buildUserCard(
          context: context,
          name: (value.userName == "Unknown") ? "Admin" : value.userName!,
          imagePath: 'Images/user.png',
          ratingSize: 4.h,
          iconSize: 3.5.h,
          id: value.Id!,
          //  email: value.Mail!,
        ));
        historyList.add(SizedBox(height: 3.h));
      }
    }

    return historyList;
  }

  List<MappingUsers> mapjson(List<dynamic> responseJson) {
    List<MappingUsers> maphistory = [];

    for (var value in responseJson) {
      maphistory.add(MappingUsers.list(value));
    }
    userInfo = maphistory;
    return maphistory;
  }

  void callEndPoint() async {
    final url = Uri.parse("$apiUrl/api/Auth/all");
    try {
      final response = await http.get(url);
      var responseJson = jsonDecode(response.body);

      print("Response JSON: $responseJson");

      if (responseJson is List) {
        setState(() {
          history = _listUsers(responseJson);
          isLoading = false;
          print("Users loaded successfully! Count: ${history.length}");
        });
      } else if (responseJson is Map<String, dynamic> &&
          responseJson.containsKey('data')) {
        List<dynamic> usersList = responseJson['data'];

        if (usersList.isEmpty) {
          print("No users found!");
          setState(() {
            isLoading = false;
          });
          return;
        }

        setState(() {
          history = _listUsers(usersList);
          isLoading = false;
          print("Users loaded successfully! Count: ${history.length}");
        });
      } else {
        print("Invalid response format!");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_circle_left_outlined,
                          size: 22.3.sp,
                          color: const Color(0xFF34539D),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text('User List',
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 17.5.sp,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                isLoading
                    ? Center(
                        child: LoadingAnimationWidget.inkDrop(
                        color: PrimaryColor,
                        size: 40,
                      ))
                    : Column(
                        children: history,
                      ),
              ],
            ),
          ],
        ));
  }

  Widget _buildUserCard({
    required BuildContext context,
    required String name,
    required String imagePath,
    required double ratingSize,
    required double iconSize,
    required String id,
    // required String email,
  }) {
    return Container(
      height: 10.h,
      width: 90.w,
      decoration: BoxDecoration(
        color: const Color(0xFFB8CDFF),
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.5.h),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: ClipOval(
                      child: Image.asset(
                        imagePath,
                        height: 5.h,
                        width: 5.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),

                  Padding(
                    padding: EdgeInsets.only(top: 1.w),
                    child: Text(
                      name,
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 40, 68, 131),
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // SizedBox(width: 1.h),
                  IconButton(
                    icon: Icon(Icons.message_outlined,
                        color: const Color(0xFF34539D), size: 3.h),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessagePage(
                                  idDoctor: id,
                                  userName: name,
                                )),
                      ).then((_) {
                        if (mounted) {
                          setState(() {});
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
