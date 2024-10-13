import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:patient_analytics_flutter/components/table/table_cell_container.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_weight.dart';

class PatientWeightsTable extends StatelessWidget {
  const PatientWeightsTable({super.key, required this.entries, this.limit});

  final List<PatientWeight> entries;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    Iterable<PatientWeight> finalizedEntries =
        (limit != null) ? entries.take(limit!) : entries;

    final localisations = AppLocalizations.of(context)!;

    List<TableRow> weightWidgets = [];
    for (var entry in finalizedEntries) {
      weightWidgets.add(
        TableRow(children: <TableCellContainer>[
          TableCellContainer(
            child: Text(
              DateFormat('yyyy-MM-dd').format(entry.dateCreated),
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.weightKgFormatted,
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.weightLbFormatted,
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.weightStFormatted,
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
      tag: 'patient-weights-table',
      transitionOnUserGestures: true,
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(2),
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
                localisations.table_header_kg,
                style: context.body.regular,
              ),
            ),
            TableCellContainer(
              child: Text(
                localisations.table_header_lb,
                style: context.body.regular,
              ),
            ),
            TableCellContainer(
              child: Text(
                localisations.table_header_st,
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
          ...weightWidgets,
        ],
      ),
    );
  }
}
