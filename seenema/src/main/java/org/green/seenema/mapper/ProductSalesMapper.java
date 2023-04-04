package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.ProductSalesVO;

@Mapper
public interface ProductSalesMapper {
	
	//상품 월별 합계출력
	public List<ProductSalesVO> monthTotalPirce();
	
	//상품별 매출
	public List<ProductSalesVO> productTotalView();
	
	//성별간 매출
	public List<ProductSalesVO> productManView();
	
	public List<ProductSalesVO> productWomanView();

	public List<ProductSalesVO> genderTotalPriceView();
	


}
