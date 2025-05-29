package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class AttendanceStatusDAO {
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	private static AttendanceStatusDAO instance = new AttendanceStatusDAO();

	private AttendanceStatusDAO() {
	}

	public static AttendanceStatusDAO getInstance() {
		if (instance == null) {
			instance = new AttendanceStatusDAO();
		}
		return instance;
	}

	public int getAttendanceStatusIdByName(String attendance_status_name) {
		String sql = "select attendance_status_id from attendance_status " + "where attendance_status_name = ?";
		int id = 0;

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, attendance_status_name);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				id = rs.getInt("attendance_status_id");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return id;
	}
}
