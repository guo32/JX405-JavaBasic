package controller;

import model.StudentDTO;

import java.sql.*;
import java.util.ArrayList;

public class StudentController2 {
    private Connection connection;

    public StudentController2(Connection connection) {
        this.connection = connection;
    }

    public void insert(StudentDTO studentDTO) {
        String query = "insert into `student`(`name`, `korean`, `english`, `math`) values(?, ?, ?, ?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, studentDTO.getName());
            preparedStatement.setInt(2, studentDTO.getKorean());
            preparedStatement.setInt(3, studentDTO.getEnglish());
            preparedStatement.setInt(4, studentDTO.getMath());
            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            System.out.println("insert error");
            e.printStackTrace();
        }
    }

    public ArrayList<StudentDTO> selectAll() {
        ArrayList<StudentDTO> list = new ArrayList<>();

        String query = "select * from `student`";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                StudentDTO s = new StudentDTO();
                s.setId(resultSet.getInt("id"));
                s.setName(resultSet.getString("name"));
                s.setKorean(resultSet.getInt("korean"));
                s.setEnglish(resultSet.getInt("english"));
                s.setMath(resultSet.getInt("math"));
                list.add(s);
            }
            resultSet.close();
            preparedStatement.close();
        } catch (SQLException e) {
            System.out.println("selectAll error");
            e.printStackTrace();
        }

        return list;
    }

    public StudentDTO selectOne(int id) {
        String query = "select * from `student` where `id` = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                StudentDTO s = new StudentDTO();
                s.setId(resultSet.getInt("id"));
                s.setName(resultSet.getString("name"));
                s.setKorean(resultSet.getInt("korean"));
                s.setEnglish(resultSet.getInt("english"));
                s.setMath(resultSet.getInt("math"));

                return s;
            }
            resultSet.close();
            preparedStatement.close();
        } catch (SQLException e) {
            System.out.println("selectOne error");
            e.printStackTrace();
        }

        return null;
    }

    public void update(StudentDTO studentDTO) {
        String query = "update `student` set `korean` = ?, `english` = ?, `math` = ? where `id` = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, studentDTO.getKorean());
            preparedStatement.setInt(2, studentDTO.getEnglish());
            preparedStatement.setInt(3, studentDTO.getMath());
            preparedStatement.setInt(4, studentDTO.getId());
            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            System.out.println("update error");
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "delete from `student` where `id` = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            System.out.println("delete error");
            e.printStackTrace();
        }
    }
}
