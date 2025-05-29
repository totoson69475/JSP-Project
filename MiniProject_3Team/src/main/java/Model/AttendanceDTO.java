package Model;

public class AttendanceDTO {
	private int attendance_id;
	private int student_id;
	private int subject_id;
	private int week_id;
	private int attendance_status_id;
	private int input_prof_id;

	// attendance_status_name
	private String attendance_status_name;

	public AttendanceDTO() {
	}

	public AttendanceDTO(int week_id, int attendance_status_id) {
		this.week_id = week_id;
		this.attendance_status_id = attendance_status_id;
	}

	public int getAttendance_id() {
		return attendance_id;
	}

	public void setAttendance_id(int attendance_id) {
		this.attendance_id = attendance_id;
	}

	public int getStudent_id() {
		return student_id;
	}

	public void setStudent_id(int student_id) {
		this.student_id = student_id;
	}

	public int getSubject_id() {
		return subject_id;
	}

	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}

	public int getWeek_id() {
		return week_id;
	}

	public void setWeek_id(int week_id) {
		this.week_id = week_id;
	}

	public int getAttendance_status_id() {
		return attendance_status_id;
	}

	public void setAttendance_status_id(int attendance_status_id) {
		this.attendance_status_id = attendance_status_id;
	}

	public int getInput_prof_id() {
		return input_prof_id;
	}

	public void setInput_prof_id(int input_prof_id) {
		this.input_prof_id = input_prof_id;
	}

	// attendance_status_name
	public String getAttendance_status_name() {
		return attendance_status_name;
	}

	public void setAttendance_status_name(String attendance_status_name) {
		this.attendance_status_name = attendance_status_name;
	}

}
