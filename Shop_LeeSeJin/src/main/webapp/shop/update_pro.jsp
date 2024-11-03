<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 파일 업로드 디렉토리 설정
    String userHome = System.getProperty("user.home");
    String filePath = userHome + "/git/SHOP_LeeSejin/Shop_LeeSeJin/src/main/webapp/static/img";
    
    DiskFileUpload upload = new DiskFileUpload();
    upload.setSizeMax(10 * 1000 * 1000);  // 10MB - 파일 최대 크기
    upload.setSizeThreshold(4 * 1024);     // 4KB - 메모리상의 최대 크기
    upload.setRepositoryPath(filePath);    // 임시 저장 경로
    
    List<FileItem> items = upload.parseRequest(request);
    Iterator params = items.iterator();
    
    String productId = "";
    String name = "";
    int unitPrice = 0;
    String description = "";
    String manufacturer = "";
    String category = "";
    int unitsInStock = 0;
    String condition = "";
    String existingFile = "";
    
    FileItem fileItem = null;
    while (params.hasNext()) {
        FileItem item = (FileItem) params.next();
        
        // 일반 데이터
        if (item.isFormField()) {
            String itemName = item.getFieldName();
            String value = item.getString("utf-8");
            out.println(name + " : " + value + "<br>");
            
            if (itemName.equals("productId")) productId = value;
            else if (itemName.equals("name")) name = value;
            else if (itemName.equals("unitPrice")) unitPrice = Integer.parseInt(value);
            else if (itemName.equals("description")) description = value;
            else if (itemName.equals("manufacturer")) manufacturer = value;
            else if (itemName.equals("category")) category = value;
            else if (itemName.equals("unitsInStock")) unitsInStock = Integer.parseInt(value);
            else if (itemName.equals("condition")) condition = value;
            else if (itemName.equals("existingFile")) existingFile = value;
        } else {
            fileItem = item;  // 파일 데이터
        }
    }
    
    // 파일 업로드 처리
    String fileFieldName = (fileItem != null) ? fileItem.getFieldName() : "";
    String fileName = (fileItem != null) ? fileItem.getName() : "";
    
    if (fileName != null && !fileName.isEmpty()) {  // 새로운 파일이 있는지 확인
        // 경로에서 파일 이름만 추출
        fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
        
        // 기존 파일 이름만 추출하여 비교
        String existingFileName = existingFile.substring(existingFile.lastIndexOf("/") + 1);
        
        if (!fileName.equals(existingFileName)) {  // 기존 파일 이름과 다를 때만 업로드
            filePath = userHome + "/git/SHOP_LeeSejin/Shop_LeeSeJin/src/main/webapp/static/img/" + fileName;
            
            File file = new File(filePath);
            fileItem.write(file);  // 파일 업로드
        } else {
            filePath = existingFile;  // 기존 파일 경로 사용
        }
    } else {
        filePath = existingFile;  // 새로운 파일이 없으면 기존 파일 경로 사용
    }

    // Product 객체에 데이터 설정
    Product product = new Product();
    product.setProductId(productId);
    product.setName(name);
    product.setUnitPrice(unitPrice);
    product.setDescription(description);
    product.setManufacturer(manufacturer);
    product.setCategory(category);
    product.setUnitsInStock(unitsInStock);
    product.setCondition(condition);
    product.setFile(filePath);

    ProductRepository productDAO = new ProductRepository();
    int result = productDAO.update(product);
    
    if (result > 0) {
        out.println("<script>alert('제품이 성공적으로 수정되었습니다!'); location.href='products.jsp';</script>");
    } else {
        out.println("<script>alert('제품 수정에 실패했습니다.'); history.back();</script>");
    }
%>
