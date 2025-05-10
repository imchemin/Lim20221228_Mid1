import java.util.Scanner;
import java.util.Random;

/**
 * Lim20221228_Mid1
 * 가위바위보 게임 프로그램
 */
public class Lim20221228_Mid1 {
    public static void main(String[] args) {
        // 0: 가위, 1: 바위, 2: 보
        String[] hands = {"가위", "바위", "보"};
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();

        System.out.print("가위(0), 바위(1), 보(2) 중 숫자를 입력하세요: ");
        int user = scanner.nextInt();

        // 입력값 체크
        if (user < 0 || user > 2) {
            System.out.println("잘못된 입력입니다.");
            scanner.close();
            return;
        }

        int computer = random.nextInt(3);

        System.out.println("당신: " + hands[user]);
        System.out.println("컴퓨터: " + hands[computer]);

        // 승패 판정
        switch (user) {
            case 0: // 가위
                if (computer == 0)
                    System.out.println("비겼습니다!");
                else if (computer == 1)
                    System.out.println("졌습니다!");
                else
                    System.out.println("이겼습니다!");
                break;
            case 1: // 바위
                if (computer == 0)
                    System.out.println("이겼습니다!");
                else if (computer == 1)
                    System.out.println("비겼습니다!");
                else
                    System.out.println("졌습니다!");
                break;
            case 2: // 보
                if (computer == 0)
                    System.out.println("졌습니다!");
                else if (computer == 1)
                    System.out.println("이겼습니다!");
                else
                    System.out.println("비겼습니다!");
                break;
            default:
                System.out.println("에러가 발생했습니다.");
        }

        scanner.close();
    }
}
