abstract class Sort {
  static List<int> bubbleSort(List<int> list) {
    final sortList = List<int>.from(list);
    bool swapped = false;
    int n = sortList.length;
    for (int i = 0; i <= sortList.length - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (sortList[j] > sortList[j + 1]) {
          int temporary = sortList[j];
          sortList[j] = sortList[j + 1];
          sortList[j + 1] = temporary;
          swapped = true;
        }
        if (!swapped) {
          break;
        }
      }
    }

    return sortList;
  }

  static List<int> mergeSort(List<int> list) {
    List<int> sortList = List<int>.from(list);
    // Base case: if the list is empty or has one item, return the list
    if (sortList.length <= 1) {
      return sortList;
    }
    // Split the list in half
    int middle = sortList.length ~/ 2;
    // Take the left half of the list
    List<int> left = sortList.sublist(0, middle);
    // Take the right half of the list
    List<int> right = sortList.sublist(middle, sortList.length);

    return merge(mergeSort(left), mergeSort(right));
  }

  static List<int> merge(List<int> left, List<int> right) {
    List<int> result = [];
    int i = 0;
    int j = 0;

    while (i < left.length && j < right.length) {
      // If the left element is less than the right element, add the left element to the result list
      if (left[i] <= right[j]) {
        result.add(left[i]);
        i++;
      } else {
        // If the right element is less than the left element, add the right element to the result list
        result.add(right[j]);
        j++;
      }
    }
// Add the remaining elements of left Array to the result list
    while (i < left.length) {
      result.add(left[i]);
      i++;
    }
    // Add the remaining elements of right Array to the result list
    while (j < right.length) {
      result.add(right[j]);
      j++;
    }
    return result;
  }

  static List<int> shellSort(List<int> list) {
    final sortList = List<int>.from(list);
    // Start with a big gap
    int interval = sortList.length ~/ 2;
    // If the interval is greater than 0, perform the following steps
    while (interval > 0) {
      // If the element at the index of the intervals is less then list.length,
      //go through the list starting with the element at the index of the interval
      for (int i = interval; i < sortList.length; i++) {
        int temp = sortList[i];
        int j = i;
        // If j greater than or equal to interval and the element at position j - interval is
        //greater than temp. This loop is used to move list items if they are larger than the current item.
        while (j >= interval && sortList[j - interval] > temp) {
          sortList[j] = sortList[j - interval];

          j -= interval;
        }
        // Set the element at position j to temp
        sortList[j] = temp;
      }
      // Reduce the interval by half
      interval = interval ~/ 2;
    }
    return sortList;
  }
}
