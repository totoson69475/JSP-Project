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

public class LectureDAO {

	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	private static LectureDAO instance = new LectureDAO();

	private LectureDAO() {
	}

	public static LectureDAO getInstance() {
		if (instance == null) {
			instance = new LectureDAO();
		}
		return instance;
	}

	// 전체 강의 보여주는 Select
	public List<LectureDTO> attSel(int professorId) {
		List<LectureDTO> lectures = new ArrayList<>();
		String sql = "SELECT s.is_daytime, s.year_level, s.subject_name, s.course_type, s.credit, "
				+ "s.prof_id, p.prof_name, s.time, r.room_name, s.max_students, s.current_students, s.room_id, s.subject_id "
				+ "FROM subject s " + "JOIN professor p ON s.prof_id = p.prof_id "
				+ "JOIN classroom r ON s.room_id = r.room_id " + "WHERE s.prof_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, professorId);
			rs = pstmt.executeQuery();

			if (rs != null) {
				while (rs.next()) {
					// 각 컬럼의 값을 DTO에 설정
					LectureDTO lecture = new LectureDTO();
					lecture.setIsDaytime(rs.getString("is_daytime"));
					lecture.setYearLevel(rs.getInt("year_level"));
					lecture.setSubjectName(rs.getString("subject_name"));
					lecture.setCourseType(rs.getString("course_type"));
					lecture.setCredit(rs.getInt("credit"));
					lecture.setProfId(rs.getInt("prof_ID"));
					lecture.setProfName(rs.getString("prof_name"));
					lecture.setTime(rs.getString("time"));
					lecture.setRoomName(rs.getString("room_name"));
					lecture.setMaxStudents(rs.getInt("max_students"));
					lecture.setCurrentStudents(rs.getInt("current_students"));
					lecture.setRoomId(rs.getInt("room_id"));
					lecture.setSubjectId(rs.getInt("subject_id"));
					lectures.add(lecture);
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

		return lectures;
	}

	// 수정할 때 사용하는 Select
	public LectureDTO getSubjectId(int subjectId) {
		LectureDTO lecture = null;
		String sql = "SELECT s.is_daytime, s.year_level, s.subject_name, s.course_type, s.credit, "
				+ "s.prof_id, p.prof_name, s.time, r.room_name, s.max_students, s.current_students, s.room_id, s.subject_id "
				+ "FROM subject s " + "JOIN professor p ON s.prof_id = p.prof_id "
				+ "JOIN classroom r ON s.room_id = r.room_id " + "WHERE s.subject_id = ?"; // subjectId를 통해 강의 정보 조회

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, subjectId); // subjectId로 강의 정보를 조회
			rs = pstmt.executeQuery();

			if (rs.next()) {
				lecture = new LectureDTO();
				lecture.setSubjectId(rs.getInt("subject_id"));
				lecture.setIsDaytime(rs.getString("is_daytime"));
				lecture.setYearLevel(rs.getInt("year_level"));
				lecture.setSubjectName(rs.getString("subject_name"));
				lecture.setCourseType(rs.getString("course_type"));
				lecture.setCredit(rs.getInt("credit"));
				lecture.setProfId(rs.getInt("prof_id"));
				lecture.setProfName(rs.getString("prof_name"));
				lecture.setTime(rs.getString("time"));
				lecture.setRoomName(rs.getString("room_name"));
				lecture.setMaxStudents(rs.getInt("max_students"));
				lecture.setCurrentStudents(rs.getInt("current_students"));
				lecture.setRoomId(rs.getInt("room_id"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return lecture;
	}

	// 강의실 보여주는 Select
	public List<LectureDTO> allRooms() {
		List<LectureDTO> rooms = new ArrayList<>();
		String sql = "Select * from classroom";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				LectureDTO r = new LectureDTO();
				r.setRoomId(rs.getInt("room_id"));
				r.setRoomName(rs.getString("room_name"));
				rooms.add(r);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return rooms;
	}

	// 강의 생성 Insert
	public int InsLecture(LectureDTO lecture) {
		int rows = 0;
		String sql = "INSERT INTO subject " + "(subject_id, is_daytime, year_level, subject_name, course_type, credit, "
				+ "prof_id, time, room_id, max_students, current_students) "
				+ "VALUES (subject_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, lecture.getIsDaytime());
			pstmt.setInt(2, lecture.getYearLevel());
			pstmt.setString(3, lecture.getSubjectName());
			pstmt.setString(4, lecture.getCourseType());
			pstmt.setInt(5, lecture.getCredit());
			pstmt.setInt(6, lecture.getProfId());
			pstmt.setString(7, lecture.getTime());
			pstmt.setInt(8, lecture.getRoomId());
			pstmt.setInt(9, lecture.getMaxStudents());
			pstmt.setInt(10, lecture.getCurrentStudents());

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}

		return rows;
	}

	// 강의 수정 Update
	public int UpdLecture(LectureDTO lecture) {
		int rows = 0;
		String sql = "UPDATE subject SET " + "  is_daytime       = ?, " + "  year_level       = ?, "
				+ "  subject_name     = ?, " + "  course_type      = ?, " + "  credit           = ?, "
				+ "  prof_id          = ?, " + "  time             = ?, " + "  room_id          = ?, "
				+ "  max_students     = ?, " + "  current_students = ? " + "WHERE subject_id   = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, lecture.getIsDaytime());
			pstmt.setInt(2, lecture.getYearLevel());
			pstmt.setString(3, lecture.getSubjectName());
			pstmt.setString(4, lecture.getCourseType());
			pstmt.setInt(5, lecture.getCredit());
			pstmt.setInt(6, lecture.getProfId());
			pstmt.setString(7, lecture.getTime());
			pstmt.setInt(8, lecture.getRoomId());
			pstmt.setInt(9, lecture.getMaxStudents());
			pstmt.setInt(10, lecture.getCurrentStudents());
			pstmt.setInt(11, lecture.getSubjectId());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return rows;
	}

}
