package Model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class BoardDAO {

	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	private static BoardDAO instance = new BoardDAO();

	private BoardDAO() {
	}

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	public ArrayList<BoardDTO> getAllBoard() {
		String sql = "select * from board";
		ArrayList<BoardDTO> returnDTO = new ArrayList<BoardDTO>();

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int board_num = rs.getInt("board_num");
				int writer_prof_id = rs.getInt("writer_prof_id");
				String board_title = rs.getString("board_title");
				String board_content = rs.getString("board_content");
				String board_regtime = rs.getString("board_regtime");
				int board_views = rs.getInt("board_views");

				returnDTO.add(new BoardDTO(board_num, writer_prof_id, board_title, board_content, board_regtime,
						board_views));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return returnDTO;
	}

	public BoardDTO getBoardByBoardNum(int board_num) {
		String sql = "select * from board where board_num = ?";
		BoardDTO returnDTO = null;
		int su = 0;

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int board_number = rs.getInt("board_num");
				int writer_prof_id = rs.getInt("writer_prof_id");
				String board_title = rs.getString("board_title");
				String board_content = rs.getString("board_content");
				String board_regtime = rs.getString("board_regtime");
				int board_views = rs.getInt("board_views") + 1;

				returnDTO = new BoardDTO(board_number, writer_prof_id, board_title, board_content, board_regtime,
						board_views);
			}
			sql = "update board set board_views = board_views + 1 where board_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  board_num);
			
			su = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return returnDTO;
	}
	
	public int insertBoard(int prof_id, String board_title, String board_content, Date currentDate) {
		String sql = "insert into board "
				+ "values(board_seq.NEXTVAL, ?, ?, ?, ?, 0)";
		
		int su = 0;
		
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, prof_id);
			pstmt.setString(2, board_title);
			pstmt.setString(3, board_content);
			pstmt.setDate(4, currentDate);
			
			su = pstmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return su;
	}
	
	public int updateBoard(int board_num, String board_title, String board_content, Date currentDate) {
		String sql = "update board set board_title = ?, board_content = ?, board_regtime = ? "
				+ "where board_num = ?";
		
		int su = 0;
		
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_title);
			pstmt.setString(2, board_content);
			pstmt.setDate(3, currentDate);
			pstmt.setInt(4, board_num);
			
			su = pstmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return su;
		
	}
	
	public int deleteBoard(int board_num) {
		String sql = "delete board where "
				+ "board_num = ?";
		
		int su = 0;
		
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			su = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		System.out.println("삭제 su" + su);
		return su;
	}

}
