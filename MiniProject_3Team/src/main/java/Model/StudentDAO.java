package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.Date;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class StudentDAO {

	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	public ArrayList<StudentDTO> memList = new ArrayList<StudentDTO>();

	private static StudentDAO instance = new StudentDAO();

	private StudentDAO() {
	}

	public static StudentDAO getInstance() {
		if (instance == null) {
			instance = new StudentDAO();
		}
		return instance;
	}

	public StudentDTO stuLog(int id, String pwd) {
		int vId = id;
		String vPwd = pwd;
		StudentDTO returnDTO = null;

		int su = 0;
		String sql = "select * from student " + "where student_id = ? AND student_password = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, vId);
			pstmt.setString(2, vPwd);

			su = pstmt.executeUpdate();

			if (su != 0) {
				returnDTO = stuFind(id, pwd);
				System.out.println(vId + "회원 로그인 성공!!");
			} else {
				System.out.println(vId + "회원 로그인 실패!!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return returnDTO;
	}

	public StudentDTO stuFind(int id, String pwd) {
		StudentDTO returnDTO = null;

		String sql = "select * from student " + "where student_id = ? AND student_password = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, pwd);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int vId = rs.getInt("student_id");
				int vDeptId = rs.getInt("dept_id");
				int vProfId = rs.getInt("prof_id");
				String vName = rs.getString("student_name");
				String vPwd = rs.getString("student_password");
				String vMajorType = rs.getString("major_type");
				Date vBirthdate = rs.getDate("birthdate");
				String vPhone = rs.getString("phone");
				String vAddr = rs.getString("address");
				String vEmail = rs.getString("email");
				String vEtc = rs.getString("etc");

				returnDTO = new StudentDTO(vId, vDeptId, vProfId, vName, vPwd, vMajorType, vBirthdate, vPhone, vAddr,
						vEmail, vEtc);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return returnDTO;
	}

	public StudentDTO studentUpd(StudentDTO dto) {
		StudentDTO returnDTO = null;
		int su = 0;

		int vId = dto.getStudent_id();
		String vName = dto.getStudent_name();
		Date vBirthdate = dto.getBirthdate();
		String vPhone = dto.getPhone();
		String vAddr = dto.getAddress();
		String vEmail = dto.getEmail();
		String vEtc = dto.getEtc();

		String sql = "UPDATE student SET " + "student_name = ?,  " + "birthdate = ?, " + "phone = ?, " + "address = ?, "
				+ "email = ?, " + "etc = ?" + " WHERE student_id = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vName);
			pstmt.setDate(2, vBirthdate);
			pstmt.setString(3, vPhone);
			pstmt.setString(4, vAddr);
			pstmt.setString(5, vEmail);
			pstmt.setString(6, vEtc);
			pstmt.setInt(7, vId);
			su = pstmt.executeUpdate();
			// executeUpdate()는 쿼리문이 성공할 경우 1, 실패할 경우 0 반환

			if (su > 0) { // 업데이트 성공했을 때만
				// 다시 학생 정보를 조회해서 DTO 만들기
				String selectSql = "SELECT * FROM student WHERE student_id = ?";
				pstmt = conn.prepareStatement(selectSql);
				pstmt.setInt(1, vId);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					vId = rs.getInt("student_id");
					int vDeptId = rs.getInt("dept_id");
					int vProfId = rs.getInt("prof_id");
					vName = rs.getString("student_name");
					String vPwd = rs.getString("student_password");
					String vMajorType = rs.getString("major_type");
					vBirthdate = rs.getDate("birthdate");
					vPhone = rs.getString("phone");
					vAddr = rs.getString("address");
					vEmail = rs.getString("email");
					vEtc = rs.getString("etc");

					returnDTO = new StudentDTO(vId, vDeptId, vProfId, vName, vPwd, vMajorType, vBirthdate, vPhone,
							vAddr, vEmail, vEtc);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return returnDTO;
	}

	public String getStudentNameById(int student_id) {
		String sql = "select * from student " + "where student_id = ?";
		String studentName = "";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, student_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				studentName = rs.getString("student_name");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return studentName;
	}
}
