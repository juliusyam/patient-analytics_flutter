import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:patient_analytics_flutter/components/table/table_cell_container.dart';
import 'package:patient_analytics_flutter/extensions/text.dart';
import 'package:patient_analytics_flutter/models/patient_metrics/patient_height.dart';

class PatientHeightsTable extends StatelessWidget {
  const PatientHeightsTable({super.key, required this.entries, this.limit});

  final List<PatientHeight> entries;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    Iterable<PatientHeight> finalizedEntries =
        (limit != null) ? entries.take(limit!) : entries;

    final localisations = AppLocalizations.of(context)!;

    List<TableRow> heightWidgets = [];
    for (var entry in finalizedEntries) {
      heightWidgets.add(
        TableRow(children: <TableCellContainer>[
          TableCellContainer(
            child: Text(
              DateFormat('yyyy-MM-dd').format(entry.dateCreated),
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.heightCmFormatted,
              style: context.body.regular,
            ),
          ),
          TableCellContainer(
            child: Text(
              entry.heightFtFormatted,
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
      tag: 'patient-heights-table',
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
                localisations.table_header_cm,
                style: context.body.regular,
              ),
            ),
            TableCellContainer(
              child: Text(
                localisations.table_header_ft,
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
          ...heightWidgets,
        ],
      ),
    );
  }
}
