
import java.util.ArrayList;

// ==========================================
// Infix to Postfix Calculator using Stack
// Processing - Java Mode
// ==========================================

String expression = "3+4*(2-1)";
String postfix = "";
String result = "";

String message = "수식을 입력하고 ENTER를 누르세요.";
boolean calculated = false;

// UI colors
color backgroundColor = #F5F7FB;
color textColor = #24334D;
color blueColor = #5279C7;
color resultColor = #A33D48;
color greenColor = #16845B;
color borderColor = #D8E0EE;

// ==========================================
// STACK IMPLEMENTATION
// ==========================================

class CharStack {
  char[] data = new char[200];
  int top = -1;

  void push(char c) {
    if (top >= data.length - 1) {
      throw new RuntimeException("스택이 가득 찼습니다.");
    }
    data[++top] = c;
  }

  char pop() {
    if (top == -1) {
      throw new RuntimeException("스택이 비었습니다.");
    }
    return data[top--];
  }

  char peek() {
    if (top == -1) {
      throw new RuntimeException("스택이 비었습니다.");
    }
    return data[top];
  }

  boolean isEmpty() {
    return top == -1;
  }
}

class NumberStack {
  double[] data = new double[200];
  int top = -1;

  void push(double n) {
    if (top >= data.length - 1) {
      throw new RuntimeException("계산 스택이 가득 찼습니다.");
    }
    data[++top] = n;
  }

  double pop() {
    if (top == -1) {
      throw new RuntimeException("수식이 올바르지 않습니다.");
    }
    return data[top--];
  }

  int size() {
    return top + 1;
  }
}

// ==========================================
// SETUP
// ==========================================

void setup() {
  size(900, 540);
  smooth();
  surface.setTitle("Infix to Postfix Calculator");

  textFont(createFont("SansSerif", 18));
}

// ==========================================
// DRAW USER INTERFACE
// ==========================================

void draw() {
  background(backgroundColor);

  // Main title
  fill(textColor);
  textAlign(LEFT, CENTER);
  textSize(30);
  text("Infix to Postfix Calculator (Stack)", 40, 52);

  // Subtitle
  fill(110, 125, 150);
  textSize(15);
  text("STACK-BASED EXPRESSION CONVERTER", 42, 84);

  // Input instruction
  fill(textColor);
  textSize(19);
  text("1. Key in your expression and press ENTER:", 42, 133);

  // Input box
  stroke(190, 205, 230);
  strokeWeight(1.5);
  fill(255);
  rect(40, 157, 820, 62, 12);

  // Input expression
  noStroke();
  fill(textColor);
  textSize(25);
  textAlign(LEFT, CENTER);

  String displayExpression = expression;

  // Keep the end of a long expression visible
  while (textWidth(displayExpression) > 770 &&
         displayExpression.length() > 0) {
    displayExpression = displayExpression.substring(1);
  }

  text(displayExpression, 58, 188);

  // Calculate button
  noStroke();
  fill(blueColor);
  rect(40, 238, 180, 48, 10);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(17);
  text("CALCULATE", 130, 262);

  // Clear button
  fill(230, 235, 244);
  rect(235, 238, 120, 48, 10);

  fill(textColor);
  text("CLEAR", 295, 262);

  // Result card
  stroke(borderColor);
  strokeWeight(1.3);
  fill(255);
  rect(40, 310, 820, 185, 15);

  // Postfix heading
  noStroke();
  fill(textColor);
  textAlign(LEFT, CENTER);
  textSize(20);
  text("Postfix (후위 표기식):", 60, 342);

  // Postfix output
  fill(resultColor);
  textSize(27);

  String shownPostfix = postfix.length() == 0 ? "--" : postfix;

  // Fit long output within the card
  while (textWidth(shownPostfix) > 770 &&
         shownPostfix.length() > 0) {
    shownPostfix = shownPostfix.substring(
      0, shownPostfix.length() - 1
    );
  }

  text(shownPostfix, 60, 375);

  // Calculation result heading
  fill(textColor);
  textSize(20);
  text("Calculation Result (계산 결과):", 60, 432);

  // Calculation result
  fill(greenColor);
  textSize(29);
  text(result.length() == 0 ? "--" : result, 60, 467);

  // Status message
  fill(110, 125, 150);
  textSize(13);
  textAlign(LEFT, CENTER);
  text(message, 42, 518);
}

// ==========================================
// MOUSE CONTROLS
// ==========================================

void mousePressed() {
  // Calculate
  if (mouseX >= 40 && mouseX <= 220 &&
      mouseY >= 238 && mouseY <= 286) {
    calculateExpression();
  }

  // Clear
  if (mouseX >= 235 && mouseX <= 355 &&
      mouseY >= 238 && mouseY <= 286) {
    expression = "";
    postfix = "";
    result = "";
    message = "새로운 수식을 입력하세요.";
    calculated = false;
  }
}

// ==========================================
// KEYBOARD INPUT
// ==========================================

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    calculateExpression();
    return;
  }

  if (key == BACKSPACE) {
    if (expression.length() > 0) {
      expression = expression.substring(
        0, expression.length() - 1
      );
    }

    clearResult();
    return;
  }

  if (key == ESC) {
    key = 0;
    expression = "";
    clearResult();
    return;
  }

  if (key == DELETE) {
    expression = "";
    clearResult();
    return;
  }

  if ((key >= '0' && key <= '9') ||
      key == '+' || key == '-' ||
      key == '*' || key == '/' ||
      key == '(' || key == ')' ||
      key == '.' || key == ' ') {

    expression += key;
    clearResult();
  }
}

void clearResult() {
  postfix = "";
  result = "";
  calculated = false;
  message = "수식을 입력하고 ENTER를 누르세요.";
}

// ==========================================
// INFIX TO POSTFIX CONVERSION
// ==========================================

ArrayList<String> convertToPostfix(String input) {
  ArrayList<String> tokens = tokenize(input);
  ArrayList<String> output = new ArrayList<String>();
  CharStack operators = new CharStack();

  for (String token : tokens) {

    // Numbers go directly to output
    if (isNumber(token)) {
      output.add(token);
    }

    // Opening parenthesis goes onto the stack
    else if (token.equals("(")) {
      operators.push('(');
    }

    // Pop until the matching opening parenthesis
    else if (token.equals(")")) {
      while (!operators.isEmpty() &&
             operators.peek() != '(') {
        output.add(str(operators.pop()));
      }

      if (operators.isEmpty()) {
        throw new RuntimeException("괄호 짝이 맞지 않습니다.");
      }

      operators.pop();
    }

    // Process arithmetic operators
    else {
      char op = token.charAt(0);

      while (!operators.isEmpty() &&
             operators.peek() != '(' &&
             precedence(operators.peek()) >= precedence(op)) {

        output.add(str(operators.pop()));
      }

      operators.push(op);
    }
  }

  // Pop remaining operators
  while (!operators.isEmpty()) {
    char op = operators.pop();

    if (op == '(') {
      throw new RuntimeException("괄호 짝이 맞지 않습니다.");
    }

    output.add(str(op));
  }

  return output;
}

// ==========================================
// POSTFIX CALCULATION
// ==========================================

double evaluatePostfix(ArrayList<String> tokens) {
  NumberStack stack = new NumberStack();

  for (String token : tokens) {

    // Push numbers onto the calculation stack
    if (isNumber(token)) {
      stack.push(Double.parseDouble(token));
    }

    // Apply operators to the top two numbers
    else {
      if (stack.size() < 2) {
        throw new RuntimeException("수식이 올바르지 않습니다.");
      }

      double b = stack.pop();
      double a = stack.pop();
      double value = 0;

      switch (token) {
      case "+":
        value = a + b;
        break;

      case "-":
        value = a - b;
        break;

      case "*":
        value = a * b;
        break;

      case "/":
        if (b == 0) {
          throw new RuntimeException("0으로 나눌 수 없습니다.");
        }
        value = a / b;
        break;

      default:
        throw new RuntimeException("잘못된 연산자입니다.");
      }

      stack.push(value);
    }
  }

  if (stack.size() != 1) {
    throw new RuntimeException("수식이 올바르지 않습니다.");
  }

  return stack.pop();
}

// ==========================================
// MAIN CALCULATION
// ==========================================

void calculateExpression() {
  try {
    if (expression.trim().length() == 0) {
      throw new RuntimeException("수식을 입력하세요.");
    }

    // Step 1: Convert infix to postfix
    ArrayList<String> tokens = convertToPostfix(expression);

    // Step 2: Evaluate postfix
    double answer = evaluatePostfix(tokens);

    // Step 3: Display results
    postfix = joinTokens(tokens);
    result = formatNumber(answer);

    message = "계산이 완료되었습니다.";
    calculated = true;

  } catch (Exception e) {
    postfix = "";
    result = "";
    message = "오류: " + e.getMessage();
    calculated = false;
  }
}

// ==========================================
// TOKENIZER
// Supports multi-digit numbers and decimals
// ==========================================

ArrayList<String> tokenize(String input) {
  ArrayList<String> tokens = new ArrayList<String>();

  int i = 0;
  boolean expectOperand = true;

  while (i < input.length()) {
    char c = input.charAt(i);

    if (Character.isWhitespace(c)) {
      i++;
      continue;
    }

    // Read a number such as 12, 3.14 or .5
    if (Character.isDigit(c) || c == '.') {
      if (!expectOperand) {
        throw new RuntimeException("연산자가 빠졌습니다.");
      }

      int start = i;
      int decimalCount = 0;
      boolean hasDigit = false;

      while (i < input.length()) {
        char n = input.charAt(i);

        if (Character.isDigit(n)) {
          hasDigit = true;
          i++;
        } else if (n == '.') {
          decimalCount++;

          if (decimalCount > 1) {
            throw new RuntimeException("소수점이 잘못되었습니다.");
          }

          i++;
        } else {
          break;
        }
      }

      if (!hasDigit) {
        throw new RuntimeException("올바른 숫자를 입력하세요.");
      }

      tokens.add(input.substring(start, i));
      expectOperand = false;
      continue;
    }

    if (c == '(') {
      if (!expectOperand) {
        throw new RuntimeException("연산자가 빠졌습니다.");
      }

      tokens.add("(");
      expectOperand = true;
      i++;
      continue;
    }

    if (c == ')') {
      if (expectOperand) {
        throw new RuntimeException("괄호 안의 수식을 확인하세요.");
      }

      tokens.add(")");
      expectOperand = false;
      i++;
      continue;
    }

    if (c == '+' || c == '-' ||
        c == '*' || c == '/') {

      if (expectOperand) {
        // This simple version accepts unary minus before numbers
        if (c == '-' &&
            i + 1 < input.length() &&
            (Character.isDigit(input.charAt(i + 1)) ||
             input.charAt(i + 1) == '.')) {

          int start = i;
          i++;

          int decimalCount = 0;
          boolean hasDigit = false;

          while (i < input.length()) {
            char n = input.charAt(i);

            if (Character.isDigit(n)) {
              hasDigit = true;
              i++;
            } else if (n == '.') {
              decimalCount++;

              if (decimalCount > 1) {
                throw new RuntimeException("소수점이 잘못되었습니다.");
              }

              i++;
            } else {
              break;
            }
          }

          if (!hasDigit) {
            throw new RuntimeException("올바른 숫자를 입력하세요.");
          }

          tokens.add(input.substring(start, i));
          expectOperand = false;
          continue;
        }

        throw new RuntimeException("연산자 위치가 잘못되었습니다.");
      }

      tokens.add(str(c));
      expectOperand = true;
      i++;
      continue;
    }

    throw new RuntimeException("잘못된 문자: " + c);
  }

  if (tokens.isEmpty() || expectOperand) {
    throw new RuntimeException("수식이 완성되지 않았습니다.");
  }

  // Validate parenthesis balance
  int depth = 0;

  for (String token : tokens) {
    if (token.equals("(")) depth++;

    if (token.equals(")")) {
      depth--;

      if (depth < 0) {
        throw new RuntimeException("괄호 짝이 맞지 않습니다.");
      }
    }
  }

  if (depth != 0) {
    throw new RuntimeException("괄호 짝이 맞지 않습니다.");
  }

  return tokens;
}

// ==========================================
// HELPER FUNCTIONS
// ==========================================

boolean isNumber(String token) {
  try {
    Double.parseDouble(token);
    return true;
  } catch (Exception e) {
    return false;
  }
}

int precedence(char op) {
  if (op == '*' || op == '/') return 2;
  if (op == '+' || op == '-') return 1;
  return 0;
}

String joinTokens(ArrayList<String> tokens) {
  String output = "";

  for (int i = 0; i < tokens.size(); i++) {
    if (i > 0) output += " ";
    output += tokens.get(i);
  }

  return output;
}

String formatNumber(double n) {
  if (Math.abs(n) < 0.0000000001) {
    n = 0;
  }

  if (Math.abs(n) < 1.0e12 && n == Math.floor(n)) {
    return String.format(java.util.Locale.US, "%.0f", n);
  }

  return String.format(java.util.Locale.US, "%.6f", n)
    .replaceAll("0+$", "")
    .replaceAll("\\.$", "");
}
