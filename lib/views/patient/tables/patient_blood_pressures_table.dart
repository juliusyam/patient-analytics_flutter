import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';

class PatientBloodPressuresTable extends StatelessWidget {
  // TODO: Check if can add const
  PatientBloodPressuresTable({super.key, required this.entries, this.limit});

  final List<PatientBloodPressure> entries;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    Iterable<PatientBloodPressure> finalizedEntries = (limit != null)
        ? entries.take(limit!)
        : entries;

    List<TableRow> bloodPressureWidgets = [];
    for (var entry in finalizedEntries) {
      bloodPressureWidgets.add(
        TableRow(children: <Container>[
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Text(DateFormat('yyyy-MM-dd').format(entry.dateCreated)),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Text(entry.bloodPressureSystolic.toString()),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Text(entry.bloodPressureDiastolic.toString()),
          ),
        ]),
      );
    }

    return Hero(
      tag: 'patient-blood-pressures-table',
      transitionOnUserGestures: true,
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(children: <Container>[
            Container(
                padding: const EdgeInsets.all(5.0),
                child: const Text('Date Created')),
            Container(
                padding: const EdgeInsets.all(5.0),
                child: const Text('Systolic')),
            Container(
                padding: const EdgeInsets.all(5.0),
                child: const Text('Diastolic')),
          ]),
          ...bloodPressureWidgets,
        ],
      ),
    );
  }
}
