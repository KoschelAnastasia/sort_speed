import 'package:flutter_test/flutter_test.dart';
import 'package:sort_speed/logic/sort.dart';

void main() {
  test('Bubble Sort:', () {
    expect(Sort.bubbleSort([5, 3, 4, 1, 2, 7, 9, 8, 6]), [1, 2, 3, 4, 5, 6, 7, 8, 9]);
  });

  test('Merge Sort:', () {
    expect(Sort.mergeSort([5, 3, 4, 1, 2, 7, 9, 8, 6]), [1, 2, 3, 4, 5, 6, 7, 8, 9]);
  });
  test('Shell Sort: ', () {
    expect(Sort.shellSort([5, 3, 4, 1, 2, 7, 9, 8, 6]), [1, 2, 3, 4, 5, 6, 7, 8, 9]);
  });
}
