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
}
