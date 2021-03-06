package product.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class ProductDAO implements InterProductDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semioracle");		// import javax.sql.DataSource;
			
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
    private void close() {
	  	try {
	  		if(rs != null)    {rs.close();    rs=null;}
		    if(pstmt != null) {pstmt.close(); pstmt=null;}
		    if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
		    e.printStackTrace();
		}
    }

    // 메인페이지에 보여줄 신제품 4종을 select 해주는 메소드
	@Override
	public List<ProductVO> newProduct() throws SQLException {
		List<ProductVO> newproductList = new ArrayList<>();
		try {
			
			conn = ds.getConnection();
			
			String sql = " select pnum,fk_cnum,pname,price,color, pinupdate ,pqty,psummary,pcontent,cname, prodimage " + 
						 " from " + 
						 "     ( " + 
						 "     select pnum,fk_cnum,pname,price,color,to_char(pinpupdate,'yyyy-mm-dd') as pinupdate ,pqty,psummary,pcontent, prodimage " + 
						 "     from " + 
						 "     ( " + 
						 "         select pnum,fk_cnum,pname,price,color,pinpupdate,pqty,psummary,pcontent,ROW_NUMBER() over(order by pinpupdate desc) as new, prodimage " + 
						 "         from " + 
						 "         ( " + 
						 "             select pnum,fk_cnum,pname,price,color,pinpupdate,pqty,psummary,pcontent,ROW_NUMBER() over(partition by fk_cnum,pname order by pinpupdate) as updatedate, prodimage " + 
						 "             from tbl_product " + 
						 "         ) " + 
						 "         where updatedate = 1 " + 
						 "     ) " + 
						 "     where new < 5 " + 
						 " )P join tbl_category C " + 
						 " on P.fk_cnum = c.cnum ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				
				ProductVO pvo = new ProductVO();
				
				pvo.setPnum(rs.getString(1));
				pvo.setFk_cnum(rs.getString(2));
				pvo.setPname(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				pvo.setColor(rs.getString(5));
				pvo.setPinpupdate(rs.getString(6));
				pvo.setPqty(rs.getInt(7));
				pvo.setPsummary(rs.getString(8));
				pvo.setPcontent(rs.getString(9));
				pvo.setCname(rs.getString(10));
				pvo.setProdimage(rs.getNString(11));
				
				newproductList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return newproductList;
	}// end of public List<ProductVO> newProduct()-----------------------------

	// 모든 제품에서 보여줄 카테고리와 해당 카테고리 의자 이미지 1개 얻어오는 메소드
	@Override
	public List<Map<String, String>> selectCategoryImage() throws SQLException {
		
		List<Map<String, String>> categoryList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select cnum, cname, prodimage " + 
						 " from " + 
						 " ( " + 
						 " select cnum, cname, prodimage, ROW_NUMBER() over(partition by cname order by prodimage) as images " + 
						 " from tbl_category C join tbl_product P " + 
						 " on c.cnum = p.fk_cnum " + 
						 " ) " + 
						 " where images = 1 ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				
				Map<String,String> paraMap= new HashMap<>();
				paraMap.put("cnum", rs.getString(1));
				paraMap.put("cname", rs.getString(2));
				paraMap.put("prodimage", rs.getString(3));
				
				categoryList.add(paraMap);
				
			}
			
		} finally {
			close();
		}
		
		return categoryList;
	}
    // end of public List<Map<String, String>> selectCategoryImage()----------------------


	// Ajax(JSON)를 사용하여 상품목록을 "더보기" 방식으로 페이징처리 해주기 위해  제품의 전체개수 알아오기 // 
	@Override
	public int totalCount() throws SQLException {
		int totalCount = 0;
        
        try {
            conn = ds.getConnection();
            
            String sql = " select count(*) "+
                         " from tbl_product ";
            
            pstmt = conn.prepareStatement(sql);
            
            rs = pstmt.executeQuery();
            
            rs.next();
            
            totalCount = rs.getInt(1);
            
        } finally {
           close();
        }      
        
        return totalCount;
	} // end of public int totalCount()-------------------
	
	// Ajax(JSON)를 이용한 더보기 방식(페이징처리)으로 상품정보를 잘라서(start ~ end) 조회해오기 
	@Override
	public List<ProductVO> selectAllproduct(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> prodList = new ArrayList<>();
	       
        try {
           conn = ds.getConnection();
           
           String sql = " select pnum, pname, color, price, pqty, prodimage, cnum, cname , pinpupdate " + 
		           		" from " + 
		           		" ( " + 
		           		"     select row_number() over(order by " + paraMap.get("range")+") as RNO, pnum, pname, color, price, pqty, prodimage, c.cnum, c.cname , to_char(pinpupdate, 'yyyy-mm-dd') as pinpupdate " + 
		           		"     from tbl_product P " + 
		           		"     JOIN tbl_category C " + 
		           		"     ON p.fk_cnum = c.cnum "; 
		           		if(paraMap.get("cnum") != null) {
		           			sql += " where cnum = ? ";
		           		}
		          sql += " ) " + 
		           		" where RNO between ? and ? ";
           
           pstmt = conn.prepareStatement(sql);
           if(paraMap.get("cnum") != null) {
        	   pstmt.setString(1, paraMap.get("cnum"));
        	   pstmt.setString(2, paraMap.get("start"));
               pstmt.setString(3, paraMap.get("end"));
           }
           else {
        	   pstmt.setString(1, paraMap.get("start"));
        	   pstmt.setString(2, paraMap.get("end"));
           }
           
           rs = pstmt.executeQuery();
           
           while(rs.next()) {
              
              ProductVO pvo = new ProductVO();
              
              pvo.setPnum(rs.getString(1));     // 제품번호
              pvo.setPname(rs.getString(2));    // 제품명
              pvo.setColor(rs.getString(3));	// 색
              pvo.setPrice(rs.getInt(4));        // 제품 가격
              pvo.setPqty(rs.getInt(5));         // 제품 재고량
              pvo.setProdimage(rs.getString(6)); // 제품 이미지
              
              CategoryVOwhc categvo = new CategoryVOwhc();
              categvo.setCnum(rs.getString(7));
              categvo.setCname(rs.getString(8));
              pvo.setCategvo(categvo);
              
              pvo.setPinpupdate(rs.getString(9)); // 입고일
              
              
               
              prodList.add(pvo);
           }// end of while(rs.next())-----------------------------------
           
        } finally {
           close();
        }
        
        return prodList;
	}
    // end of public List<ProductVO> selectAllproduct(Map<String, String> paraMap)

	// 위시리스트에 있는 pnum 을 통해 제품 select 하기
	@Override
	public List<ProductVO> selectProductbyPnum(String localWishList) throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		 try {
	           conn = ds.getConnection();
	           
	           String sql = " select pnum, pname, color, price, pqty, prodimage, c.cnum, c.cname , to_char(pinpupdate, 'yyyy-mm-dd') as pinpupdate " + 
			           		" from tbl_product P " + 
			           		" JOIN tbl_category C " + 
			           		" ON p.fk_cnum = c.cnum ";
	           
			           	sql += " where pnum in ("+localWishList+") ";
	       //    System.out.println(pnums);
	           pstmt = conn.prepareStatement(sql);
	           
	           rs = pstmt.executeQuery();
	           
	           while(rs.next()) {
	              
	              ProductVO pvo = new ProductVO();
	              
	              pvo.setPnum(rs.getString(1));     // 제품번호
	              pvo.setPname(rs.getString(2));    // 제품명
	              pvo.setColor(rs.getString(3));	// 색
	              pvo.setPrice(rs.getInt(4));        // 제품 가격
	              pvo.setPqty(rs.getInt(5));         // 제품 재고량
	              pvo.setProdimage(rs.getString(6)); // 제품 이미지
	              
	              CategoryVOwhc categvo = new CategoryVOwhc();
	              categvo.setCnum(rs.getString(7));
	              categvo.setCname(rs.getString(8));
	              pvo.setCategvo(categvo);
	              
	              pvo.setPinpupdate(rs.getString(9)); // 입고일
	               
	              productList.add(pvo);
	           }// end of while(rs.next())-----------------------------------
	           
	        } finally {
	           close();
	        }
		
		return productList;
	} // end of public List<ProductVO> selectProductbyPnum(String[] localWishListArr)-------------

	
	// 장바구니에 같은 제품일경우에는 update 신규 제품은 insert 하는 메소드
	@Override
	public int saveCart(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cartno " + 
						 " from tbl_cart " + 
						 " where fk_userid = ? and fk_pnum = ? ";
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pnum"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 이미 장바구니에 있는 제품일 경우
				sql = " update tbl_cart set oqty = oqty + ? " + 
					  " where fk_userid = ? and fk_pnum = ? "; 
				pstmt = conn.prepareStatement(sql);		
				pstmt.setString(1, paraMap.get("pqty"));
				pstmt.setString(2, paraMap.get("userid"));
				pstmt.setString(3, paraMap.get("pnum"));
				
				n = pstmt.executeUpdate();
				
			}
			else { // 장바구니에 없는 제품일 경우
				sql = " insert into tbl_cart(cartno, fk_userid, fk_pnum, oqty) values(seq_cartno.nextval, ?, ?, ?) ";
				
					pstmt = conn.prepareStatement(sql);		
					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setString(2, paraMap.get("pnum"));
					pstmt.setString(3, paraMap.get("pqty"));
					
					n = pstmt.executeUpdate();
			}
		} finally {
			close();
		}
		return n;
	} // end of public int saveCart(Map<String, String> paraMap)----------------------------------------------

	
	// 회원이 장바구니에 저장한 제품 select 하기
	@Override
	public List<ProductVO> selectCartList(String userid) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
		
		 try {
	           conn = ds.getConnection();
	           
	           String sql = " select pnum, pname, color, price, pqty, prodimage, c.cnum, c.cname , to_char(pinpupdate, 'yyyy-mm-dd') as pinpupdate, cartno, oqty " + 
		           	   	    " from tbl_product P " + 
		           	   	    " join tbl_cart S " + 
		           	   	    " on s.fk_pnum = p.pnum " + 
		           	   	    " join tbl_category C " + 
		           	   	    " on p.fk_cnum = c.cnum " + 
		           	   	    " where fk_userid = ? ";
	           pstmt = conn.prepareStatement(sql);
	           pstmt.setString(1, userid);
	           
	           rs = pstmt.executeQuery();
	           
	           while(rs.next()) {
	              
	              ProductVO pvo = new ProductVO();
	              
	              pvo.setPnum(rs.getString(1));     // 제품번호
	              pvo.setPname(rs.getString(2));    // 제품명
	              pvo.setColor(rs.getString(3));	// 색
	              pvo.setPrice(rs.getInt(4));        // 제품 가격
	              pvo.setPqty(rs.getInt(5));         // 제품 재고량
	              pvo.setProdimage(rs.getString(6)); // 제품 이미지
	              
	              CategoryVOwhc categvo = new CategoryVOwhc();
	              categvo.setCnum(rs.getString(7));
	              categvo.setCname(rs.getString(8));
	              pvo.setCategvo(categvo);
	              
	              pvo.setPinpupdate(rs.getString(9)); // 입고일
	              
	              CartVO cartvo = new CartVO();
	              cartvo.setCartno(rs.getString(10));
	              cartvo.setOqty(rs.getInt(11));
	              pvo.setCartvo(cartvo);
	              
	              productList.add(pvo);
	           }// end of while(rs.next())-----------------------------------
	           
	        } finally {
	           close();
	        }
		
		return productList;
	}

	
	// 장바구니 delete
	@Override
	public int deleteOneCart(String userid, String pnum) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " delete from tbl_cart where fk_userid = ? and fk_pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, userid);
			pstmt.setString(2, pnum);
			
			result = pstmt.executeUpdate();
			
		} finally {
	           close();
        }
		return result;
	}

	// 카테고리에 해당하는 제품수 얻어오기
	@Override
	public int totalCount(String cnum) throws SQLException {
		int totalCount = 0;
        
        try {
            conn = ds.getConnection();
            
            String sql = " select count(*) "+
                         " from tbl_product " +
                         " where fk_cnum = ? ";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cnum);
            rs = pstmt.executeQuery();
            
            rs.next();
            
            totalCount = rs.getInt(1);
            
        } finally {
           close();
        }      
        
        return totalCount;
	}// end of public int totalCount(String cnum)

	
	// 카테고리번호에 해당하는 카테고리 이름 얻어오기
	@Override
	public String selectCname(String cnum) throws SQLException {
		String cname = "";
		
		try {
            conn = ds.getConnection();
            
            String sql = " select cname " + 
	            		 " from tbl_category " + 
	            		 " where cnum = ? ";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cnum);
            rs = pstmt.executeQuery();
            
            rs.next();
            
            cname = rs.getString(1);
            
        } finally {
           close();
        }      
		return cname;
	}// end of public String selectCname(String cnum)--------------

	
	// 장바구니 수정
	@Override
	public int editCart(String cartno, String oqty) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " update tbl_cart set oqty = ? " + 
					     " where cartno = ? "; 
			
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, oqty);
			pstmt.setString(2, cartno);
			
			result = pstmt.executeUpdate();
			
		} finally {
	           close();
        }
		return result;
		
	}// end of public void editCart(String cartno, String oqty)------------------

	
	// 메인페이지에 보여줄 인기제품 4종을 판매량순으로 select 해주는 메소드
	@Override
	public List<ProductVO> hotProduct() throws SQLException {
		List<ProductVO> hotProductList = new ArrayList<>();
		try {
			
			conn = ds.getConnection();
			
			String sql = " select pnum,fk_cnum,pname,price,color, pinupdate ,pqty,psummary,pcontent,cname, prodimage " + 
						 " from " + 
						 " ( " + 
						 "     select pnum,fk_cnum,pname,price,color, to_char(pinpupdate,'yyyy-mm-dd') as pinupdate ,pqty,psummary,pcontent,cname, prodimage,hot " + 
						 "     from " + 
						 "     tbl_product P " + 
						 "     join " + 
						 "     ( " + 
						 "         select fk_pnum, ROW_NUMBER() over(order by sum(oqty) desc) as hot " + 
						 "         from tbl_order_detail " + 
						 "         group by fk_pnum " + 
						 "     )O " + 
						 "     on O.fk_pnum = p.pnum " + 
						 "     join tbl_category C " + 
						 "     on P.fk_cnum = c.cnum " + 
						 "     where hot < 5 " + 
						 " ) " + 
						 " order by hot ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				
				ProductVO pvo = new ProductVO();
				
				pvo.setPnum(rs.getString(1));
				pvo.setFk_cnum(rs.getString(2));
				pvo.setPname(rs.getString(3));
				pvo.setPrice(rs.getInt(4));
				pvo.setColor(rs.getString(5));
				pvo.setPinpupdate(rs.getString(6));
				pvo.setPqty(rs.getInt(7));
				pvo.setPsummary(rs.getString(8));
				pvo.setPcontent(rs.getString(9));
				pvo.setCname(rs.getString(10));
				pvo.setProdimage(rs.getNString(11));
				
				hotProductList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return hotProductList;
	} // end of public List<ProductVO> hotProduct()-------------------------------

	
	// pnum에 해당하는 추가이미지파일 모두 지우기
	@Override
	public int deleteImages(String pnum) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " delete from tbl_imagefile where fk_pnum = ? ";
			
			pstmt = conn.prepareStatement(sql);		
			pstmt.setString(1, pnum);
			
			result = pstmt.executeUpdate();
			
		} finally {
	           close();
        }
		return result;
		
	}// end of public int deleteImages(String pnum)------------------

	
	// tbl_product 테이블에 제품정보 update 하기
	@Override
	public int updateProduct(ProductVO pvo) throws SQLException {
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_product set fk_cnum = ?, pname = ?, prodimage = ?, price = ?, color =?, pqty = ?, psummary = ?, pcontent = ? " +  
	                      " where pnum = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, pvo.getFk_cnum());    
	         pstmt.setString(2, pvo.getPname());    
	         pstmt.setString(3, pvo.getProdimage());
	         pstmt.setInt(4, pvo.getPrice());   
	         pstmt.setString(5, pvo.getColor());
	         pstmt.setInt(6, pvo.getPqty()); 
	         pstmt.setString(7, pvo.getPsummary());
	         pstmt.setString(8, pvo.getPcontent());
	         pstmt.setString(9, pvo.getPnum());
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;  
	}// end of  public int updateProduct(ProductVO pvo)----------------

    
    
}
