// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart' show LoadingAnimationWidget;
// import 'package:sizer/sizer.dart';
// import 'package:http/http.dart' as http;
// import '../../../../core/utils/constants.dart';
// import '../../../../core/Mapping/mapping_upload.dart';
// import '../../../../core/helper/token.dart';
// import 'widgets/doctor_ask_widget.dart';
// import '../../../../core/widgets/bar_pages_widget.dart';
// import 'widgets/content_result.dart';

// class InfectionPage extends StatefulWidget {
//   final int id;

//   const InfectionPage({super.key, required this.id});

//   @override
//   State<InfectionPage> createState() => _InfectionPageState();
// }

// class _InfectionPageState extends State<InfectionPage> {
//   MappingUpload? data;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     GetDetails();
//   }

//   Future<void> GetDetails() async {
//     final url = Uri.parse("$resourceUrl/api/Wound/get-id?id=${widget.id}");
//     String? token = await Tokens.retrieve('access_token');

//     final headers = {"Authorization": "Bearer $token"};
//     try {
//       final response = await http.get(url, headers: headers);

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         setState(() {
//           data = MappingUpload(responseJson: jsonResponse);
//           isLoading = false;
//         });
//       } else {
//         setState(() => isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to load data: ${response.statusCode}'),
//         ));
//       }
//     } catch (error) {
//       setState(() => isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error occurred: $error'),
//       ));
//     }
//   }

//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: isLoading
//           ? Center(
//               child:
//                   LoadingAnimationWidget.inkDrop(
//                     color: PrimaryColor,
//                     size: 40,
//                   )) // Display loading indicator while data is being fetched
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 5.h),

//                   BarPagesWidget(title: 'Result'),
//                   SizedBox(height: 3.h),

//                   // Image Section
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: const Color(0xFF34539D),
//                           width: 2.w,
//                         ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(0),
//                         child: data?.image != null
//                             ? Image.memory(
//                                 base64Decode(data!.image as String),
//                                 width: 60.w,
//                                 height: 35.h,
//                                 fit: BoxFit.cover,
//                               )
//                             : Container(
//                                 // Fallback in case the image is null or unavailable
//                                 width: 70.w,
//                                 height: 30.h,
//                                 color: Colors.grey, // Placeholder color
//                                 child: Icon(Icons.image,
//                                     size: 10.w, color: Colors.white),
//                               ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 2.h),

//                   // Information Container
//                   Container(
//                     padding: EdgeInsets.all(3.w),
//                     margin: EdgeInsets.symmetric(horizontal: 8.w),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFD5E1FF),
//                       borderRadius: BorderRadius.circular(3.w),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Name Section
//                         ContentResult(label: 'Name:',value:  data?.Name ?? 'Unknown'),
//                         SizedBox(height: 2.h),
//                         Divider(color: Colors.black, thickness: 0.2.w),
//                         SizedBox(height: 1.h),

//                         // Risk Section
//                         ContentResult(label: 'Risk:',value:  data?.risk ?? 'N/A'),
//                         SizedBox(height: 2.h),
//                         Divider(color: Colors.black, thickness: 0.2.w),
//                         SizedBox(height: 1.h),

//                         // Details Section
//                         ContentResult(label: 'Details:',value: 
//                             data?.description ?? 'No details available'),
//                         SizedBox(height: 2.h),

//                         // More Info
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   '/BrowseDisease_page',
//                                   arguments: {'disease': data},
//                                 );
//                               },
//                               child: Text(
//                                 'Describe more..',
//                                 style: TextStyle(
//                                   fontSize: 15.sp, // Responsive text size
//                                   fontWeight: FontWeight.w900,
//                                   color: const Color(0xFF34539D),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 3.h),

//                   // Ask Doctor Button
//                   SizedBox(height: 2.h),
//                   const DoctorAskWidget(),
//                   SizedBox(height: 2.h),
//                 ],
//               ),
//             ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/bar_pages_widget.dart';
import '../view_models/infection_cubit.dart';
import 'widgets/content_result.dart';
import 'widgets/doctor_ask_widget.dart';

class InfectionPage extends StatelessWidget {
  final int id;
  const InfectionPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InfectionCubit()..getDetails(id),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<InfectionCubit, InfectionState>(
          listener: (context, state) {
            if (state is InfectionError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is InfectionLoading || state is InfectionInitial) {
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: PrimaryColor,
                  size: 40,
                ),
              );
            }

            if (state is InfectionLoaded) {
              final data = state.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    BarPagesWidget(title: 'Result'),
                    SizedBox(height: 3.h),

                    /// Image Section
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF34539D),
                            width: 2.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: data.image != null
                              ? Image.memory(
                                  base64Decode(data.image as String),
                                  width: 60.w,
                                  height: 35.h,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 70.w,
                                  height: 30.h,
                                  color: Colors.grey,
                                  child: Icon(Icons.image,
                                      size: 10.w, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    /// Info Section
                    Container(
                      padding: EdgeInsets.all(3.w),
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD5E1FF),
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContentResult(label: 'Name:', value: data.Name ?? 'Unknown'),
                          SizedBox(height: 2.h),
                          Divider(color: Colors.black, thickness: 0.2.w),
                          SizedBox(height: 1.h),

                          ContentResult(label: 'Risk:', value: data.risk ?? 'N/A'),
                          SizedBox(height: 2.h),
                          Divider(color: Colors.black, thickness: 0.2.w),
                          SizedBox(height: 1.h),

                          ContentResult(
                              label: 'Details:',
                              value: data.description ?? 'No details available'),
                          SizedBox(height: 2.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/BrowseDisease_page',
                                    arguments: {'disease': data},
                                  );
                                },
                                child: Text(
                                  'Describe more..',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF34539D),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                    const DoctorAskWidget(),
                    SizedBox(height: 2.h),
                  ],
                ),
              );
            }

            if (state is InfectionError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
