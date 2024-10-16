import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:patient_analytics_flutter/components/table/table_cell_container.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_blood_pressure.dart';

class PatientBloodPressuresTable extends StatelessWidget {
  const PatientBloodPressuresTable({
    super.key,
    required this.entries,
    this.limit,
  });

  final List<PatientBloodPressure> entries;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    Iterable<PatientBloodPressure> finalizedEntries =
        (limit != null) ? entries.take(limit!) : entries;

    final localisations = AppLocalizations.of(context)!;

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
              entry.bloodPressureSystolicFormatted,
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.bloodPressureDiastolicFormatted,
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
              child: Text(
                localisations.table_header_date_created,
                style: context.body.regular,
              ),
            ),
            TableCellContainer(
              child: Text(
                localisations.table_header_sys,
                style: context.body.regular,
              ),
            ),
            TableCellContainer(
              child: Text(
                localisations.table_header_dia,
                style: context.body.regular,
              ),
            ),
            TableCellContainer(
              child: Text(
                localisations.table_header_status,
                style: context.body.regular,
              ),
            ),
          ]),
          ...bloodPressureWidgets,
        ],
      ),
    );
  }
}
