import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;

  const CustomDataTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateColor.resolveWith(
            (states) => const Color.fromARGB(115, 0, 0, 0)),
        columns: columns.map((String column) {
          return DataColumn(
            label: Text(
              column,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          );
        }).toList(),
        rows: rows.map((List<String> row) {
          return DataRow(
            cells: row.map((String cell) {
              return DataCell(
                Text(cell),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

// CustomDataTable(
//   columns: ['Name', 'Age', 'City'],
//   rows: [
//     ['John Doe', '30', 'New York'],
//     ['Jane Smith', '25', 'London'],
//     ['Bob Johnson', '35', 'Paris'],
//   ],
// )