package Model;

import java.util.Date;

public class ProfessorDTO {
	private int prof_id;
	private int dept_id;
	private String prof_name;
	private String prof_password;
	private Date birthdate;
	private String phone;
	private String address;
	private String email;
	private String etc;

	public ProfessorDTO(int prof_id, int dept_id, String prof_name, String prof_password, Date birthdate, String phone,
			String address, String email, String etc) {
		super();
		this.prof_id = prof_id;
		this.dept_id = dept_id;
		this.prof_name = prof_name;
		this.prof_password = prof_password;
		this.birthdate = birthdate;
		this.phone = phone;
		this.address = address;
		this.email = email;
		this.etc = etc;
	}

	public ProfessorDTO(int prof_id, int dept_id, String prof_name, String etc, Date birthdate, String phone,
			String address, String email) {
		super();
		this.prof_id = prof_id;
		this.dept_id = dept_id;
		this.prof_name = prof_name;
		this.etc = etc;
		this.birthdate = birthdate;
		this.phone = phone;
		this.address = address;
		this.email = email;
	}

	public int getProf_id() {
		return prof_id;
	}

	public void setProf_id(int prof_id) {
		this.prof_id = prof_id;
	}

	public int getDept_id() {
		return dept_id;
	}

	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}

	public String getProf_name() {
		return prof_name;
	}

	public void setProf_name(String prof_name) {
		this.prof_name = prof_name;
	}

	public String getProf_password() {
		return prof_password;
	}

	public void setProf_password(String prof_password) {
		this.prof_password = prof_password;
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
