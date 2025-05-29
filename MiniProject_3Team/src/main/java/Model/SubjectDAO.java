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

public class SubjectDAO {

	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	public ArrayList<SubjectDTO> memList = new ArrayList<SubjectDTO>();

	private static SubjectDAO instance = new SubjectDAO();

	private SubjectDAO() {
	}

	public static SubjectDAO getInstance() {
		if (instance == null) {
			instance = new SubjectDAO();
		}
		return instance;
	}

	public ArrayList<SubjectDTO> subFind(int student_id, int page, int pageSize) { // 학생이 수강중인 강의만 출력
		ArrayList<SubjectDTO> returnDTO = new ArrayList<>();

		//String sql = "select * from subject s" + " inner join enrollment e on s.subject_id = e.subject_id "
		//		+ "where e.student_id = ?";
		
		String sql = "SELECT * FROM (SELECT ROWNUM AS rnum, innerQ.* FROM "
				+ "(select * from subject s inner join enrollment e on s.subject_id = e.subject_id where e.student_id = ?) innerQ) "
				+ "WHERE rnum between ? and ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			// 페이징 계산
			int startRow = (page - 1) * pageSize + 1;
			int endRow = page * pageSize;
			
			pstmt.setInt(1, student_id);
			pstmt.setInt(2, startRow); // ROWNUM 최소값 
			pstmt.setInt(3, endRow); // ROWNUM 최대값
			
			System.out.println(student_id);
			System.out.println(startRow);
			System.out.println(endRow);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int subject_id = rs.getInt("subject_id");
				String subject_name = rs.getString("subject_name");
				int year_level = rs.getInt("year_level");
				String time = rs.getString("time");
				int credit = rs.getInt("credit");
				String is_daytime = rs.getString("is_daytime");
				String course_type = rs.getString("course_type");
				int max_students = rs.getInt("max_students");
				int current_students = rs.getInt("current_students");
				int prof_id = rs.getInt("prof_id");
				int room_id = rs.getInt("room_id");

				returnDTO.add(new SubjectDTO(subject_id, subject_name, year_level, time, credit, is_daytime,
						course_type, max_students, current_students, prof_id, room_id));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		
		return returnDTO;
	}
	
	public ArrayList<SubjectDTO> subFind(int student_id) { // 학생이 수강중인 강의만 출력
		ArrayList<SubjectDTO> returnDTO = new ArrayList<>();

		String sql = "select * from subject s" + " inner join enrollment e on s.subject_id = e.subject_id "
				+ "where e.student_id = ?";
	
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, student_id);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int subject_id = rs.getInt("subject_id");
				String subject_name = rs.getString("subject_name");
				int year_level = rs.getInt("year_level");
				String time = rs.getString("time");
				int credit = rs.getInt("credit");
				String is_daytime = rs.getString("is_daytime");
				String course_type = rs.getString("course_type");
				int max_students = rs.getInt("max_students");
				int current_students = rs.getInt("current_students");
				int prof_id = rs.getInt("prof_id");
				int room_id = rs.getInt("room_id");

				returnDTO.add(new SubjectDTO(subject_id, subject_name, year_level, time, credit, is_daytime,
						course_type, max_students, current_students, prof_id, room_id));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		
		return returnDTO;
	}

	public ArrayList<SubjectDTO> subFind(int page, int pageSize) {
		ArrayList<SubjectDTO> returnDTO = new ArrayList<>();

		//String sql = "select * from subject";
		String sql = "SELECT * FROM (SELECT ROWNUM AS rnum, innerQ.* FROM (select * from subject) innerQ)"
				+ " WHERE rnum between ? and ?";
		
		System.out.println(sql);

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			// 페이징 계산
			int startRow = (page - 1) * pageSize + 1;
			int endRow = page * pageSize;

			pstmt.setInt(1, startRow); // ROWNUM 최소값 
			pstmt.setInt(2, endRow); // ROWNUM 최대값

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int subject_id = rs.getInt("subject_id");
				String subject_name = rs.getString("subject_name");
				int year_level = rs.getInt("year_level");
				String time = rs.getString("time");
				int credit = rs.getInt("credit");
				String is_daytime = rs.getString("is_daytime");
				String course_type = rs.getString("course_type");
				int max_students = rs.getInt("max_students");
				int current_students = rs.getInt("current_students");
				int prof_id = rs.getInt("prof_id");
				int room_id = rs.getInt("room_id");

				returnDTO.add(new SubjectDTO(subject_id, subject_name, year_level, time, credit, is_daytime,
						course_type, max_students, current_students, prof_id, room_id));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return returnDTO;
	}
	

	public int subIdFind(int student_id) {
		int subjectId = 0;

		String sql = "select * from subject s" + " inner join enrollment e on s.subject_id = e.subject_id "
				+ "where e.student_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, student_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int subject_id = rs.getInt("subject_id");

				subjectId = subject_id;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return subjectId;
	}

	// 학생 수강 신청 탭 내 검색
	public ArrayList<SubjectDTO> subFind(String subjectName, String courseType, int yearLevel, String isDayTime) {
		ArrayList<SubjectDTO> returnDTO = new ArrayList<>();

		String sql = "SELECT * FROM subject WHERE 1=1";

		// 조건 추가
		if (subjectName != null && !subjectName.isEmpty()) {
			sql += " AND subject_name LIKE ?";
		}
		if (courseType != null && !courseType.isEmpty()) {
			sql += " AND course_type = ?";
		}
		if (yearLevel > 0) {
			sql += " AND year_level = ?";
		}
		if (isDayTime != null && !isDayTime.isEmpty()) {
			sql += " AND is_daytime = ?";
		}

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			int idx = 1;
			if (subjectName != null && !subjectName.isEmpty()) {
				pstmt.setString(idx++, "%" + subjectName + "%");
			}
			if (courseType != null && !courseType.isEmpty()) {
				pstmt.setString(idx++, courseType);
			}
			if (yearLevel > 0) {
				pstmt.setInt(idx++, yearLevel);
			}
			if (isDayTime != null && !isDayTime.isEmpty()) {
				pstmt.setString(idx++, isDayTime);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				SubjectDTO dto = new SubjectDTO(
						rs.getInt("subject_id"), 
						rs.getString("subject_name"),
						rs.getInt("year_level"), 
						rs.getString("time"), 
						rs.getInt("credit"), 
						rs.getString("is_daytime"),
						rs.getString("course_type"),
						rs.getInt("max_students"), 
						rs.getInt("current_students"),
						rs.getInt("prof_id"), 
						rs.getInt("room_id"));
				returnDTO.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return returnDTO;
	}

	// 학생 성적조회 탭 내 검색
	public ArrayList<SubjectDTO> subFind(int student_id, String subjectName, int yearLevel, String courseType) {
		ArrayList<SubjectDTO> returnDTO = new ArrayList<>();

		String sql = "SELECT * FROM subject s" + " INNER JOIN enrollment e ON s.subject_id = e.subject_id "
				+ "WHERE e.student_id = ?";

		// 조건 추가
		if (subjectName != null && !subjectName.isEmpty()) {
			sql += " AND subject_name LIKE ?";
		}
		if (courseType != null && !courseType.isEmpty()) {
			sql += " AND course_type = ?";
		}
		if (yearLevel > 0) {
			sql += " AND year_level = ?";
		}

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, student_id);

			int idx = 2;
			if (subjectName != null && !subjectName.isEmpty()) {
				pstmt.setString(idx++, "%" + subjectName + "%");
			}
			if (courseType != null && !courseType.isEmpty()) {
				pstmt.setString(idx++, courseType);
			}
			if (yearLevel > 0) {
				pstmt.setInt(idx++, yearLevel);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				SubjectDTO dto = new SubjectDTO(
						rs.getInt("subject_id"), 
						rs.getString("subject_name"),
						rs.getInt("year_level"),
						rs.getString("time"),
						rs.getInt("credit"),
						rs.getString("is_daytime"),
						rs.getString("course_type"), 
						rs.getInt("max_students"),
						rs.getInt("current_students"),
						rs.getInt("prof_id"), 
						rs.getInt("room_id"));
				returnDTO.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return returnDTO;
	}

	// 학생 출결조회 탭 내 검색
	public ArrayList<SubjectDTO> subFind(int student_id, String subjectName, int yearLevel) {
		ArrayList<SubjectDTO> returnDTO = new ArrayList<>();

		String sql = "SELECT * FROM subject s" + " INNER JOIN enrollment e ON s.subject_id = e.subject_id "
				+ "WHERE e.student_id = ?";

		// 조건 추가
		if (subjectName != null && !subjectName.isEmpty()) {
			sql += " AND subject_name LIKE ?";
		}
		if (yearLevel > 0) {
			sql += " AND year_level = ?";
		}

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, student_id);

			int idx = 2;
			if (subjectName != null && !subjectName.isEmpty()) {
				pstmt.setString(idx++, "%" + subjectName + "%");
			}
			if (yearLevel > 0) {
				pstmt.setInt(idx++, yearLevel);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				SubjectDTO dto = new SubjectDTO(rs.getInt("subject_id"), rs.getString("subject_name"),
						rs.getInt("year_level"), rs.getString("time"), rs.getInt("credit"), rs.getString("is_daytime"),
						rs.getString("course_type"), rs.getInt("max_students"), rs.getInt("current_students"),
						rs.getInt("prof_id"), rs.getInt("room_id"));
				returnDTO.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return returnDTO;
	}

	// subject_id로 과목 찾기(학생 성적용)
	public SubjectDTO findSubName(int subject_id) {
		SubjectDTO returnDTO = null;

		String sql = "select * from subject " + "where subject_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, subject_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String subject_name = rs.getString("subject_name");
				int year_level = rs.getInt("year_level");
				int credit = rs.getInt("credit");
				String course_type = rs.getString("course_type");

				returnDTO = new SubjectDTO(subject_name, year_level, credit, course_type);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return returnDTO;
	}

	public String findSubNameForAttendance(int subject_id) {
		String subjectName = null;

		String sql = "select * from subject " + "where subject_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, subject_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String subject_name = rs.getString("subject_name");

				subjectName = subject_name;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return subjectName;
	}

	public void incrementCurrentStudent(int subject_id) { // 수강신청하면 해당과목 수강중인 학생수 1증가
		String sql = "UPDATE subject SET current_students = current_students + 1 " + "WHERE subject_id   = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, subject_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
	}

	public int findProfessor(int subject_id) {
		String sql = "Select prof_id from subject where subject_id = ?";
		int prof_id = 0;
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, subject_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				prof_id = rs.getInt("prof_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return prof_id;
	}

	// 교수
	// DAO----------------------------------------------------------------------------
	// 전체 강의 보여주는 Select
	public List<SubjectDTO> attSel(int professorId, int page, int pageSize) {
		List<SubjectDTO> lectures = new ArrayList<>();

		String sql = "SELECT * FROM (" + "    SELECT ROWNUM AS rnum, innerQ.* " + "    FROM ("
				+ "        SELECT s.is_daytime, s.year_level, s.subject_name, s.course_type, s.credit, "
				+ "               s.prof_id, p.prof_name, s.time, r.room_name, s.max_students, s.current_students, "
				+ "               s.room_id, s.subject_id " + "        FROM subject s "
				+ "        JOIN professor p ON s.prof_id = p.prof_id "
				+ "        JOIN classroom r ON s.room_id = r.room_id " + "        WHERE s.prof_id = ? "
				+ "        ORDER BY s.subject_id" + "    ) innerQ " + "    WHERE ROWNUM <= ?" + ") "
				+ "WHERE rnum >= ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			// 페이징 계산
			int startRow = (page - 1) * pageSize + 1;
			int endRow = page * pageSize;

			pstmt.setInt(1, professorId);
			pstmt.setInt(2, endRow); // ROWNUM 최대값
			pstmt.setInt(3, startRow); // ROWNUM 최소값

			rs = pstmt.executeQuery();

			while (rs.next()) {
				SubjectDTO lecture = new SubjectDTO();
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
				lecture.setSubjectId(rs.getInt("subject_id"));

				lectures.add(lecture);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return lectures;
	}

	// 수정할 때 사용하는 Select
	public SubjectDTO getSubjectId(int subjectId) {
		SubjectDTO lecture = null;
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
				lecture = new SubjectDTO();
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
	public List<SubjectDTO> allRooms() {
		List<SubjectDTO> rooms = new ArrayList<>();
		String sql = "Select * from classroom";
		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SubjectDTO r = new SubjectDTO();
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
	public int InsLecture(SubjectDTO lecture) {
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
	public int UpdLecture(SubjectDTO lecture) {
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

	public List<SubjectDTO> searchLecture(int profId, String isDaytime, Integer yearLevel, String subjectName) {
		List<SubjectDTO> list = new ArrayList<>();

		String sql = "SELECT s.*, p.prof_name, r.room_name " + "FROM subject s "
				+ "JOIN professor p ON s.prof_id = p.prof_id " + "JOIN classroom r ON s.room_id = r.room_id "
				+ "WHERE s.prof_id = ?";

		boolean hasCondition = false;

		if ((isDaytime != null && !isDaytime.isEmpty()) || yearLevel != null
				|| (subjectName != null && !subjectName.isEmpty())) {
			sql += " AND (";
			if (isDaytime != null && !isDaytime.isEmpty()) {
				sql += "s.is_daytime = ?";
				hasCondition = true;
			}
			if (yearLevel != null) {
				if (hasCondition)
					sql += " AND ";
				sql += "s.year_level = ?";
				hasCondition = true;
			}
			if (subjectName != null && !subjectName.isEmpty()) {
				if (hasCondition)
					sql += " AND ";
				sql += "s.subject_name LIKE ?";
			}
			sql += ")";
		}

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			int idx = 1;
			pstmt.setInt(idx++, profId);
			if (isDaytime != null && !isDaytime.isEmpty())
				pstmt.setString(idx++, isDaytime);
			if (yearLevel != null)
				pstmt.setInt(idx++, yearLevel);
			if (subjectName != null && !subjectName.isEmpty())
				pstmt.setString(idx++, "%" + subjectName + "%");

			rs = pstmt.executeQuery();
			while (rs.next()) {
				SubjectDTO dto = new SubjectDTO();
				dto.setSubjectId(rs.getInt("subject_id"));
				dto.setIsDaytime(rs.getString("is_daytime"));
				dto.setYearLevel(rs.getInt("year_level"));
				dto.setSubjectName(rs.getString("subject_name"));
				dto.setCourseType(rs.getString("course_type"));
				dto.setCredit(rs.getInt("credit"));
				dto.setProfId(rs.getInt("prof_id"));
				dto.setProfName(rs.getString("prof_name"));
				dto.setTime(rs.getString("time"));
				dto.setRoomId(rs.getInt("room_id"));
				dto.setRoomName(rs.getString("room_name"));
				dto.setMaxStudents(rs.getInt("max_students"));
				dto.setCurrentStudents(rs.getInt("current_students"));
				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return list;
	}

	// 페이징 총 레코드 조회
	public int getTotalRecordCount(int professorId) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM subject WHERE prof_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, professorId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return count;
	}
	
	public int getStudentTotalRecordCount() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM subject";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}

		return count;
	}
	
	public int getStudentTotalEnrolledRecordCount(int student_id) { // 학생이 수강중인 과목 갯수 얻기
		int count = 0;
		
		String sql = "SELECT COUNT(*) FROM enrollment where student_id = ? and is_enrolled = 'Y'";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, student_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		System.out.println("수강중인 강의 갯수 : "+count);

		return count;
		
	}
	
	public int DelSubject(int subjectId, int profId) {
		int result = 0;
		String sql = "DELETE FROM subject WHERE subject_id = ? AND prof_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, subjectId);
			pstmt.setInt(2, profId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}

		return result;
	}

}
