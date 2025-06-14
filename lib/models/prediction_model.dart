class Prediction {
  final int id;
  final String createdAt;
  final String predictedMaintenanceDate;
  final int daysToMaintain;
  final double percentile;

  Prediction({
    required this.id,
    required this.createdAt,
    required this.predictedMaintenanceDate,
    required this.daysToMaintain,
    required this.percentile,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'] as int,
      createdAt: json['created_at'] as String,
      predictedMaintenanceDate: json['predicted_maintenance_date'] as String,
      daysToMaintain: json['days_to_maintain'] as int,
      percentile: (json['percentile'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'predicted_maintenance_date': predictedMaintenanceDate,
    'days_to_maintain': daysToMaintain,
    'percentile': percentile,
  };
}
