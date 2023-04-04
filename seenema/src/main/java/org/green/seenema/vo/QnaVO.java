package org.green.seenema.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class QnaVO {
	private int qcode;
	private String id;
	private String title;
	private String contents;
	private Timestamp regiDate;
	private String fileName;
	private String status;
	private String answer;
}
