import 'package:flutter/material.dart';

import '../widgets/browse_disease_widget.dart';
import '../Mapping/mapping_upload.dart';

class BrowseDiseases1 extends StatelessWidget {
  const BrowseDiseases1({super.key});

  @override
  String HandlePrevention(List<String>? prev) {
    String result = "";
    if(prev != null)
    for (var i = 0; i < prev.length; i++) {
      result += "${i+1}- " + prev[i] + "\n\n";
    }
    return result;
  }

  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final disease = args['disease'] as MappingUpload;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BrowseDiseaseWidget(
          bacteraia_text_bar: disease.Name as String,
          Description_text: disease.Description as String,
          Prevention_text: HandlePrevention(disease.preventions),
        ),
      ),
    );
  }
}
