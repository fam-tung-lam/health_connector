import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/sort_descriptor_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group('SortDescriptorMapper', () {
    test(
      'should map SortDescriptor.timeAscending to SortOrderDto.timeAscending',
      () {
        final dto = SortDescriptor.timeAscending.toDto();
        expect(dto, SortOrderDto.timeAscending);
      },
    );

    test(
      'should map SortDescriptor.timeDescending to SortOrderDto.timeDescending',
      () {
        final dto = SortDescriptor.timeDescending.toDto();
        expect(dto, SortOrderDto.timeDescending);
      },
    );
  });
}
