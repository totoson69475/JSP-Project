package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class AttendanceDAO {
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	private static AttendanceDAO instance = new AttendanceDAO();

	private AttendanceDAO() {
	}

	public static AttendanceDAO getInstance() {
		if (instance == null) {
			instance = new AttendanceDAO();
		}
		return instance;
	}

	// 학번이랑 과목 번호로 해당 출석 정보(주차, 출결) 가져오기
	/*
	 * public ArrayList<AttendanceDTO> findAttendance(int student_id, int
	 * subject_id){ ArrayList<AttendanceDTO> returnDTO = new ArrayList<>(); String
	 * sql = "select * from attendance " +
	 * "where student_id = ? AND subject_id = ?";
	 * 
	 * try { conn = DbSet.getConnection(); pstmt = conn.prepareStatement(sql);
	 * pstmt.setInt(1, student_id); pstmt.setInt(2, subject_id);
	 * 
	 * rs = pstmt.executeQuery();
	 * 
	 * while(rs.next()) { int week_id = rs.getInt("week_id"); int
	 * attendance_status_id = rs.getInt("attendance_status_id");
	 * 
	 * returnDTO.add(new AttendanceDTO(week_id, attendance_status_id)); }
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); } finally {
	 * DbClose.close(rs,pstmt,conn); } return returnDTO; }
	 */

	public ArrayList<AttendanceDTO> findAttendance(int student_id, int subject_id) {
		ArrayList<AttendanceDTO> list = new ArrayList<>();
		String sql = "SELECT a.subject_id, a.week_id, s.attendance_status_name " + "FROM attendance a "
				+ "JOIN attendance_status s ON a.attendance_status_id = s.attendance_status_id "
				+ "WHERE a.student_id = ? AND a.subject_id = ? " + "ORDER BY a.week_id";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, student_id);
			pstmt.setInt(2, subject_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				AttendanceDTO dto = new AttendanceDTO();
				dto.setSubject_id(rs.getInt("subject_id"));
				dto.setWeek_id(rs.getInt("week_id"));
				dto.setAttendance_status_name(rs.getString("attendance_status_name"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return list;
	}

	public ArrayList<AttendanceDTO> findAttendance(int subject_id, String NumOrName, String query) {
		ArrayList<AttendanceDTO> list = new ArrayList<>();
		String sql = "SELECT a.student_id, a.subject_id, a.week_id, s.attendance_status_name, st.student_name "
				+ "FROM attendance a " + "JOIN attendance_status s ON a.attendance_status_id = s.attendance_status_id "
				+ "JOIN student st ON a.student_id = st.student_id " + "WHERE a.subject_id = ? ";

		boolean hasCondition = false;

		if ((NumOrName != null && !NumOrName.isEmpty()) || (query != null && !query.isEmpty())) {
			sql += (" AND " + NumOrName + " like ? ");
			hasCondition = true;
		}
		sql += " ORDER BY a.student_id, a.week_id ";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, subject_id);
			if (hasCondition)
				pstmt.setString(2, "%" + query + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				AttendanceDTO dto = new AttendanceDTO();
				dto.setStudent_id(rs.getInt("student_id"));
				dto.setSubject_id(rs.getInt("subject_id"));
				dto.setWeek_id(rs.getInt("week_id"));
				dto.setAttendance_status_name(rs.getString("attendance_status_name"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return list;
	}

	public Map<Integer, List<AttendanceDTO>> getSubjectAllStudentAttendance(int subject_id, String NumOrName,
			String query) {
		List<AttendanceDTO> attendanceList = findAttendance(subject_id, NumOrName, query);
		Map<Integer, List<AttendanceDTO>> studentAttendanceMap = new HashMap<>();

		for (AttendanceDTO dto : attendanceList) {
			int studentId = dto.getStudent_id();
			studentAttendanceMap.putIfAbsent(studentId, new ArrayList<>());
			studentAttendanceMap.get(studentId).add(dto);
		}
		return studentAttendanceMap;
	}

	public void createAttendance(int student_id, int subject_id, int week_id, int input_prof_id) {
		String sql = "INSERT INTO attendance " + "VALUES (subject_seq.NEXTVAL, ?, ?, ?, ?, ?)";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, student_id);
			pstmt.setInt(2, subject_id);
			pstmt.setInt(3, week_id);
			pstmt.setInt(4, 5);
			pstmt.setInt(5, input_prof_id);

			rs = pstmt.executeQuery();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
	}

	public void attendanceUpdate(int attendance_status_id, int student_id, int subject_id, int week_id) {

		int su = 0;

		String sql = "UPDATE attendance SET " + "attendance_status_id = ? "
				+ "WHERE student_id = ? AND subject_id = ? AND week_id = ? ";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attendance_status_id);
			pstmt.setInt(2, student_id);
			pstmt.setInt(3, subject_id);
			pstmt.setInt(4, week_id);
			su = pstmt.executeUpdate();
			// executeUpdate()는 쿼리문이 성공할 경우 1, 실패할 경우 0 반환

			if (su > 0) { // 업데이트 성공했을 때만
				System.out.println("출석정보 업데이트 성공!!!!!");
			} else {
				System.out.println("출석정보 업데이트 실패.................");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
	}

}
