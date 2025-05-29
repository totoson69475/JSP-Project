package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class EnrollmentDAO {
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	private static EnrollmentDAO instance = new EnrollmentDAO();

	private EnrollmentDAO() {
	}

	public static EnrollmentDAO getInstance() {
		if (instance == null) {
			instance = new EnrollmentDAO();
		}
		return instance;
	}

	// 수강 과목 추가(is_enrolled은 항상 "Y"로 등록)
	public int subjectEnrolled(EnrollmentDTO dto) {
		int su = 0;
		int student_id = dto.getStudent_id();
		int subject_id = dto.getSubject_id();
		// String is_enrolled = dto.getIs_enrolled();

		String sql = "INSERT INTO enrollment VALUES(enrollment_seq.NEXTVAL, ?, ?, ?)";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, student_id);
			pstmt.setInt(2, subject_id);
			pstmt.setString(3, "Y");
			su = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}

		return su;
	}

	// 수강 여부 검색
	public String findIsEnrolled(int student_id, int subject_id) {
		String isEnrolled = "";

		String sql = "select * from enrollment " + "where student_id = ? AND subject_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, student_id);
			pstmt.setInt(2, subject_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				isEnrolled = rs.getString("is_enrolled");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			System.out.println("--------------------------");
			System.out.println(rs);
			System.out.println(pstmt);
			System.out.println(conn);
			System.out.println("--------------------------");
			DbClose.close(rs, pstmt, conn);
		}
		return isEnrolled;
	}

	// 과목별 수강 학생 수 검색
	public int findSubStudent(int subject_id) {
		int num = 0; // 초기값 설정

		String sql = "SELECT COUNT(*) AS cnt FROM enrollment WHERE subject_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, subject_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt("cnt");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return num;
	}

}
