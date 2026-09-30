int[][] gridData = {
  {29, 10, 14, 37, 13, 24, 11, 33},
  {29, 10, 14, 33, 13, 24, 11, 37},
  {29, 10, 14, 11, 13, 24, 33, 37},
  {24, 10, 14, 11, 13, 29, 33, 37},
  {13, 10, 14, 11, 24, 29, 33, 37},
  {13, 10, 11, 14, 24, 29, 33, 37},
  {11, 10, 13, 14, 24, 29, 33, 37},
  {10, 11, 13, 14, 24, 29, 33, 37}
};

// 각 숫자별 색상 지정 (0: 기본 검정, 1: 빨간색, 2: 파란색)
int[][] colorData = {
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 1, 0, 0, 0, 2},
  {0, 0, 0, 1, 0, 0, 2, 2},
  {1, 0, 0, 0, 0, 2, 2, 2},
  {1, 0, 0, 0, 2, 2, 2, 2},
  {0, 0, 1, 2, 2, 2, 2, 2},
  {1, 0, 2, 2, 2, 2, 2, 2},
  {1, 2, 2, 2, 2, 2, 2, 2}
};

int rows = 8;
int cols = 8;
float cellWidth = 60;
float cellHeight = 45;
float startX = 100;
float startY = 150;

void setup() {
  size(700, 600);
  background(255);
  
  // 제목 텍스트
  fill(0);
  textAlign(LEFT, TOP);
  textSize(32);
  text("Selection Sorting", 50, 50);
  
  // 표 및 숫자 그리기
  textAlign(CENTER, CENTER);
  textSize(18);
  
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      float x = startX + c * cellWidth;
      float y = startY + r * cellHeight;
      
      // 테두리 선
      stroke(220);
      strokeWeight(1);
      noFill();
      rect(x, y, cellWidth, cellHeight);
      
      // 텍스트 색상 설정
      if (colorData[r][c] == 1) {
        fill(220, 50, 40);   // 빨간색 (교환된 요소)
      } else if (colorData[r][c] == 2) {
        fill(40, 70, 160);   // 파란색 (정렬 완료된 요소)
      } else {
        fill(0);             // 기본 검정색
      }
      
      // 숫자 출력
      text(gridData[r][c], x + cellWidth/2, y + cellHeight/2);
    }
  }
}

void draw() {
  // 정적 이미지 출력이므로 loop 정지
  noLoop();
}
