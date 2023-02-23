package model;

import lombok.Data;

@Data
public class UserDTO {
    private int id; // 회원 번호
    private String username; // 흔히 알고 있는 아이디
    private String password;
    private String nickname;
}