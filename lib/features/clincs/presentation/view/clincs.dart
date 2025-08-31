import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;
import 'package:sizer/sizer.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/bar_pages_widget.dart';
import '../../../doctors/presentation/view/doctor_info.dart';

class Clincs extends StatefulWidget {
  const Clincs({super.key});

  @override
  State<Clincs> createState() => _ClincsState();
}

class _ClincsState extends State<Clincs> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  List<dynamic> clinicsList = [];
  bool isSearched = false;

  Future<void> fetchClinicsByLocation(String location) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('$resourceUrl/api/pharmacy/$location');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        print(responseJson);
        if (!mounted) return;
        setState(() {
          clinicsList = responseJson;
          isLoading = false;
        });
      } else {
        print("Failed: ${response.body}");
        if (!mounted) return;

        setState(() {
          isLoading = false;
          clinicsList = [];
          print(clinicsList);
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
        clinicsList = [];
      });
    }
  }

  Widget buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search about location',
        prefixIcon: Icon(Icons.search, size: 6.w),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.w),
          borderSide: BorderSide.none,
        ),
      ),
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          fetchClinicsByLocation(value.trim());
          setState(() {
            isSearched = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarPagesWidget(
        title: 'Clinics',
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSearched) ...[
              buildSearchBar(),
              SizedBox(height: 2.h),
            ],
            Expanded(
              child: Column(
                children: [
                  if (!isSearched) ...[
                    buildSearchBar(),
                    SizedBox(height: 2.h),
                  ],
                  Expanded(
                    child: isLoading
                        ? Center(
                            child: LoadingAnimationWidget.inkDrop(
                            color: PrimaryColor,
                            size: 40,
                          ))
                        : clinicsList.isEmpty
                            ? const Center(
                                child: Text(
                                    "there is no clinic please search to find it."),
                              )
                            : ListView.builder(
                                itemCount: clinicsList.length,
                                itemBuilder: (context, index) {
                                  final clinic = clinicsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoctorInfo(
                                            id: clinic['id']?.toString() ?? "",
                                          ),
                                        ),
                                      ).then((_) {
                                        if (mounted) {
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: AppointmentCard(
                                      doctorName: clinic['name'] ?? "Unknown",
                                      clincName: clinic['name'] ?? "Unknown",
                                      Location: clinic['location'] ??
                                          "Unknown location",
                                      time: '',
                                      rating: (4.0).toDouble(),
                                      imageUrl: 'Images/user.png',
                                      onDelete: () {},
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     TextField(
        //       controller: _searchController,
        //       decoration: InputDecoration(
        //         hintText: 'Search about location',
        //         prefixIcon: Icon(Icons.search, size: 6.w),
        //         filled: true,
        //         fillColor: Colors.grey[200],
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(5.w),
        //           borderSide: BorderSide.none,
        //         ),
        //       ),
        //       onSubmitted: (value) {
        //         if (value.trim().isNotEmpty) {
        //           fetchClinicsByLocation(value.trim());
        //           setState(() {
        //             isSearched = true;
        //           });
        //         }
        //       },
        //     ),
        //     SizedBox(height: 2.h),
        //     Expanded(
        //       child: isLoading
        //           ? const Center(
        //               child: CircularProgressIndicator(color: PrimaryColor),
        //             )
        //           : clinicsList.isEmpty
        //               ? Center(
        //                   child: Text("Please Search About Existing Location"),
        //                 )
        //               : ListView.builder(
        //                   itemCount: clinicsList.length,
        //                   itemBuilder: (context, index) {
        //                     final clinic = clinicsList[index];
        //                     return GestureDetector(
        //                       onTap: () {
        //                         Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                               builder: (context) => DoctorInfo(
        //                                     id: clinic['id']?.toString() ?? "",
        //                                   )),
        //                         ).then((_) {
        //                           if (mounted) {
        //                             setState(() {});
        //                           }
        //                         });
        //                       },
        //                       child: AppointmentCard(
        //                         doctorName: clinic['name'] ?? "Unknown",
        //                         clincName: clinic['name'] ?? "Unknown",
        //                         Location:
        //                             clinic['location'] ?? "Unknown location",
        //                         time: '',
        //                         rating: (4.0).toDouble(),
        //                         imageUrl: 'Images/user.png',
        //                         onDelete: () {},
        //                       ),
        //                     );
        //                   },
        //                 ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String clincName;
  final String time;
  final String Location;
  final double rating;
  final String imageUrl;
  final VoidCallback onDelete;

  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.clincName,
    required this.Location,
    required this.time,
    required this.rating,
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
              radius: 7.w,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Dr.$doctorName's clinic",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 4.5.w,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 10.w),
                      Icon(Icons.star, color: Colors.amber, size: 4.w),
                      Text(rating.toStringAsFixed(1),
                          style: TextStyle(fontSize: 4.w)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 4.w,
                        color: PrimaryColor,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        Location,
                        style: TextStyle(color: PrimaryColor, fontSize: 3.5.w),
                      ),
                    ],
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
