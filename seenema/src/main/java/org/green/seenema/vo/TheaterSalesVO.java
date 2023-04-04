package org.green.seenema.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class TheaterSalesVO {
	int theaterCode;
	String theater;
	int visitors;
}
