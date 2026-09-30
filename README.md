
### 실행 결과

![선택정렬 실행 결과](./homework/SelectionSorting_2026_0910_114804.png)
# 알고리즘 2026

## 숙제 1. 선택정렬

### 소스 코드

[원본 파일 열기](./homework/SelectionSorting.pde)

```java

int[] numbers = {64, 25, 12, 22, 11};

void setup() {
  size(600, 400);

  println("선택정렬 시작");
  println("정렬 전: " + join(nfNumbers(numbers), ", "));

  selectionSort(numbers);

  println("정렬 후: " + join(nfNumbers(numbers), ", "));
  println("선택정렬 완료");
}

void draw() {
  background(255);

  fill(30);
  textSize(24);
  text("Selection Sort", 30, 40);

  int barWidth = 80;
  int gap = 25;
  int startX = 40;
  int baseY = 300;

  for (int i = 0; i < numbers.length; i++) {
    int x = startX + i * (barWidth + gap);
    int barHeight = numbers[i] * 3;

    fill(70, 140, 220);
    rect(x, baseY - barHeight, barWidth, barHeight);

    fill(0);
    textSize(18);
    text(numbers[i], x + 25, baseY + 25);
  }

  textSize(16);
  text("Sorted from smallest to largest", 30, 360);
}

void selectionSort(int[] arr) {
  for (int i = 0; i < arr.length - 1; i++) {
    int minIndex = i;

    for (int j = i + 1; j < arr.length; j++) {
      if (arr[j] < arr[minIndex]) {
        minIndex = j;
      }
    }

    int temp = arr[i];
    arr[i] = arr[minIndex];
    arr[minIndex] = temp;
  }
}

String[] nfNumbers(int[] arr) {
  String[] result = new String[arr.length];

  for (int i = 0; i < arr.length; i++) {
    result[i] = str(arr[i]);
  }

  return result;
}
```

---
## 숙제 1. 선택정렬

### 실행 결과

![선택정렬 실행 결과](./homework/SelectionSorting_2026_0910_114804.png)

## 숙제 2. 정렬 과제

### 소스 코드

[원본 파일 열기](./homework/Sorting.pde)

```java
ArrayList<Array> lists;
Array list, plist;
int type=0, napTime=100, len=16, index=0, loop=0;
boolean autoFlag=true;
String[] titles = {"selectionSort", "bubbleSort", "insertSort", "mergeSort", "quickSort"};
PFont f;

void setup() {
  size(900, 600);  
  f = createFont("Arial-BoldMT-48.vlw", 24);
  textFont(f);
  lists = new ArrayList<Array>();
  lists.add(new Array(len, 0, 0));
  list = lists.get(0);
  list.printArray();
  run(type);
  list = lists.get(loop);
  list.printArray();
}

void draw() {
  background(200);
  list = lists.get(index);
  list.draw();
  fill(0);
  text("("+nf(list.i0,2)+","+nf(list.j0,2)+") - "+index+"/"+loop, 20, height-20);
  text(titles[type], 20, 40);
  if(autoFlag) nextStep();
}

void nextStep() {
  delay(napTime);
  if(index<loop) index++;
  else index=0;
}

void keyPressed() {
  if(key == ' ') {
    autoFlag = !autoFlag;
  }
  else if (key == CODED) {
    if (keyCode == LEFT) {
      if(index>0) index--;
    } else if (keyCode == RIGHT) {
      if(index<loop) index++;
    } 
  }
}

void mousePressed() {
  if(mouseButton == LEFT) {
    if(index>0) index--;
  }
  else if(mouseButton == RIGHT) {
    if(index<loop) index++;
  }
}

void run(int type) {
  if (type==0) selectionSort();
  else if (type==1) bubbleSort();
//  else if (type==2) insertSort();
//  else if (type==3) mergeSort();
//  else if (type==4) quickSort();  
}

void selectionSort() {
  int i, j, max, index, tlen=len;
  for (i=0; i<len; i++) {
    plist = lists.get(i);
    lists.add(new Array(len, plist.arr, i+1, 0));
    loop++;
    list = lists.get(i+1);    
    max=-1;
    index=-1;
    for (j=0; j<tlen; j++) {
      if (max<list.arr[j]) {
        max=list.arr[j];
        index=j;
      }
    }
    if (index!=-1) swap(list.arr, index, tlen-1);
    tlen--;
  }
}

void bubbleSort() {
  int i, j;
  for (j=0; j<len-1; j++) {
    plist = lists.get(loop);
    lists.add(new Array(len, plist.arr, j+1, 0));
    loop++;
    list = lists.get(loop);    
    for (i=0; i<len-j-1; i++) {
      plist = lists.get(loop);
      lists.add(new Array(len, plist.arr, j+1, i));
      loop++;
      list = lists.get(loop);    
      if (list.arr[i] > list.arr[i+1])
        swap(list.arr, i, i+1);
    }
  }
}

/*
void insertSort() {
  int i, j, temp, last = list.size();
  for (i=1; i<last; i++) {
    temp=list.get(i);
    for (j=i-1; j>=0 && temp<list.get(j); j--) {
      list.set(j+1, list.get(j));
    }
    list.set(j+1, temp);
    drawAndDelay();
  }
}

void mergeSort() {
  mergeSort(0, list.size()-1);
}

void mergeSort(int low, int high) {
  if (low < high) {
    int middle = low + (high - low) / 2;
    mergeSort(low, middle);
    mergeSort(middle + 1, high);
    merge(low, middle, high);
    drawAndDelay();
  }
}

void merge(int low, int middle, int high) {
  int i, j, k;
  i = low;
  j = middle + 1;
  k = low;
  for (i = low; i <= high; i++) {
    tlist.set(i, list.get(i));
    while (i <= middle && j <= high) {
      if (tlist.get(i) <= tlist.get(j)) {
        list.set(k, tlist.get(i));
        i++;
      } 
      else {
        list.set(k, tlist.get(j));
        j++;
      }
      k++;
    }
    while (i <= middle) {
      list.set(k, tlist.get(i));
      k++;
      i++;
    }
  }
}

void quickSort() {
  quickSort(0, list.size()-1);
}

void quickSort(int low, int high) {
  int i = low, j = high;
  int pivot = list.get(low+(high-low)/2);
  while (i <= j) {
    while (list.get(i) < pivot) i++;
    while (list.get(j) > pivot) j--;
    if (i <= j) {
      swap(i, j);
      i++;
      j--;
    }
  }
  if (low < j) quickSort(low, j);
  if (i < high) quickSort(i, high);
  drawAndDelay();
}
*/

void swap(int[] arr, int i, int j) {
  int tmp=arr[j];
  arr[j] = arr[i];
  arr[i] = tmp;
}// 여기에 Sorting.pde의 실제 코드를 붙여넣기
```

---

## 과제 README

[과제 설명 보기](./homework/README.md)
