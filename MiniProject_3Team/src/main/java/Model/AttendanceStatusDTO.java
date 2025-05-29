package Model;

public class AttendanceStatusDTO {
	private int attendance_status_id;
	private String attendance_status_name;

	public AttendanceStatusDTO() {
	}

	public int getAttendance_status_id() {
		return attendance_status_id;
	}

	public void setAttendance_status_id(int attendance_status_id) {
		this.attendance_status_id = attendance_status_id;
	}

	public String getAttendance_status_name() {
		return attendance_status_name;
	}

	public void setAttendance_status_name(String attendance_status_name) {
		this.attendance_status_name = attendance_status_name;
	}

}
