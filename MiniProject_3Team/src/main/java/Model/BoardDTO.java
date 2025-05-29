package Model;

import java.sql.Date;

public class BoardDTO {
	private int board_num;
	private int writer_prof_id;
	private String board_title;
	private String board_content;
	private String board_regtime;
	private int board_views;
	
	public BoardDTO(int board_num, int writer_prof_id, String board_title, String board_content, String board_regtime,
			int board_views) {
		super();
		this.board_num = board_num;
		this.writer_prof_id = writer_prof_id;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_regtime = board_regtime;
		this.board_views = board_views;
	}
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getWriter_prof_id() {
		return writer_prof_id;
	}
	public void setWriter_prof_id(int writer_prof_id) {
		this.writer_prof_id = writer_prof_id;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_regtime() {
		return board_regtime;
	}
	public void setBoard_regtime(String board_regtime) {
		this.board_regtime = board_regtime;
	}
	public int getBoard_views() {
		return board_views;
	}
	public void setBoard_views(int board_views) {
		this.board_views = board_views;
	}
	
	
	

}
