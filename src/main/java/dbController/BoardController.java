package dbController;

import model.BoardDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class BoardController {
    private Connection connection;

    public BoardController(Connection connection) {
        this.connection = connection;
    }

    public void insert(BoardDTO boardDTO) {
        String query = "insert into `board`(`title`, `content`, `writerId`, `entry_date`, `modify_date`) values(?, ?, ?, now(), now())";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, boardDTO.getTitle());
            preparedStatement.setString(2, boardDTO.getContent());
            preparedStatement.setInt(3, boardDTO.getWriterId());
            preparedStatement.executeUpdate();

            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<BoardDTO> selectAll() {
        ArrayList<BoardDTO> list = new ArrayList<>();

        String query = "select * from `board` order by `board`.`id` desc";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                BoardDTO b = new BoardDTO();
                b.setId(resultSet.getInt("id"));
                b.setTitle(resultSet.getString("title"));
                b.setContent(resultSet.getString("content"));
                b.setWriterId(resultSet.getInt("writerId"));
                b.setEntryDate(resultSet.getTimestamp("entry_date"));
                b.setModifyDate(resultSet.getTimestamp("modify_date"));

                list.add(b);
            }

            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public BoardDTO selectOne(int id) {
        BoardDTO b = null;
        String query = "select * from `board` where `id` = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                b = new BoardDTO();
                b.setId(resultSet.getInt("id"));
                b.setTitle(resultSet.getString("title"));
                b.setContent(resultSet.getString("content"));
                b.setWriterId(resultSet.getInt("writerId"));
                b.setEntryDate(resultSet.getTimestamp("entry_date"));
                b.setModifyDate(resultSet.getTimestamp("modify_date"));
            }
            resultSet.close();
            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return b;
    }

    public void update(BoardDTO boardDTO) {
        String query = "update `board` set `title` = ?, `content` = ?, `modify_date` = now() where `id` = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, boardDTO.getTitle());
            preparedStatement.setString(2, boardDTO.getContent());
            preparedStatement.setInt(3, boardDTO.getId());
            preparedStatement.executeUpdate();

            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "delete from `board` where `id` = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
