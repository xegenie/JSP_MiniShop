package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {
	
	/**
	 * 상품 목록
	 * 
	 * @return
	 */
	public List<Product> list() {
		List<Product> productList = new ArrayList<>();
		String sql = "SELECT * FROM product"; // 모든 상품을 조회하는 쿼리

		try {
			psmt = con.prepareStatement(sql);

			rs = psmt.executeQuery(); // 쿼리 실행
			while (rs.next()) {
				Product product = new Product();
				product.setProductId(rs.getString("product_id"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setUnitsInStock(rs.getInt("units_in_stock"));
				product.setCondition(rs.getString("condition"));
				product.setFile(rs.getString("file"));
				product.setQuantity(rs.getInt("quantity"));

				productList.add(product); // 리스트에 상품 추가
			}
		} catch (SQLException e) {
			System.err.println("상품 목록 조회 중 오류 발생!");
			e.printStackTrace();
		}

		return productList; // 상품 리스트 반환
	}
	
	
	/**
	 * 상품 목록 검색
	 * @param keyword 검색할 키워드
	 * @return 검색된 상품 리스트
	 */
	public List<Product> list(String keyword) {
	    List<Product> productList = new ArrayList<>();
	    String sql = "SELECT * FROM product WHERE name LIKE ? OR description LIKE ?"; // 상품명 또는 설명에서 키워드 검색

//	    String sql = "SELECT *"
//	    		+ "FROM product"
//	    		+ "WHERE name LIKE CONCAT('%', '상품명', '%')"; // 문자열 연결
	    try {
	    	psmt = con.prepareStatement(sql);
	        
	        // 키워드에 '%'를 추가하여 LIKE 검색 수행
	        psmt.setString(1, keyword);
	        psmt.setString(2, keyword);

	        rs = psmt.executeQuery(); // 쿼리 실행
	        while (rs.next()) {
	            Product product = new Product(); // 상품 객체 생성
	            product.setProductId(rs.getString("product_id"));
	            product.setName(rs.getString("name"));
	            product.setUnitPrice(rs.getInt("unit_price"));
	            product.setDescription(rs.getString("description"));
	            product.setManufacturer(rs.getString("manufacturer"));
	            product.setCategory(rs.getString("category"));
	            product.setUnitsInStock(rs.getInt("units_in_stock"));
	            product.setCondition(rs.getString("condition"));
	            product.setFile(rs.getString("file"));
	            product.setQuantity(rs.getInt("quantity"));
	            
	            productList.add(product); // 리스트에 상품 추가
	        }
	    } catch (SQLException e) {
	        System.err.println("상품 목록 검색 중 오류 발생!");
	        e.printStackTrace();
	    }

	    return productList; // 검색된 상품 리스트 반환
	}
	
	/**
	 * 상품 조회
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
		Product product = null;
		String sql = "SELECT * FROM product WHERE product_id = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			
			rs = psmt.executeQuery(); // 쿼리 실행
	        if (rs.next()) {
	            product = new Product(); // 상품 객체 생성
	            product.setProductId(rs.getString("product_id"));
	            product.setName(rs.getString("name"));
	            product.setUnitPrice(rs.getInt("unit_price"));
	            product.setDescription(rs.getString("description"));
	            product.setManufacturer(rs.getString("manufacturer"));
	            product.setCategory(rs.getString("category"));
	            product.setUnitsInStock(rs.getInt("units_in_stock"));
	            product.setCondition(rs.getString("condition"));
	            product.setFile(rs.getString("file"));
	            product.setQuantity(rs.getInt("quantity"));
	        }
		} catch (Exception e) {
			System.out.println("상품 id로 상품조회 시 오류!");
			e.printStackTrace();
		}
		
		
		return product;
	}
	
	
	/**
	 * 상품 등록
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;
		String sql = "INSERT INTO product (product_id, name, unit_price, description, manufacturer, category, units_in_stock, `condition`, file, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			psmt = con.prepareStatement(sql);

			// 각 필드에 값 설정
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			psmt.setInt(10, product.getQuantity());

			result = psmt.executeUpdate(); // 삽입된 행의 개수를 반환
		} catch (SQLException e) {
			System.err.println("상품 등록 중 오류 발생!");
			e.printStackTrace();
		}
		return result;
	}
	
	
	/**
	 * 상품 수정
	 * @param product
	 * @return
	 */
	public int update(Product product) {
	    int result = 0;
	    String sql = "UPDATE product SET name = ?, unit_price = ?, description = ?, manufacturer = ?, category = ?, units_in_stock = ?, `condition` = ?, file = ?, quantity = ? WHERE product_id = ?";

	    try {
	    	psmt = con.prepareStatement(sql);
	        
	        // 각 필드에 값 설정
	        psmt.setString(1, product.getName());
	        psmt.setInt(2, product.getUnitPrice());
	        psmt.setString(3, product.getDescription());
	        psmt.setString(4, product.getManufacturer());
	        psmt.setString(5, product.getCategory());
	        psmt.setLong(6, product.getUnitsInStock());
	        psmt.setString(7, product.getCondition());
	        psmt.setString(8, product.getFile());
	        psmt.setInt(9, product.getQuantity());
	        psmt.setString(10, product.getProductId()); // WHERE 절에 사용할 ID 설정

	        result = psmt.executeUpdate(); // 수정된 행의 개수를 반환
	    } catch (SQLException e) {
	        System.err.println("상품 수정 중 오류 발생!");
	        e.printStackTrace();
	    }

	    return result; // 수정된 행의 개수 반환
	}
	
	
	
	/**
	 * 상품 삭제
	 * @param product
	 * @return
	 */
	public int delete(String productId) {
		int result = 0;
		String sql = "DELETE FROM product WHERE product_id = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			
			psmt.setString(1, productId);
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("상품 삭제 중 오류발생!");
			e.printStackTrace();
		}
		
		return result;
	}

}





























