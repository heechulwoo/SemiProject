package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import contact.model.AnswerVO;
import contact.model.ConsultWriteVO_sm;
import contact.model.SelfReturnVO;
import service.model.AssembleVO;
import service.model.StoreVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class AdminDAO implements InterAdminDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public AdminDAO() {
		
		try {
		
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semioracle");
		    
		    aes = new AES256(SecretMyKey.KEY); // 기본 생성자가 없고, 파라미터 생성자만 있다. 
		    
		}catch(NamingException e) {
			e.printStackTrace();
		}catch(UnsupportedEncodingException e) {
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

	   
	// 카테고리 목록 보여주기
	@Override
	public List<Map<String, String>> getCategoryList(HttpServletRequest request) throws SQLException {
	
		List<Map<String, String>> categoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cnum, cname " + 
						" from tbl_category " + 
						" order by cnum asc ";
			
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> map = new HashMap<>();
				map.put("cnum", rs.getString(1));
				map.put("cname", rs.getString(2));
				
				categoryList.add(map);
				
			}// end of while --------------------------------
			
		} finally {
			close();
			
		}
		return categoryList;
	}

	
	// 제품 번호 채번해오기
	@Override
	public int getPnumOfProduct() throws SQLException {
		
		int pnum = 0;
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select seq_pnum.nextval AS PNUM " +
	                     " from dual ";
	                  
	          pstmt = conn.prepareStatement(sql);
	          rs = pstmt.executeQuery();
	                    
	          rs.next();
	          pnum = rs.getInt(1);
	      
	      } finally {
	         close();
	      }
	      
	      return pnum;
	}

	
	// tbl_product 테이블에 제품정보 insert 하기 
	@Override
	public int productInsert(ProductVO pvo)throws SQLException {
		
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_product(pnum, fk_cnum, pname, prodimage, price, color, pinpupdate, pqty, psummary, pcontent) " +  
	                    " values(?,?,?,?,?,?,?,?,?,?)";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, pvo.getPnum());
	         pstmt.setString(2, pvo.getFk_cnum());    
	         pstmt.setString(3, pvo.getPname());    
	         pstmt.setString(4, pvo.getProdimage());
	         pstmt.setInt(5, pvo.getPrice());   
	         pstmt.setString(6, pvo.getColor());
	         pstmt.setString(7, pvo.getPinpupdate());
	         pstmt.setInt(8, pvo.getPqty()); 
	         pstmt.setString(9, pvo.getPsummary());
	         pstmt.setString(10, pvo.getPcontent());
	            
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;  
		
	}// end of public void productInsert(ProductVO pvo)------------

	
	// tbl_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기 
	@Override
	public int product_imagefile_Insert(ProductVO pvo, String attachFileName) throws SQLException {
		
		 int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_imagefile(imgfileno, fk_pnum, imgfilename) "+ 
	                    " values(seq_img.nextval, ?, ?) ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, pvo.getPnum());
	         pstmt.setString(2, attachFileName);
	         
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;       
		
	}// end of public int product_imagefile_Insert(int pnum, String attachFileName)------
	
	
	
	// tbl_imagefile 테이블에 제품의 크기 이미지 파일명 insert 해주기 
	@Override
	public int product_lastimg_Insert(ProductVO pvo, String lastimg) throws SQLException {

		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_imagefile(imgfileno, fk_pnum, imgfilename) "+ 
	                    " values(seq_img.nextval, ?, ?) ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, pvo.getPnum());
	         pstmt.setString(2, lastimg);
	         
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;       
		
		
	}// end of public void product_imagefile_Insert(ProductVO pvo, String lastimg, String attachFileName)-----------

	

		
		

	
	// 검색결과 페이지에서 스크롤 방식으로 페이징 처리 해주기 위해 검색 제품의 전체 개수 알아오기
	@Override
	public int totalProdCount(Map<String, String> paraMap)throws SQLException {
		
		int totalCount = 0;
		
		try {
			conn = ds.getConnection();
				
			String sql = " select count(*) "
						+ " from tbl_product P JOIN tbl_category C "
						+ " ON P.fk_cnum = C.cnum "
						+ " where P.pname like '%' || ? || '%' "
						+ " OR C.cname like '%' || ? || '%' ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("searchWord"));
			pstmt.setString(2, paraMap.get("searchWord"));
			
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
			totalCount = rs.getInt(1);
			}
			
		} finally {
	         close();
	     }    
	
		return totalCount;
	}

	// 검색 제품 알아오기(ajax, 스크롤)
	@Override
	public List<ProductVO> selectSearchProduct(Map<String, String> paraMap)throws SQLException {
		
		List<ProductVO> searchList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pnum, pname, color, price, pqty, prodimage, cnum, cname , pinpupdate " + 
		           		" from " + 
		           		" ( " + 
		           		"     select row_number() over(order by " + paraMap.get("range")+") as RNO, pnum, pname, color, price, pqty, prodimage, c.cnum, c.cname , to_char(pinpupdate, 'yyyy-mm-dd') as pinpupdate " + 
		           		"     from tbl_product P JOIN tbl_category C " + 
		           		"     ON P.fk_cnum = C.cnum " +
		           		"     where P.pname like '%' || ? || '%' " +
		           		" 	  OR C.cname like '%' || ? || '%'  " +
						" ) " + 
			       		" where RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("searchWord"));
			pstmt.setString(2, paraMap.get("searchWord"));
			pstmt.setString(3, paraMap.get("start"));
			pstmt.setString(4, paraMap.get("end"));
			
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
	               
	                      
	               searchList.add(pvo);
	          
	           }// end of while(rs.next())-----------------------------------
			
		} finally {
			close();
		}
		
		return searchList;
	}// end of public List<ProductVO> selectSearchProduct(Map<String, String> paraMap)----

	
	// 내 문의내역 목록 가져오기(마이페이지)
	@Override
	public List<HashMap<String, String>> selectmyask(Map<String, String> paraMap) throws SQLException {
		
		List<HashMap<String, String>> askList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select asktitle, askcontent, askdate, answertitle, answercontent, answerdate "
						+ "	from "
						+ " ( "
							+ " select rownum as rno, asktitle, askcontent, askdate, answertitle, answercontent, answerdate "
							+ " from "
							+ " ( "
							+ " select asktitle, askcontent, to_char(askdate, 'yyyy-mm-dd') as askdate, nvl(answertitle,0) as answertitle, nvl(answercontent,0) as answercontent, to_char(nvl(answerdate,sysdate), 'yyyy-mm-dd') as answerdate " 
							+ " from tbl_ask Q LEFT JOIN tbl_answer A ON Q.askno = A.fk_askno " 
							+ " where Q.fk_userid = ? "
							+ " order by askdate desc "
							+ " ) V"
						+ " ) T "
						+ " where rno between ? and ? " ;
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPage1 = Integer.parseInt(paraMap.get("currentShowPage1")); 
			int sizePerPage1 = Integer.parseInt(paraMap.get("sizePerPage1")); 
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setInt(2,  (currentShowPage1 * sizePerPage1) - (sizePerPage1 - 1)); 
			pstmt.setInt(3, (currentShowPage1 * sizePerPage1));
			
			rs = pstmt.executeQuery();

			while(rs.next()) {
				
			HashMap<String, String> askmap = new HashMap<String, String>();
			
			askmap.put("asktitle", rs.getString(1));
			askmap.put("askcontent", rs.getString(2));
			askmap.put("askdate", rs.getString(3));
			askmap.put("answertitle", rs.getString(4));
			askmap.put("answercontent", rs.getString(5));
			askmap.put("answerdate", rs.getString(6));
 				
			askList.add(askmap);

			}
			
			
		} finally {
			close();
		}

		return askList;
	}

	
	// 셀프환불신청 목록 가져오기
	@Override
	public List<SelfReturnVO> myReturnList(Map<String, String> paraMap)throws SQLException {
	
		List<SelfReturnVO> selfReturnList = new ArrayList<>();
		
		try {
			
			conn = ds.getConnection();
			
				
				String sql = " select fk_odrcode, wherebuy, returndate, status "
						+ "	from "
						+ " ( "
							+ " select rownum as rno, fk_odrcode, wherebuy, returndate, status "
							+ " from "
							+ " ( "
							+ " select fk_odrcode, wherebuy, to_char(returndate, 'yyyy-mm-dd') AS returndate, status " 
							+ " from tbl_return " 
							+ " where fk_userid = ? "
							+ " order by returndate desc "
							+ " ) V"
						+ " ) T "
						+ " where rno between ? and ? " ;
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPage2 = Integer.parseInt(paraMap.get("currentShowPage2")); 
			int sizePerPage2 = Integer.parseInt(paraMap.get("sizePerPage2")); 
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setInt(2,  (currentShowPage2 * sizePerPage2) - (sizePerPage2 - 1)); 
			pstmt.setInt(3, (currentShowPage2 * sizePerPage2));

				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					// 존재한다면
					
					SelfReturnVO rvo = new SelfReturnVO();
					
					rvo.setFk_odrcode(rs.getString(1));
					rvo.setWherebuy(rs.getString(2));
					rvo.setReturndate(rs.getString(3));
				    rvo.setStatus(rs.getInt(4));
					
					selfReturnList.add(rvo); // cvo 값을 List에 담아서 보내주기
					
					
				}// end of while------------------------------------------------	
			
		} finally {
			close();
		}
		
		
		return selfReturnList;

	}

	
	// 나의 조립신청 목록 가져오기
	@Override
	public List<AssembleVO> myAssembleList(Map<String, String> paraMap)throws SQLException {
		
		List<AssembleVO> assembleList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select assembledate, fk_odrcode, Mobile, hopedate, hopehour, postcode, address, detailaddress, extraaddress, progress "
					+ "	from "
					+ " ( "
						+ " select rownum as rno, assembledate, fk_odrcode, Mobile, hopedate, hopehour, postcode, address, detailaddress, extraaddress, progress "
						+ " from "
						+ " ( "
						+ " select assembledate, fk_odrcode, Mobile, to_char(hopedate, 'yyyy-mm-dd') as hopedate, hopehour, postcode, address, detailaddress, extraaddress, progress " 
						+ " from tbl_assemble " 
						+ " where fk_userid = ? "
						+ " order by assembledate desc "
						+ " ) V"
					+ " ) T "
					+ " where rno between ? and ? " ;
		
		pstmt = conn.prepareStatement(sql);
		
		int currentShowPage3 = Integer.parseInt(paraMap.get("currentShowPage3")); 
		int sizePerPage3 = Integer.parseInt(paraMap.get("sizePerPage3")); 
		
		pstmt.setString(1, paraMap.get("userid"));
		pstmt.setInt(2,  (currentShowPage3 * sizePerPage3) - (sizePerPage3 - 1)); 
		pstmt.setInt(3, (currentShowPage3 * sizePerPage3));
			
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			
				AssembleVO avo = new AssembleVO();
				
				avo.setAssembledate(rs.getString(1));
				avo.setFk_odrcode(rs.getString(2));
				avo.setMobile(aes.decrypt(rs.getString(3)) ); // 복호화
				avo.setHopedate(rs.getString(4));
				avo.setHopehour(rs.getString(5));
				avo.setPostcode(rs.getString(6));
				avo.setAddress(rs.getString(7));
				avo.setDetailaddress(rs.getString(8));
				avo.setExtraaddress(rs.getString(9));
				avo.setProgress(rs.getInt(10));

				assembleList.add(avo);
			}
			
		}catch(GeneralSecurityException | UnsupportedEncodingException e) { // | : 또는
			e.printStackTrace();	
		}finally {
			close();
		}
	
		return assembleList;
	}

	// 내 문의내역 총페이지 알아오기
	@Override
	public int getTotalPage1(String userid, String sizePerPage1)throws SQLException {
		
		int totalPage1 = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "+
						 " from tbl_ask " +
						 " where fk_userid = ? ";

			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, sizePerPage1);
			pstmt.setString(2, userid);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage1 = rs.getInt(1);
				
		} finally {
			close();
		}
		
		return totalPage1;
	}

	
	// 내 환불신청 총페이지 알아오기
	@Override
	public int getTotalPage2(String userid, String sizePerPage2)throws SQLException {
		
		int totalPage2  = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "+
						 " from tbl_return " +
						 " where fk_userid = ? ";

			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, sizePerPage2);
			pstmt.setString(2, userid);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage2 = rs.getInt(1);
				
		} finally {
			close();
		}
		

		return totalPage2;
	}

	
	// 내 조립신청 총페이지 알아오기
	@Override
	public int getTotalPage3(String userid, String sizePerPage3)throws SQLException {
		
		int totalPage3 = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil(count(*)/?) "+
						 " from tbl_assemble " +
						 " where fk_userid = ? ";

			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, sizePerPage3);
			pstmt.setString(2, userid);

			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage3 = rs.getInt(1);
				
		} finally {
			close();
		}

		
		return totalPage3;
	}
	
	
	// 매장테이블에 새로운 매장 정보 insert해주기
	
	@Override
	public int storeInsert(StoreVO svo)throws SQLException {
		
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_shoppingmap(storeid, storename, postcode, address, detailaddress, "
	         											+ "extraaddress, storeimg, openhour, closehour, ropenhour, rclosehour) " +  
	                    " values(seq_store.nextval,?,?,?,?,?,?,?,?,?,?)";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, svo.getStorename());    
	         pstmt.setString(2, svo.getPostcode());    
	         pstmt.setString(3, svo.getAddress());
	         pstmt.setString(4, svo.getDetailaddress());
	         pstmt.setString(5, svo.getExtraaddress());
	         pstmt.setString(6, svo.getStoreimg());
	         pstmt.setString(7, svo.getOpenhour());
	         pstmt.setString(8, svo.getClosehour());
	         pstmt.setString(9, svo.getRopenhour());
	         pstmt.setString(10, svo.getRclosehour());
	         
	         result = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return result;  
		
		
		
	}	
	
}
