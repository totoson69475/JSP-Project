package Model;

import java.sql.Date;

public class StudentDTO {

	private int student_id;
	private int dept_id;
	private int prof_id;
	private String student_name;
	private String student_password;
	private String major_type;
	private Date birthdate;
	private String phone;
	private String address;
	private String email;
	private String etc;

	public StudentDTO(int student_id, int dept_id, int prof_id, String student_name, String student_password,
			String major_type, Date birthdate, String phone, String address, String email, String etc) {
		super();
		this.student_id = student_id;
		this.dept_id = dept_id;
		this.prof_id = prof_id;
		this.student_name = student_name;
		this.student_password = student_password;
		this.major_type = major_type;
		this.birthdate = birthdate;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.etc = etc;
	}

	// student_profile(학생 정보 수정)
	public StudentDTO(int student_id, String student_name, Date birthdate, String phone, String address, String email,
			String etc) {
		this.student_id = student_id;
		this.student_name = student_name;
		this.birthdate = birthdate;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.etc = etc;
	}

	public int getStudent_id() {
		return student_id;
	}

	public void setStudent_id(int student_id) {
		this.student_id = student_id;
	}

	public int getDept_id() {
		return dept_id;
	}

	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}

	public int getProf_id() {
		return prof_id;
	}

	public void setProf_id(int prof_id) {
		this.prof_id = prof_id;
	}

	public String getStudent_name() {
		return student_name;
	}

	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}

	public String getStudent_password() {
		return student_password;
	}

	public void setStudent_password(String student_password) {
		this.student_password = student_password;
	}

	public String getMajor_type() {
		return major_type;
	}

	public void setMajor_type(String major_type) {
		this.major_type = major_type;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

}
