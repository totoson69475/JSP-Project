package Model;

public class GradeDTO {
	private int grade_id;
	private int student_id;
	private int subject_id;
	private int input_prof_id;
	private String score;

	public GradeDTO() {
	}

	public GradeDTO(int student_id, int subject_id, String score) {
		this.student_id = student_id;
		this.subject_id = subject_id;
		this.score = score;
	}

	public int getGrade_id() {
		return grade_id;
	}

	public void setGrade_id(int grade_id) {
		this.grade_id = grade_id;
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

	public int getInput_prof_id() {
		return input_prof_id;
	}

	public void setInput_prof_id(int input_prof_id) {
		this.input_prof_id = input_prof_id;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

}
