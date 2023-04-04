package org.green.seenema.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class EventVO {
	
	private int eventNo;
	private String fileName;
    private String title;
    private String contents;
    private Date startDate;
    private Date endDate;

}
