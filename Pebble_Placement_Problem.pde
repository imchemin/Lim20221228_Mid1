
// Pebble Placement Problem
// Dynamic Programming (돌 놓기 문제)

int[][] matrix = {
  { 3, 7, 2, 9, 4, 8 },
  { 5, 1, 6, 3, 7, 2 },
  { 4, 8, 5, 1, 6, 9 }
};

int n = 6;

// 4가지 돌 배치 패턴
// 1: 위
// 2: 가운데
// 3: 아래
// 4: 위 + 아래

int[] pattern = {1, 2, 4, 5};

int[][] dp;
int[][] previous;

int[] result;
int maxScore;

int cellSize = 100;
int startX = 100;
int startY = 150;

void setup() {
  size(900, 600);

  calculateDP();

  println("Maximum Score: " + maxScore);
  println("Selected Patterns:");

  for (int i = 0; i < n; i++) {
    println("Column " + (i + 1) + ": Pattern " + result[i]);
  }
}

void calculateDP() {

  dp = new int[n][4];
  previous = new int[n][4];
  result = new int[n];

  // 첫 번째 열 초기화
  for (int p = 0; p < 4; p++) {
    dp[0][p] = getWeight(0, p);
    previous[0][p] = -1;
  }

  // Dynamic Programming
  for (int i = 1; i < n; i++) {

    for (int p = 0; p < 4; p++) {

      dp[i][p] = Integer.MIN_VALUE;

      for (int q = 0; q < 4; q++) {

        // 이전 패턴과 현재 패턴이 호환되는지 검사
        if ((pattern[p] & pattern[q]) == 0) {

          int score = dp[i - 1][q]
                    + getWeight(i, p);

          if (score > dp[i][p]) {
            dp[i][p] = score;
            previous[i][p] = q;
          }
        }
      }
    }
  }

  // 마지막 열에서 최대 점수 찾기
  maxScore = Integer.MIN_VALUE;
  int bestPattern = 0;

  for (int p = 0; p < 4; p++) {

    if (dp[n - 1][p] > maxScore) {
      maxScore = dp[n - 1][p];
      bestPattern = p;
    }
  }

  // 최적 경로 역추적
  for (int i = n - 1; i >= 0; i--) {

    result[i] = bestPattern;

    if (i > 0) {
      bestPattern = previous[i][bestPattern];
    }
  }
}

// 각 열에서 해당 패턴의 점수 계산
int getWeight(int col, int p) {

  int score = 0;
  int mask = pattern[p];

  for (int row = 0; row < 3; row++) {

    if ((mask & (1 << row)) != 0) {
      score += matrix[row][col];
    }
  }

  return score;
}

void draw() {

  background(245);

  fill(30);
  textAlign(CENTER);

  textSize(28);
  text("Pebble Placement Problem", width / 2, 55);

  textSize(18);
  text("Dynamic Programming", width / 2, 90);

  // 행렬 그리기
  for (int row = 0; row < 3; row++) {

    for (int col = 0; col < n; col++) {

      int x = startX + col * cellSize;
      int y = startY + row * cellSize;

      int p = result[col];
      int mask = pattern[p];

      // 돌이 놓인 위치 표시
      if ((mask & (1 << row)) != 0) {
        fill(100, 190, 120);
      } else {
        fill(255);
      }

      stroke(50);
      strokeWeight(2);

      rect(x, y, cellSize, cellSize);

      fill(20);
      textSize(24);

      text(matrix[row][col],
           x + cellSize / 2,
           y + cellSize / 2 + 8);
    }
  }

  // 최종 결과 출력
  fill(30);
  textSize(24);

  text("Maximum Score: " + maxScore,
       width / 2, 520);

  textSize(16);

  text("Green cells = Selected Pebbles",
       width / 2, 555);
}
