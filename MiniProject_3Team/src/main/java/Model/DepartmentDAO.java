package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class DepartmentDAO {

	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	private static DepartmentDAO instance = new DepartmentDAO();

	private DepartmentDAO() {
	}

	public static DepartmentDAO getInstance() {
		if (instance == null) {
			instance = new DepartmentDAO();
		}
		return instance;
	}

	public String getDepartmentName(int id) {
		String sql = "select * from department " + "where dept_id = ?";
		String deptName = "";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				deptName = rs.getString("dept_name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return deptName;
	}

}
