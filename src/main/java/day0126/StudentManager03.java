package day0126;

import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import viewer.StudentViewer2;

public class StudentManager03 {
    public static void main(String[] args) {
        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        StudentViewer2 studentViewer2 = new StudentViewer2(connectionMaker);
        studentViewer2.showMenu();
    }
}
