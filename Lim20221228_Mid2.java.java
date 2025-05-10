import java.util.Scanner;
import java.util.Random;

public class Lim20221228_Mid2 {
    public static void main(String[] args) {
        // 0: 묵, 1: 찌, 2: 빠
        String[] hands = {"묵", "찌", "빠"};
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();

        int attacker; // 0: 사용자, 1: 컴퓨터
        int user, computer;

        // 1. 선공 결정 (가위바위보)
        System.out.println("=== 묵찌빠 게임 ===");
        System.out.println("먼저 선공(공격자)을 정합니다! (가위:0, 바위:1, 보:2)");

        while (true) {
            System.out.print("당신의 선택(가위:0, 바위:1, 보:2): ");
            user = scanner.nextInt();
            if (user < 0 || user > 2) {
                System.out.println("잘못된 입력입니다. 다시 입력하세요.");
                continue;
            }
            computer = random.nextInt(3);
            System.out.println("컴퓨터의 선택: " + (computer == 0 ? "가위" : computer == 1 ? "바위" : "보"));

            // 가위바위보 승패 판정
            if (user == computer) {
                System.out.println("비겼습니다! 다시 합니다.");
            } else if ((user == 0 && computer == 2) || (user == 1 && computer == 0) || (user == 2 && computer == 1)) {
                System.out.println("당신이 선공(공격자)입니다!");
                attacker = 0; // 사용자 공격
                break;
            } else {
                System.out.println("컴퓨터가 선공(공격자)입니다!");
                attacker = 1; // 컴퓨터 공격
                break;
            }
        }

        // 2. 묵찌빠 본게임
        while (true) {
            System.out.println("\n--- 묵찌빠! ---");
            System.out.print("당신의 선택(묵:0, 찌:1, 빠:2): ");
            user = scanner.nextInt();
            if (user < 0 || user > 2) {
                System.out.println("잘못된 입력입니다. 다시 입력하세요.");
                continue;
            }
            computer = random.nextInt(3);
            System.out.println("컴퓨터의 선택: " + hands[computer]);
            System.out.println((attacker == 0 ? "당신(공격)" : "컴퓨터(공격)") + " vs " + (attacker == 0 ? "컴퓨터(수비)" : "당신(수비)"));

            // 묵찌빠 승패 판정
            if (user == computer) {
                if (attacker == 0) {
                    System.out.println("묵찌빠! 당신이 이겼습니다!");
                } else {
                    System.out.println("묵찌빠! 컴퓨터가 이겼습니다!");
                }
                break;
            } else {
                // 공격권 이동 판정 (묵찌빠 룰: 가위바위보와 동일)
                int winner = -1; // 0: 사용자, 1: 컴퓨터
                switch (user) {
                    case 0: // 묵
                        if (computer == 1) winner = 0; // 묵이 찌를 이김
                        else if (computer == 2) winner = 1; // 빠가 묵을 이김
                        break;
                    case 1: // 찌
                        if (computer == 2) winner = 0; // 찌가 빠를 이김
                        else if (computer == 0) winner = 1; // 묵이 찌를 이김
                        break;
                    case 2: // 빠
                        if (computer == 0) winner = 0; // 빠가 묵을 이김
                        else if (computer == 1) winner = 1; // 찌가 빠를 이김
                        break;
                }
                if (winner == 0) {
                    attacker = 0;
                    System.out.println("당신이 공격권을 가져갑니다!");
                } else if (winner == 1) {
                    attacker = 1;
                    System.out.println("컴퓨터가 공격권을 가져갑니다!");
                } else {
                    System.out.println("무승부! 공격권 변동 없음.");
                }
            }
        }
        scanner.close();
    }
}
