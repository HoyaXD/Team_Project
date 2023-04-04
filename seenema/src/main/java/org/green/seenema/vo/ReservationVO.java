package org.green.seenema.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class ReservationVO {
	private String id;
	private Long ticketCode;
	private int movieCode;
	private String movieTitle;
	private String theaterPlace;
	private String theater;
	private int ticketPrice;
	private Timestamp reservationDate;
	private Date movieDate;
	private String reservationTime;
	private String seats;
	private int visitors;
	private int status;
	private Date searchDate;
}
