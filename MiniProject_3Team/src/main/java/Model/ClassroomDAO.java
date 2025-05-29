package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class ClassroomDAO {
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	private static ClassroomDAO instance = new ClassroomDAO();

	private ClassroomDAO() {
	}

	public static ClassroomDAO getInstance() {
		if (instance == null) {
			instance = new ClassroomDAO();
		}
		return instance;
	}

	// 강의실 이름 찾기
	public String getClassroomName(int id) {
		String classroomName = "";

		String sql = "select * from classroom " + "where room_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				classroomName = rs.getString("room_name");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return classroomName;
	}
}
