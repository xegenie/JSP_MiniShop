package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product 상품 정보 (입출고 관련 필드 포함)
	 * @param type 입출고 타입 (IN/OUT)
	 * @return 삽입된 행의 개수 (성공 시 1, 실패 시 0)
	 */
	public int insert(Product product) {
	    int result = 0;
	    String sql = "INSERT INTO product_io (product_id, order_no, amount, type, io_date, user_id) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, ?)";

	    try {
	    	psmt = con.prepareStatement(sql);
	        
	        // 각 필드에 값 설정
	        psmt.setString(1, product.getProductId()); // 상품 ID
	        psmt.setObject(2, product.getOrderNo()); // 주문 번호 (nullable)
	        psmt.setInt(3, product.getAmount()); // 입출고량
	        psmt.setString(4, product.getType()); // 입출고 타입
	        psmt.setString(5, product.getUserId()); // 사용자 ID (nullable)

	        result = psmt.executeUpdate(); // 삽입된 행의 개수를 반환
	    } catch (SQLException e) {
	        System.err.println("상품 입출고 등록 중 오류 발생!");
	        e.printStackTrace();
	    }

	    return result; // 삽입된 행의 개수 반환
	}

}
