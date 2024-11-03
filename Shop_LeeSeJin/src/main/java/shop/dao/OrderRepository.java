package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		String sql = "INSERT INTO `order` (ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			psmt = con.prepareStatement(sql);

			// 각 필드에 값 설정
			psmt.setString(1, order.getShipName()); // 받는 사람 이름
			psmt.setString(2, order.getZipCode()); // 우편번호
			psmt.setString(3, order.getCountry()); // 국가
			psmt.setString(4, order.getAddress()); // 주소
			psmt.setString(5, order.getDate()); // 배송일자
			psmt.setString(6, order.getOrderPw()); // 주문 비밀번호
			psmt.setString(7, order.getUserId()); // 회원 아이디
			psmt.setInt(8, order.getTotalPrice()); // 총가격
			psmt.setString(9, order.getPhone()); // 비회원 전화번호

			result = psmt.executeUpdate(); // 삽입된 행의 개수를 반환
		} catch (SQLException e) {
			System.err.println("주문 등록 중 오류 발생!");
			e.printStackTrace();
		}

		return result; // 삽입된 행의 개수 반환
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int result = 0;
		String sql = "SELECT MAX(order_no) AS last_order_no FROM `order`"; // 가장 큰 order_no을 선택

		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery(); // 쿼리 실행

			if (rs.next()) {
				result = rs.getInt("last_order_no"); // 결과에서 last_order_no을 가져옴
			}
			rs.close(); // ResultSet 닫기
		} catch (SQLException e) {
			System.err.println("최근 주문 번호 조회 중 오류 발생!");
			e.printStackTrace();
		}

		return result; // 최근 주문 번호 반환

	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> productList = new ArrayList<Product>();
		String sql = "SELECT o.order_no, p.name, p.unit_price, io.amount "
		           + "FROM `order` o "
		           + "JOIN product_io io ON o.order_no = io.order_no "
		           + "JOIN `product` p ON io.product_id = p.product_id "
		           + "WHERE o.user_id = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, userId);
			
			rs = psmt.executeQuery();
			
			while (rs.next()) { // 결과 집합을 반복
				Product product = new Product(); // Product 객체 생성
				product.setOrderNo(rs.getInt("order_no")); // 주문 번호 설정
	            product.setName(rs.getString("name"));          // 상품명 설정
	            product.setUnitPrice(rs.getInt("unit_price"));  // 단가 설정
	            product.setAmount(rs.getInt("amount"));   // 수량 설정
	            
				productList.add(product); // 리스트에 추가
			}
			rs.close(); // ResultSet 닫기
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("userId로 주문내역 조회 중 실패!");
		}
		
		return productList;
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * 
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		List<Product> productList = new ArrayList<Product>();
		String sql = "SELECT o.order_no, p.name, p.unit_price, io.amount "
		           + "FROM `order` o "
		           + "JOIN product_io io ON o.order_no = io.order_no "
		           + "JOIN `product` p ON io.product_id = p.product_id "
		           + "WHERE o.phone = ? AND o.order_pw = ?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, phone); // 전화번호 설정
			psmt.setString(2, orderPw); // 주문 비밀번호 설정

			rs = psmt.executeQuery(); // 쿼리 실행

			while (rs.next()) { // 결과 집합을 반복
				Product product = new Product(); // Product 객체 생성
				product.setOrderNo(rs.getInt("order_no")); // 주문 번호 설정
	            product.setName(rs.getString("name"));          // 상품명 설정
	            product.setUnitPrice(rs.getInt("unit_price"));  // 단가 설정
	            product.setAmount(rs.getInt("amount"));   // 수량 설정
	            
				productList.add(product); // 리스트에 추가
			}
			rs.close(); // ResultSet 닫기
		} catch (Exception e) {
			System.out.println("주문 내역 조회 중 실패!");
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}

		return productList; // 주문 내역 리스트 반환

	}
	
}






























