package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.ProductVO;

@Mapper
public interface ProductCRUDMapper {
	//상품등록
	public int insert(ProductVO product);
	
	//상품조회
	public ArrayList<ProductVO> getList(int pageNum);
	
	//상품 cnt
	public int getCnt();
	
	//상품코드로 상품조회하기
	public ProductVO selectOne(int productCode);
	
	//상품삭제
	public int delete(int productCode);
	
	//상품수정
	public int update(ProductVO product);
	
	//상품명으로 상품조회
	public ArrayList<ProductVO> getListByName(String productName, int pageNum);
	
	//상품명으로 상품조회 cnt
	public int getListByNameCnt(String productName);
	
	//가격대로 상품조회
	public ArrayList<ProductVO> getListByPrice(int start, int end, int pageNum);
	
	//가격대로 상품조회 cnt
	public int productByPriceCnt(int start, int end);
	
	//카테고리 조회
	public ArrayList<ProductVO> getListByCategory(String category, int pageNum);
	
	//카테고리 조회 cnt
	public int productByCategoryCnt(String category);
	
	//낮은 가격 순 정렬
	public ArrayList<ProductVO> getListByLowPrice(int pageNum);
	
	//낮은 가격 순 정렬 cnt
	public int listByLowPriceCnt();
	
	//높은 가격 순 정렬
	public ArrayList<ProductVO> getListByHighPrice();
	
	//판매량 낮은 순으로 정렬
	public ArrayList<ProductVO> getListByLowSales();
	
	//판매량 높은 순으로 정렬
	public ArrayList<ProductVO> getListByHighSales();
	
	//--
	
	//상품명 > 카테고리 정렬
	public ArrayList<ProductVO> getListNameCategory(String productName, String category);
	
	//상품명 > 낮은 가격 정렬
	public ArrayList<ProductVO> getListNameLowPrice(String productName);
	
	//상품명 > 높은 가격 정렬
	public ArrayList<ProductVO> getListNameHighPrice(String productName);
	
	//상품명 > 낮은 판매량 정렬
	public ArrayList<ProductVO> getListNameLowSales(String productName);
	
	//상품명 > 높은 판매량 정렬
	public ArrayList<ProductVO> getListNameHighSales(String productName);
	
	//--
	
	//가격대 > 카테고리 정렬
	public ArrayList<ProductVO> geListPriceCategory(int start, int end, String category);
	
	//가격대 > 낮은 가격 정렬
	public ArrayList<ProductVO> getListPriceLowPrice(int start, int end);
	
	//가격대 > 높은 가격 정렬
	public ArrayList<ProductVO> getListPriceHighPrice(int start, int end);
	
	//가격대 > 낮은 판매량 정렬
	public ArrayList<ProductVO> getListPriceLowSales(int start, int end);
	
	//가격대 > 높은 판매량 정렬
	public ArrayList<ProductVO> getListPriceHighSales(int start, int end);
	
	//--
	
	//카테고리 > 낮은 가격 정렬
	public ArrayList<ProductVO> getListCategoryLowPrice(String category);
	
	//카테고리 > 높은 가격 정렬
	public ArrayList<ProductVO> getListCategoryHighPrice(String category);
	
	//카테고리 > 낮은 판매량 정렬
	public ArrayList<ProductVO> getListCategoryLowSales(String category);
	
	//카테고리 > 높은 판매량 정렬
	public ArrayList<ProductVO> getListCategoryHighSales(String category);
}
