import 'package:flutter/material.dart';

import '../../widgets/browse_disease_widget.dart';
import '../../Mapping/mapping_upload.dart';

class DetailsDiseases extends StatelessWidget {
  const DetailsDiseases({super.key});

  @override
  String HandlePrevention(List<dynamic>? prev) {
    final listResult = prev?.map((item) => item.toString()).toList();
    String result = "";
    if (prev != null)
      for (var i = 0; i < prev.length; i++) {
        result += "${i + 1}- " + prev[i] + "\n\n";
      }
    return result;
  }

  Widget build(BuildContext context) {
    // Retrieve the arguments from the ModalRoute
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BrowseDiseaseWidget(
          bacteraia_text_bar: args['data']['name'] as String,
          Description_text: args['data']['description'] as String,
          Prevention_text: HandlePrevention(args['data']['preventions']),
        ),
      ),
    );
  }
}
