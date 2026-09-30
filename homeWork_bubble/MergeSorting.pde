// 각 칸의 숫자 데이터 (-1은 빈 칸을 의미)
int[][] gridData = {
  {10, 14, 29, 37, 11, 13, 24, 33},
  {10, -1, -1, -1, -1, -1, -1, -1},
  {10, 11, -1, -1, -1, -1, -1, -1},
  {10, 11, 13, -1, -1, -1, -1, -1},
  {10, 11, 13, 14, -1, -1, -1, -1},
  {10, 11, 13, 14, 24, -1, -1, -1},
  {10, 11, 13, 14, 24, 29, -1, -1},
  {10, 11, 13, 14, 24, 29, 33, -1},
  {10, 11, 13, 14, 24, 29, 33, 37}
};

int rows = 9;
int cols = 8;
float cellWidth = 60;
float cellHeight = 45;
float startX = 150;
float startY = 130;

void setup() {
  size(750, 600);
  background(255);
  
  // 제목 텍스트 (Merge Sorting)
  fill(0);
  textAlign(LEFT, TOP);
  textSize(32);
  text("Merge Sorting", 100, 50);
  
  // 표 및 숫자 그리기
  textAlign(CENTER, CENTER);
  textSize(18);
  
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      float x = startX + c * cellWidth;
      float y = startY + r * cellHeight;
      
      // 검은색 테두리 선
      stroke(0);
      strokeWeight(1);
      noFill();
      rect(x, y, cellWidth, cellHeight);
      
      // 값이 있는 칸(-1이 아닌 경우)에만 숫자 출력
      if (gridData[r][c] != -1) {
        fill(0); // 검은색 텍스트
        text(gridData[r][c], x + cellWidth/2, y + cellHeight/2);
      }
    }
  }
  
  // 실행 화면을 이미지 파일로 저장
  save("merge_sort.png");
}

void draw() {
  noLoop();
}
