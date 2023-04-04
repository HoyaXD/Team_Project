package org.green.seenema.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class CartVO {
	private int cartCode;
	private int productCode;
	private String productImage;
	private String productName;
	private String productInfo;
	private int price;
	private int productCount;
	private int totalPrice;
	private String id;
}
