package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import DBSetting.DbClose;
import DBSetting.DbSet;

public class ProfessorDAO {

	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	public ArrayList<ProfessorDTO> memList = new ArrayList<ProfessorDTO>();

	private static ProfessorDAO instance = new ProfessorDAO();

	private ProfessorDAO() {
	}

	public static ProfessorDAO getInstance() {
		if (instance == null) {
			instance = new ProfessorDAO();
		}
		return instance;
	}

	public ProfessorDTO proLog(int id, String pwd) {
		int vId = id;
		String vPwd = pwd;
		ProfessorDTO returnDTO = null;

		int su = 0;
		String sql = "select * from professor " + "where prof_id = ? AND prof_password = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, vId);
			pstmt.setString(2, vPwd);

			su = pstmt.executeUpdate();

			if (su != 0) {
				returnDTO = proFind(id, pwd);
				System.out.println(vId + "회원 로그인 성공!!");
			} else {
				System.out.println(vId + "회원 로그인 실패!!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(pstmt, conn);
		}
		return returnDTO;
	}

	public ProfessorDTO proFind(int id, String pwd) {
		ProfessorDTO returnDTO = null;

		String sql = "select * from professor " + "where prof_id = ? AND prof_password = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setString(2, pwd);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int vId = rs.getInt("prof_id");
				int vDeptId = rs.getInt("dept_id");
				String vName = rs.getString("prof_name");
				String vPwd = rs.getString("prof_password");
				Date vBirthdate = rs.getDate("birthdate");
				String vPhone = rs.getString("phone");
				String vAddr = rs.getString("address");
				String vEmail = rs.getString("email");
				String vEtc = rs.getString("etc");

				returnDTO = new ProfessorDTO(vId, vDeptId, vName, vPwd, vBirthdate, vPhone, vAddr, vEmail, vEtc);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return returnDTO;
	}

	// 교수 이름 찾기
	public String getProfName(int id) {
		String profName = "";

		String sql = "select * from professor " + "where prof_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				profName = rs.getString("prof_name");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbClose.close(rs, pstmt, conn);
		}
		return profName;
	}

	// 프로필 수정
	public ProfessorDTO proUpd(int profId, int deptId, String name, String etc, Date birthdate, String phone,
			String addr, String email) {
		ProfessorDTO returnDTO = null;

		String sql = "UPDATE professor " + "SET dept_id   = ?, " + "    prof_name = ?, " + "    etc  = ?, "
				+ "    birthdate = ?, " + "    phone     = ?, " + "    address   = ?, " + "    email     = ? "
				+ "WHERE prof_id = ?";

		try {
			conn = DbSet.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, deptId);
			pstmt.setString(2, name);
			pstmt.setString(3, etc);

			if (birthdate != null) {
				pstmt.setDate(4, new java.sql.Date(birthdate.getTime()));
			} else {
				pstmt.setNull(4, java.sql.Types.DATE);
			}

			pstmt.setString(5, phone);
			pstmt.setString(6, addr);
			pstmt.setString(7, email);
			pstmt.setInt(8, profId);

			int su = pstmt.executeUpdate();
			System.out.println("Updated rows: " + su);
			if (su > 0) {
				returnDTO = new ProfessorDTO(profId, deptId, name, etc, birthdate, phone, addr, email);
			} else {
				System.out.println("No rows updated. ID 혹은 데이터 확인 필요.");
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}

		return returnDTO;
	}

}
