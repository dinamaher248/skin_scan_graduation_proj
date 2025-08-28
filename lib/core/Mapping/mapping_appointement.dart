class MappingAppointement {
  String? id;
  DateTime? appointmentDate;
  String? doctorId;
  String? doctorName;

  MappingAppointement({
    required this.id,
    required this.appointmentDate,
    required this.doctorId,
    required this.doctorName,
  });

  MappingAppointement.Default();

  factory MappingAppointement.fromJson(Map<String, dynamic> json) {
    return MappingAppointement(
      id: json['id']?.toString(),
      appointmentDate: json['appointmentDate'] != null
          ? DateTime.tryParse(json['appointmentDate'].toString()) ??
              DateTime.now()
          : null,
      doctorId: json['doctorId']?.toString(),
      doctorName: json['doctorName']?.toString(),
    );
  }

  // getters
  String? get Id => id;
  String? get DoctorId => doctorId;
  String? get DoctorName => doctorName;
  DateTime? get AppointmentDate => appointmentDate;
}
