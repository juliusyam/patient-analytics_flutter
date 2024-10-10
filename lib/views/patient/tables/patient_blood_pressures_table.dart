import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:patient_analytics_flutter/components/table/table_cell_container.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';

class PatientBloodPressuresTable extends StatelessWidget {
  // TODO: Check if can add const
  PatientBloodPressuresTable({super.key, required this.entries, this.limit});

  final List<PatientBloodPressure> entries;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    Iterable<PatientBloodPressure> finalizedEntries =
        (limit != null) ? entries.take(limit!) : entries;

    List<TableRow> bloodPressureWidgets = [];
    for (var entry in finalizedEntries) {
      bloodPressureWidgets.add(
        TableRow(children: <TableCellContainer>[
          TableCellContainer(
            child: Text(
              DateFormat('yyyy-MM-dd').format(entry.dateCreated),
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.bloodPressureSystolic.toString(),
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.bloodPressureDiastolic.toString(),
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.status,
              style: context.body.regular,
            ),
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
          3: FlexColumnWidth(2),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(children: <TableCellContainer>[
            TableCellContainer(
              child: Text('Date Created', style: context.body.regular),
            ),
            TableCellContainer(
              child: Text('SYS', style: context.body.regular),
            ),
            TableCellContainer(
              child: Text('DIA', style: context.body.regular),
            ),
            TableCellContainer(
              child: Text('Status', style: context.body.regular),
            ),
          ]),
          ...bloodPressureWidgets,
        ],
      ),
    );
  }
}
