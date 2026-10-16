
int n = 32;
int[] arr = new int[n];

int step = 0;
int delayCount = 0;
int sortSpeed = 8;

// 색상이 흐르는 위치
float colorPosition = 0;

boolean sorting = true;
boolean finished = false;

void setup() {
  size(1000, 600);
  frameRate(30);
  rectMode(CORNERS);
  newSort();
}

void draw() {
  background(20);

  // 색상이 왼쪽에서 오른쪽으로 천천히 이동
  colorPosition += 0.12;
  if (colorPosition >= n) {
    colorPosition = 0;
  }

  // 정렬을 천천히 진행
  delayCount++;

  if (sorting && delayCount >= sortSpeed) {
    delayCount = 0;

    if (step < n - 1) {
      for (int j = 0; j < n - 1 - step; j++) {
        if (arr[j] > arr[j + 1]) {
          int temp = arr[j];
          arr[j] = arr[j + 1];
          arr[j + 1] = temp;
        }
      }
      step++;
    } else {
      sorting = false;
      finished = true;
    }
  }

  float w = (float) width / n;

  // 막대그래프 그리기
  for (int i = 0; i < n; i++) {
    float h = map(arr[i], 0, 100, 10, height - 100);

    float x1 = i * w + 1;
    float x2 = (i + 1) * w - 1;
    float y = height - 40 - h;

    // 기본 막대는 회색
    fill(155);
    stroke(45);

    // 일부 막대만 파란색으로 강조
    float distance = abs(i - colorPosition);

    if (distance < 3) {
      fill(lerpColor(
        color(155),
        color(90, 155, 195),
        map(distance, 0, 3, 0.65, 0)
      ));
    }

    rect(x1, y, x2, height - 40);
  }

  // 하단 안내 문구
  fill(200);
  noStroke();
  textAlign(CENTER);
  textSize(14);

  if (finished) {
    text("Sorting complete - Click to restart",
         width / 2, height - 15);
  } else {
    text("Bubble Sort - Click to restart",
         width / 2, height - 15);
  }
}

void newSort() {
  for (int i = 0; i < n; i++) {
    arr[i] = (int) random(10, 101);
  }

  step = 0;
  delayCount = 0;
  sorting = true;
  finished = false;
  colorPosition = 0;
}

void mousePressed() {
  newSort();
}
