package org.green.seenema.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class MovieSalesVO {
	
	int reservationCnt;
	String movieTitle;
	int movieCode;
	String genre;
}
