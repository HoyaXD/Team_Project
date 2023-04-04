package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.EventVO;

@Mapper
public interface AdminEventMapper {
	
	public int insertEvent(EventVO e);
	
	public List<EventVO> getEventList();
	
	public List<EventVO> getEvenetDetail(int eventNo);
	
	public void editEvent(EventVO e);
	
	public void delEvent(@Param("eventNo") int eventNo);

}
