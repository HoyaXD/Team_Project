package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.ReplyVO;

@Mapper
public interface ReplyMapper {
	public int regReply(ReplyVO reply);
	public ArrayList<ReplyVO> getReplyList(@Param("movieCode")int movieCode, @Param("count") int count);
	public ReplyVO getReplyInfo(int replyCode);
	public int updateReply(ReplyVO reply);
	public int deleteReply(int replyCode);
	public int getReplyCount(int movieCode);
}
