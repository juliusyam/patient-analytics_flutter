import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:patient_analytics_flutter/components/table/table_cell_container.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_temperature.dart';

class PatientTemperaturesTable extends StatelessWidget {
  const PatientTemperaturesTable({
    super.key,
    required this.entries,
    this.limit,
  });

  final List<PatientTemperature> entries;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    Iterable<PatientTemperature> finalizedEntries =
        (limit != null) ? entries.take(limit!) : entries;

    final localisations = AppLocalizations.of(context)!;

    List<TableRow> temperatureWidgets = [];
    for (var entry in finalizedEntries) {
      temperatureWidgets.add(
        TableRow(children: <TableCellContainer>[
          TableCellContainer(
            child: Text(
              DateFormat('yyyy-MM-dd').format(entry.dateCreated),
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.temperatureCelsiusFormatted,
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.temperatureFahrenheitFormatted,
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              "${entry.doctor?.firstName} ${entry.doctor?.lastName}",
              style: context.body.regular,
            ),
          ),
        ]),
      );
    }

    return Hero(
      tag: 'patient-temperatures-table',
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
                localisations.table_header_celsius,
                style: context.body.regular,
              ),
            ),
            TableCellContainer(
              child: Text(
                localisations.table_header_fahrenheit,
                style: context.body.regular,
              ),
            ),
            TableCellContainer(
              child: Text(
                localisations.table_header_entry_creator,
                style: context.body.regular,
              ),
            ),
          ]),
          ...temperatureWidgets,
        ],
      ),
    );
  }
}
