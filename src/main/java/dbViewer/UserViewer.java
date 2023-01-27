package dbViewer;

import dbConn.ConnectionMaker;
import dbController.UserController;
import model.UserDTO;
import util.ScannerUtil;

import java.sql.Connection;
import java.util.Scanner;

public class UserViewer {
    private final Scanner SCANNER;
    private Connection connection;
    private UserDTO login = null;

    public UserViewer(ConnectionMaker connectionMaker) { // 의존성 주입
        SCANNER = new Scanner(System.in);
        connection = connectionMaker.makeConnection();
    }

    public void showIndex() {
        String message = "1. 로그인 2. 회원가입 3. 종료";
        while (true) {
            int userChoice = ScannerUtil.nextInt(SCANNER, message, 1, 3);
            if (userChoice == 1) {
                auth();
                if (login != null) {
                    showMenu();
                }
            } else if (userChoice == 2) {
                register();
            } else if (userChoice == 3) {
                System.out.println("사용해주셔서 감사합니다.");
                break;
            }
        }
    }

    private void register() {
        String message;
        message = "사용하실 아이디를 입력해주세요.";
        String username = ScannerUtil.nextLine(SCANNER, message);

        UserDTO u = new UserDTO();
        u.setUsername(username);

        message = "사용하실 비밀번호를 입력해주세요.";
        u.setPassword(ScannerUtil.nextLine(SCANNER, message));

        message = "사용하실 닉네임을 입력해주세요.";
        u.setNickname(ScannerUtil.nextLine(SCANNER, message));

        UserController userController = new UserController(connection);
        if (!userController.insert(u)) {
            System.out.println("중복된 아이디입니다.");
            message = "새로운 아이디로 가입을 시도하시겠습니까? Y/N";
            String yesNo = ScannerUtil.nextLine(SCANNER, message);
            if (yesNo.equalsIgnoreCase("Y")) {
                register();
            }
        }
    }

    private void auth() {
        String message;
        message = "아이디를 입력해주세요.";
        String username = ScannerUtil.nextLine(SCANNER, message);

        message = "비밀번호를 입력해주세요.";
        String password = ScannerUtil.nextLine(SCANNER, message);

        UserController userController = new UserController(connection);
        login = userController.auth(username, password);

        if (login == null) {
            System.out.println("로그인 정보가 정확하지 않습니다.");
        }
    }

    private void showMenu() {
        String message = "1. 게시판으로 2. 회원 정보 관리 3. 로그아웃";
        while (login != null) {
            int userChoice = ScannerUtil.nextInt(SCANNER, message, 1, 3);
            if (userChoice == 1) {
                BoardViewer boardViewer = new BoardViewer(SCANNER, connection, login);
                boardViewer.showMenu();
            } else if (userChoice == 2) {
                printOne();
            } else if (userChoice == 3) {
                login = null;
                System.out.println("정상적으로 로그아웃되었습니다.");
            }
        }
    }

    private void printOne() {
        System.out.println("회원 번호: " + login.getId());
        System.out.println("회원 닉네임: " + login.getNickname());
        System.out.println("--------------------------------");
        String message = "1. 수정 2. 탈퇴 3. 뒤로 가기";
        int userChoice = ScannerUtil.nextInt(SCANNER, message, 1, 3);
        if (userChoice == 1) {
            update();
        } else if (userChoice == 2) {
            delete();
        }
    }

    private void update() {
        System.out.println("회원 번호: " + login.getId());
        System.out.println("회원 닉네임: " + login.getNickname());
        System.out.println("--------------------------------");
        String message = "새로운 비밀번호를 입력해주세요.";
        String newPassword = ScannerUtil.nextLine(SCANNER, message);

        message = "새로운 닉네임을 입력해주세요.";
        String newNickname = ScannerUtil.nextLine(SCANNER, message);

        message = "기존 비밀번호를 입력해주세요.";
        String oldPassword = ScannerUtil.nextLine(SCANNER, message);

        UserController userController = new UserController(connection);

        if (userController.auth(login.getUsername(), oldPassword) != null) {
            login.setNickname(newNickname);
            login.setPassword(newPassword);

            userController.update(login);
        } else {
            System.out.println("회원 정보 변경에 실패하였습니다.");
        }
    }

    private void delete() {
        String message = "정말로 탈퇴하시겠습니까? Y/N";
        String yesNo = ScannerUtil.nextLine(SCANNER, message);

        if (yesNo.equalsIgnoreCase("Y")) {
            message = "비밀번호를 입력해주세요.";
            String password = ScannerUtil.nextLine(SCANNER, message);

            UserController userController = new UserController(connection);

            if (userController.auth(login.getUsername(), password) != null) {
                userController.delete(login.getId());
                login = null;
            }
        }
    }
}