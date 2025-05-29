package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class GradeDAO {
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	private static GradeDAO instance = new GradeDAO();

	private GradeDAO() {
	}

	public static GradeDAO getInstance() {
		if (instance == null) {
			instance = new GradeDAO();
		}
		return instance;
	}

	public void createGrade(int student_id, int subject_id, int prof_id) {
		String sql = "INSERT INTO grade " + "VALUES (grade_seq.NEXTVAL, ?, ?, ?, ?)";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			System.out.println("초기 성적생성");

			pstmt.setInt(1, student_id);
			pstmt.setInt(2, subject_id);
			pstmt.setString(3, "미입력");
			pstmt.setInt(4, prof_id);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}

	}

	// 학번으로 학생 모든 성적 받아오기
	public ArrayList<GradeDTO> findGrade(int id) {
		ArrayList<GradeDTO> returnDTO = new ArrayList<>();

		String sql = "select * from grade " + "where student_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int student_id = rs.getInt("student_id");
				int subject_id = rs.getInt("subject_id");
				String score = rs.getString("score");

				returnDTO.add(new GradeDTO(student_id, subject_id, score));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return returnDTO;
	}

	// 교수기능
	public List<GradeDTO2> gradeSel(int profId, int subjectId) {
		List<GradeDTO2> grades = new ArrayList<>();
		String sql = "SELECT j.subject_name, g.student_id, s.student_name, d.dept_name, "
				+ "s.major_type, s.phone, s.email, g.score, g.input_prof_id, j.subject_id " + "FROM grade g "
				+ "JOIN student s ON g.student_id = s.student_id " + "JOIN subject j ON g.subject_id = j.subject_id "
				+ "JOIN department d ON s.dept_id = d.dept_id " + "WHERE g.input_prof_id = ? and j.subject_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, profId);
			pstmt.setInt(2, subjectId);
			rs = pstmt.executeQuery();

			if (rs != null) {
				while (rs.next()) {
					// 각 컬럼의 값을 DTO에 설정
					GradeDTO2 grade = new GradeDTO2();
					grade.setSubjectName(rs.getString("subject_name"));
					grade.setStudentId(rs.getInt("student_id"));
					grade.setStudentName(rs.getString("student_name"));
					grade.setDeptName(rs.getString("dept_name"));
					grade.setMajorType(rs.getString("major_type"));
					grade.setPhone(rs.getString("phone"));
					grade.setEmail(rs.getString("email"));
					grade.setScore(rs.getString("score"));
					grade.setProfId(rs.getInt("input_prof_id"));
					grade.setSubjectId(rs.getInt("subject_id"));
					grades.add(grade);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				DbClose.close(rs, pstmt, conn);
			} else {
				DbClose.close(pstmt, conn);
			}
		}

		return grades;
	}

	public GradeDTO2 gradeUpd(int studentId) {
		GradeDTO2 grade = null;
		String sql = "SELECT j.subject_name, g.student_id, s.student_name, d.dept_name, "
				+ "s.major_type, s.phone, s.email, g.score, g.input_prof_id " + "FROM grade g "
				+ "JOIN student s ON g.student_id = s.student_id " + "JOIN subject j ON g.subject_id = j.subject_id "
				+ "JOIN department d ON s.dept_id = d.dept_id " + "WHERE g.student_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, studentId);
			
			rs = pstmt.executeQuery();

			if (rs != null && rs.next()) {
				grade = new GradeDTO2();
				grade.setSubjectName(rs.getString("subject_name"));
				grade.setStudentId(rs.getInt("student_id"));
				grade.setStudentName(rs.getString("student_name"));
				grade.setDeptName(rs.getString("dept_name"));
				grade.setMajorType(rs.getString("major_type"));
				grade.setPhone(rs.getString("phone"));
				grade.setEmail(rs.getString("email"));
				grade.setScore(rs.getString("score"));
				grade.setProfId(rs.getInt("input_prof_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return grade;
	}
	
	public GradeDTO2 gradeUpd(int studentId, int subjectId) {
		GradeDTO2 grade = null;
		String sql = "SELECT j.subject_name, g.student_id, s.student_name, d.dept_name, "
				+ "s.major_type, s.phone, s.email, g.score, g.input_prof_id " + "FROM grade g "
				+ "JOIN student s ON g.student_id = s.student_id " + "JOIN subject j ON g.subject_id = j.subject_id "
				+ "JOIN department d ON s.dept_id = d.dept_id " + "WHERE g.student_id = ? and j.subject_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, studentId);
			pstmt.setInt(2, subjectId);
			
			rs = pstmt.executeQuery();

			if (rs != null && rs.next()) {
				grade = new GradeDTO2();
				grade.setSubjectName(rs.getString("subject_name"));
				grade.setStudentId(rs.getInt("student_id"));
				grade.setStudentName(rs.getString("student_name"));
				grade.setDeptName(rs.getString("dept_name"));
				grade.setMajorType(rs.getString("major_type"));
				grade.setPhone(rs.getString("phone"));
				grade.setEmail(rs.getString("email"));
				grade.setScore(rs.getString("score"));
				grade.setProfId(rs.getInt("input_prof_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return grade;
	}

	public int gradeUpd(int studentId, int subjectId, String newScore) {
		int su = 0;
		String sql = "UPDATE grade SET score = ? WHERE student_id = ? AND subject_id = ?";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newScore);
			pstmt.setInt(2, studentId);
			pstmt.setInt(3, subjectId);

			su = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}

		return su;
	}

	public List<GradeDTO2> searchGrade(int profId, int subjectId, String NumOrName, String query) {
		List<GradeDTO2> grades = new ArrayList<>();
		String sql = "SELECT j.subject_name, g.student_id, s.student_name, d.dept_name, "
				+ "s.major_type, s.phone, s.email, g.score, g.input_prof_id, j.subject_id " + "FROM grade g "
				+ "JOIN student s ON g.student_id = s.student_id " + "JOIN subject j ON g.subject_id = j.subject_id "
				+ "JOIN department d ON s.dept_id = d.dept_id " + "WHERE g.input_prof_id = ? and j.subject_id = ?";

		boolean hasCondition = false;

		if ((NumOrName != null && !NumOrName.isEmpty()) || (query != null && !query.isEmpty())) {
			sql += (" AND " + NumOrName + " like ?");
			hasCondition = true;
		}

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, profId);
			pstmt.setInt(2, subjectId);
			if (hasCondition)
				pstmt.setString(3, "%" + query + "%");
			System.out.println(sql);
			rs = pstmt.executeQuery();

			if (rs != null) {
				while (rs.next()) {
					// 각 컬럼의 값을 DTO에 설정
					GradeDTO2 grade = new GradeDTO2();
					grade.setSubjectName(rs.getString("subject_name"));
					grade.setStudentId(rs.getInt("student_id"));
					grade.setStudentName(rs.getString("student_name"));
					grade.setDeptName(rs.getString("dept_name"));
					grade.setMajorType(rs.getString("major_type"));
					grade.setPhone(rs.getString("phone"));
					grade.setEmail(rs.getString("email"));
					grade.setScore(rs.getString("score"));
					grade.setProfId(rs.getInt("input_prof_id"));
					grade.setSubjectId(rs.getInt("subject_id"));
					grades.add(grade);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				DbClose.close(rs, pstmt, conn);
			} else {
				DbClose.close(pstmt, conn);
			}
		}

		return grades;

	}

}
