package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.TheaterVO;

@Mapper
public interface TheaterCRUDMapper {
	//등록
	public int insertTheater(TheaterVO theaterVO);
	
	//조회
	public ArrayList<TheaterVO> getList(int pageNum);
	
	//단순조회
	public ArrayList<TheaterVO> getList2();
	
	//코드로 조회
	public TheaterVO selectOne(int theaterCode);
	
	//이름으로 조회
	public ArrayList<TheaterVO> getListByName(String theaterName, int pageNum);
	
	//이름 조회 cnt
	public int theaterNameCnt(String name);
	
	//지역으로 조회
	public ArrayList<TheaterVO> getListByPlace(String theaterPlace, int pageNum);
	
	//지역 조회 cnt
	public int theaterPlaceCnt(String _place);
	
	//연락처로 조회
	public ArrayList<TheaterVO> getListByTel(String theaterTel, int pageNum);
	
	//연락처로 조회 cnt
	public int theaterTelCnt(String _tel);
	
	//수정
	public int update(TheaterVO theaterVO);
	
	//삭제
	public int delete(int theaterCode);

	public ArrayList<TheaterVO> getListGroupByPlace();

	public ArrayList<TheaterVO> getListWherePlace(String place);
	
	//영화관 cnt
	public int theaterCnt();
	
	
}
