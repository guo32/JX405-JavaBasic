package model;

import lombok.Data;

import java.util.Date;

@Data
public class BoardDTO {
    private int id;
    private String title;
    private int writerId; // 회원 번호
    private String writerNickname; // 회원 닉네임
    private String content;
    private Date entryDate;
    private Date modifyDate;

}
