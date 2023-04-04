package org.green.seenema.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.MovieVO;

import java.util.List;

@Mapper
public interface MovieMapper {
    public List<MovieVO> getMovieList();

    public String selectOne(int movieCode);
    public String loadPlayingTime(int movieCode);
}
