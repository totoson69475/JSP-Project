package Model;

public class SubjectDTO {
	private int subject_id;
	private String subject_name;
	private int year_level;
	private String time;
	private int credit;
	private String is_daytime;
	private String course_type;
	private int max_students;
	private int current_students;
	private int prof_id;
	private int room_id;

	public SubjectDTO() {
	}

	public SubjectDTO(String subject_name, int year_level, int credit, String course_type) {
		this.subject_name = subject_name;
		this.year_level = year_level;
		this.credit = credit;
		this.course_type = course_type;
	}

	public SubjectDTO(int subject_id, String subject_name, int year_level, String time, int credit, String is_daytime,
			String course_type, int max_students, int current_students, int prof_id, int room_id) {
		super();
		this.subject_id = subject_id;
		this.subject_name = subject_name;
		this.year_level = year_level;
		this.time = time;
		this.credit = credit;
		this.is_daytime = is_daytime;
		this.course_type = course_type;
		this.max_students = max_students;
		this.current_students = current_students;
		this.prof_id = prof_id;
		this.room_id = room_id;

	}

	public SubjectDTO(int subject_id) {
		this.subject_id = subject_id;
	}

	public int getSubject_id() {
		return subject_id;
	}

	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}

	public String getSubject_name() {
		return subject_name;
	}

	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}

	public int getYear_level() {
		return year_level;
	}

	public void setYear_level(int year_level) {
		this.year_level = year_level;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getCredit() {
		return credit;
	}

	public void setCredit(int credit) {
		this.credit = credit;
	}

	public String getIs_daytime() {
		return is_daytime;
	}

	public void setIs_daytime(String is_daytime) {
		this.is_daytime = is_daytime;
	}

	public String getCourse_type() {
		return course_type;
	}

	public void setCourse_type(String course_type) {
		this.course_type = course_type;
	}

	public int getMax_students() {
		return max_students;
	}

	public void setMax_students(int max_students) {
		this.max_students = max_students;
	}

	public int getCurrent_students() {
		return current_students;
	}

	public void setCurrent_students(int current_students) {
		this.current_students = current_students;
	}

	public int getProf_id() {
		return prof_id;
	}

	public void setProf_id(int prof_id) {
		this.prof_id = prof_id;
	}

	public int getRoom_id() {
		return room_id;
	}

	public void setRoom_id(int room_id) {
		this.room_id = room_id;
	}

	// 교수 DTO------------------------------------------------------------------
	private String isDaytime;
	private int yearLevel;
	private String subjectName;
	private String courseType;
	private String profName;
	private String roomName;
	private int maxStudents;
	private int currentStudents;
	private int roomId;
	private int profId;
	private int subjectId;

	// Getter and Setter methods

	public int getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(int subjectId) {
		this.subjectId = subjectId;
	}

	public int getProfId() {
		return profId;
	}

	public void setProfId(int profId) {
		this.profId = profId;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}

	public String getIsDaytime() {
		return isDaytime;
	}

	public void setIsDaytime(String isDaytime) {
		this.isDaytime = isDaytime;
	}

	public int getYearLevel() {
		return yearLevel;
	}

	public void setYearLevel(int yearLevel) {
		this.yearLevel = yearLevel;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public String getCourseType() {
		return courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}

	public String getProfName() {
		return profName;
	}

	public void setProfName(String profName) {
		this.profName = profName;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public int getMaxStudents() {
		return maxStudents;
	}

	public void setMaxStudents(int maxStudents) {
		this.maxStudents = maxStudents;
	}

	public int getCurrentStudents() {
		return currentStudents;
	}

	public void setCurrentStudents(int currentStudents) {
		this.currentStudents = currentStudents;
	}

}
