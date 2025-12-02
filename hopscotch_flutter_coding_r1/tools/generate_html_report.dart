import 'dart:io';

void main(List<String> args) async {
  final lcovPath = 'coverage${Platform.pathSeparator}lcov.info';
  final outDir = Directory('coverage${Platform.pathSeparator}html');
  if (!File(lcovPath).existsSync()) {
    stderr.writeln('coverage/lcov.info not found');
    exit(2);
  }

  if (!outDir.existsSync()) outDir.createSync(recursive: true);

  final content = await File(lcovPath).readAsString();
  final records = content.split('end_of_record');

  final rows = <Map<String, dynamic>>[];
  int totalLF = 0;
  int totalLH = 0;

  for (var rec in records) {
    rec = rec.trim();
    if (rec.isEmpty) continue;
    final lines = rec.split(RegExp(r'\r?\n'));
    String? file;
    int lf = 0;
    int lh = 0;
    for (var l in lines) {
      if (l.startsWith('SF:')) file = l.substring(3);
      if (l.startsWith('LF:')) lf = int.tryParse(l.substring(3)) ?? 0;
      if (l.startsWith('LH:')) lh = int.tryParse(l.substring(3)) ?? 0;
    }
    if (file == null) continue;
    totalLF += lf;
    totalLH += lh;
    final pct = lf > 0 ? (lh / lf) * 100.0 : 0.0;
    rows.add({'file': file, 'lf': lf, 'lh': lh, 'pct': pct});
  }

  final overallPct = totalLF > 0 ? (totalLH / totalLF) * 100.0 : 0.0;

  final buffer = StringBuffer();
  buffer.writeln('<!doctype html>');
  buffer.writeln('<html><head><meta charset="utf-8"><title>Coverage Report</title>');
  buffer.writeln('<style>body{font-family:Arial,Helvetica,sans-serif;padding:20px}table{border-collapse:collapse;width:100%}th,td{padding:8px;border:1px solid #ddd}th{background:#f4f4f4;text-align:left}tr:nth-child(even){background:#fafafa}.pct-low{color:#c62828}.pct-med{color:#ff8f00}.pct-high{color:#2e7d32}</style>');
  buffer.writeln('</head><body>');
  buffer.writeln('<h1>Coverage Report</h1>');
  buffer.writeln('<p>Generated from <code>coverage/lcov.info</code></p>');
  buffer.writeln('<h2>Summary</h2>');
  buffer.writeln('<p><strong>Total lines:</strong> $totalLF &nbsp;&nbsp; <strong>Covered:</strong> $totalLH &nbsp;&nbsp; <strong>Percent:</strong> ${overallPct.toStringAsFixed(2)}%</p>');
  buffer.writeln('<h2>Files</h2>');
  buffer.writeln('<table><thead><tr><th>File</th><th>Lines</th><th>Covered</th><th>Percent</th></tr></thead><tbody>');

  rows.sort((a, b) => b['pct'].compareTo(a['pct']));
  for (var r in rows) {
    final pct = r['pct'] as double;
    final cls = pct < 50 ? 'pct-low' : (pct < 85 ? 'pct-med' : 'pct-high');
    final file = (r['file'] as String).replaceAll('\\', '/');
    buffer.writeln('<tr>');
    buffer.writeln('<td><code>$file</code></td>');
    buffer.writeln('<td>${r['lf']}</td>');
    buffer.writeln('<td>${r['lh']}</td>');
    buffer.writeln('<td class="$cls">${pct.toStringAsFixed(2)}%</td>');
    buffer.writeln('</tr>');
  }

  buffer.writeln('</tbody></table>');
  buffer.writeln('<p>Note: This is a lightweight HTML summary generated from LCOV.</p>');
  buffer.writeln('</body></html>');

  final outFile = File('${outDir.path}${Platform.pathSeparator}index.html');
  await outFile.writeAsString(buffer.toString());
  print('Wrote ${outFile.path}');
}
