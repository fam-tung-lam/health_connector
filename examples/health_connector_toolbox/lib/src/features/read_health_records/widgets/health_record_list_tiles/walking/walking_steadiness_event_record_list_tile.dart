import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/base_health_record_list_tile.dart';

class WalkingSteadinessEventRecordListTile extends StatelessWidget {
  const WalkingSteadinessEventRecordListTile({
    required this.record,
    super.key,
  });

  final WalkingSteadinessEventRecord record;

  @override
  Widget build(BuildContext context) {
    return BaseHealthRecordListTile(
      icon: Icons.directions_walk_outlined,
      title: AppTexts.walkingSteadinessEvent,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${AppTexts.type}: ${_getTypeLabel(record.type)}'),
        ],
      ),
      detailRows: const [],
      metadata: record.metadata,
    );
  }

  String _getTypeLabel(WalkingSteadinessType type) {
    return switch (type) {
      WalkingSteadinessType.initialLow => AppTexts.initialLow,
      WalkingSteadinessType.repeatLow => AppTexts.repeatLow,
      WalkingSteadinessType.initialVeryLow => AppTexts.initialVeryLow,
      WalkingSteadinessType.repeatVeryLow => AppTexts.repeatVeryLow,
    };
  }
}
