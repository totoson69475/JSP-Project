package Model;

public class EnrollmentDTO {
	private int enroll_id;
	private int student_id;
	private int subject_id;
	private String is_enrolled;

	public EnrollmentDTO() {
	}

	public EnrollmentDTO(int student_id, int subject_id) {
		this.student_id = student_id;
		this.subject_id = subject_id;
	}

	public int getEnroll_id() {
		return enroll_id;
	}

	public void setEnroll_id(int enroll_id) {
		this.enroll_id = enroll_id;
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

	public String getIs_enrolled() {
		return is_enrolled;
	}

	public void setIs_enrolled(String is_enrolled) {
		this.is_enrolled = is_enrolled;
	}

}
