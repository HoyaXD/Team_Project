package org.green.seenema.user.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.NoticeVO;
import org.green.seenema.vo.ProductVO;

@Mapper
public interface UserMainMapper {
	public List<MovieVO> getMainMovieList();
	public MovieVO getMovieDetail(String movieCode);
	public List<ProductVO> getStoreList();
	public List<NoticeVO> getMainNoticeList();
}
