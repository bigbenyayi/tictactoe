import 'dart:math';

import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final List<int> winningLine;
  final double progress;
  final Color color;
  final int gridSize;
  final double spacing;

  WinningLinePainter({
    required this.winningLine,
    required this.progress,
    required this.color,
    required this.gridSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint glowPaint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = (12 - gridSize).toDouble()
      ..strokeCap = StrokeCap.round;

    final double cellWidth = (size.width - (gridSize - 1) * spacing) / gridSize;
    final double cellHeight = (size.height - (gridSize - 1) * spacing) / gridSize;

    // This offset corrects the cell's vertical alignment, ensuring the line is centered.
    const double verticalOffset = 4.0;

    // Calculate the center of the first and last cells
    final int startCol = winningLine.first % gridSize;
    final int startRow = winningLine.first ~/ gridSize;
    final double startXCenter = startCol * (cellWidth + spacing) + cellWidth / 2;
    final double startYCenter = startRow * (cellHeight + spacing) + cellHeight / 2 - verticalOffset;

    final int endCol = winningLine.last % gridSize;
    final int endRow = winningLine.last ~/ gridSize;
    final double endXCenter = endCol * (cellWidth + spacing) + cellWidth / 2;
    final double endYCenter = endRow * (cellHeight + spacing) + cellHeight / 2 - verticalOffset;

    // Calculate the direction vector of the line
    final double dx = endXCenter - startXCenter;
    final double dy = endYCenter - startYCenter;

    // Normalize the direction vector
    final double length = sqrt(dx * dx + dy * dy);
    if (length == 0) return; // Should not happen for a winning line
    final double unitX = dx / length;
    final double unitY = dy / length;

    // Extend the line beyond the cells
    final double extension = cellWidth * 0.6; // Extend by 60% of cell width on each side

    final double startX = startXCenter - unitX * extension;
    final double startY = startYCenter - unitY * extension;
    final double endX = endXCenter + unitX * extension;
    final double endY = endYCenter + unitY * extension;

    // Animate the line drawing
    final double currentEndX = startX + (endX - startX) * progress;
    final double currentEndY = startY + (endY - startY) * progress;

    final Offset startOffset = Offset(startX, startY);
    final Offset endOffset = Offset(currentEndX, currentEndY);

    canvas
      ..drawLine(startOffset, endOffset, glowPaint)
      ..drawLine(startOffset, endOffset, paint);
  }

  @override
  bool shouldRepaint(covariant WinningLinePainter oldDelegate) {
    return oldDelegate.winningLine != winningLine ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.gridSize != gridSize ||
        oldDelegate.spacing != spacing;
  }
}
