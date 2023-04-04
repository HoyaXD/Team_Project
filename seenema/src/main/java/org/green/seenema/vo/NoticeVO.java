package org.green.seenema.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {
	private int noticeCode;
	private String title;
	private String contents;
	private Date regiDate;
	private int hit;
	private int importance; //중요도
}
