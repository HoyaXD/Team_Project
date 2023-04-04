package org.green.seenema.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMainPageMapper {
	
	public int todayMainMovieCount();
	
	public int getTodayEndMovieCount();
	
	public int getTodayReservationCount();
	
	public int getTodayReservationCancelCount();
	
	public int getTodayQnaWaitingCount();
	
	public int getTodayQnaCompleteCount();
	
	public int getTodayProductSalesCount();
	
	public int getTodayProductCancelCount();

}
