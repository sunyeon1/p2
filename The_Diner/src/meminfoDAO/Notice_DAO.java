package meminfoDAO;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import meminfoDBConn.MemInfoDBConn;
import meminfoVO.MenuVO;
import meminfoVO.Notice_VO;
import meminfoVO.ReserveVO;


//DAO 

public class Notice_DAO {

	private Connection con;			
	
	PreparedStatement pstmt=null;
	ResultSet rs=null;				
	
	
	public Notice_DAO() throws ClassNotFoundException, SQLException {
		con=new MemInfoDBConn().getConnection(); 
											  	 			
	} 
	
	public void pstmtClose() throws SQLException {
		if(pstmt != null) 
			pstmt.close();
	}
	
	public void Notice_DAO_Close()
			throws SQLException {
		if(rs != null)
			rs.close();
		if(pstmt != null)
			pstmt.close();
		if(con != null)
			con.close();
	}
	
	// 모든 게시글 리턴
	   public ArrayList<Notice_VO> getAllBoard(int start, int end) throws SQLException {
	      ArrayList<Notice_VO> tiarray = new ArrayList<Notice_VO>();
	      String sql = "SELECT * FROM (SELECT A.*, Rownum Rnum FROM (SELECT * FROM Notice_D ORDER BY 1)A)"
	            + "WHERE Rnum >= ? and Rnum <= ?";
	      pstmt=con.prepareStatement(sql);
	      pstmt.setInt(1,start);
	      pstmt.setInt(2,end);
	      rs=pstmt.executeQuery();
			while(rs.next()) {	
				Notice_VO tv = new Notice_VO(
						rs.getInt("Num_ND"),
						rs.getString("Title_ND"),
						rs.getString("id_ND"),
						rs.getDate("Date_ND"),
						rs.getInt("Click_ND"),
						rs.getString("Content_ND"),
						rs.getString("File_ND")
						);
				tiarray.add(tv);
			}
			
			//자원 반납
			//con.close();
			
			return tiarray;
		}
		
		// Insert
		public void lnsert_Notice_D(Notice_VO vo) throws SQLException {
		
			if(vo.getFile1() != null) { // 첨부파일이 있을시
				String sql="INSERT INTO Notice_D"
						+ "VALUES(Num_seq_ND.NEXTVAL,?,?,sysdate,0,?,?)";
				
				pstmt = con.prepareStatement(sql);
				//?의 값을 맵핑
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getId());
				pstmt.setString(3, vo.getContent1());
				pstmt.setString(4, vo.getFile1());
				
			} else {	// 첨부파일이 없을시
				
				String sql="INSERT INTO Notice_D(Num_ND, Title_ND, id_ND, Date_ND, Click_ND, Content_ND)"
						+ "VALUES(Num_seq_ND.NEXTVAL,?,?,sysdate,0,?)";
				
				pstmt = con.prepareStatement(sql);
				//?의 값을 맵핑
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getId());
				pstmt.setString(3, vo.getContent1());
			
			}
			//쿼리 실행
			int result = pstmt.executeUpdate();
			
			if(result == 0) {
				System.out.println("insert 실패");
				return;
			}
			//자원 반납
			//con.close();

			
		}
		
		//BoardInfo 하나의 게시글 리턴하는 메소드
		public Notice_VO getOneBoard(int num){	
			//리턴 타입 선언
			Notice_VO vo = new Notice_VO(num, null, null, null, num, null, null);

			try {
				//조회수 증가 쿼리 
				String readsql = "UPDATE Notice_D SET Click_ND = Click_ND+1 WHERE Num_ND=?";
				pstmt = con.prepareStatement(readsql);
				pstmt.setInt(1,num);
				pstmt.executeUpdate();	
				
				//쿼리준비
				String sql = "SELECT * FROM Notice_D WHERE Num_ND=?";
				//쿼리실행객체 
				//쿼리실행 객체 
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,num);
				//쿼리 실행후 결과를 리턴
				rs= pstmt.executeQuery();
				
				if(rs.next()) {
					 vo.setNum(rs.getInt(1));
					 vo.setTitle(rs.getString(2));
					 vo.setId(rs.getString(3));
					 vo.setD(rs.getDate(4));
					 vo.setCnt_ck1(rs.getInt(5));
					 vo.setContent1(rs.getString(6));
					 vo.setFile1(rs.getString(7));
				}
				
				//자원 반납
				//con.close();
				
			}catch(Exception e) {
				e.printStackTrace();
				
			}
			return vo;
		}
		
		
		//Update용 Delete시 하나의 게시글을 리턴
		public Notice_VO getOneUpdateBoard(int num){	
			//리턴 타입 선언
			Notice_VO vo = new Notice_VO(num, null, null, null, num, null, null);

			try {
				//쿼리준비
				String sql = "SELECT * FROM Notice_D WHERE Num_ND=?";
				//쿼리실행객체 
				//쿼리실행 객체 
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,num);
				//쿼리 실행후 결과를 리턴
				rs= pstmt.executeQuery();
				
				if(rs.next()) {
					 vo.setNum(rs.getInt(1));
					 vo.setTitle(rs.getString(2));
					 vo.setId(rs.getString(3));
					 vo.setD(rs.getDate(4));
					 vo.setCnt_ck1(rs.getInt(5));
					 vo.setContent1(rs.getString(6));
					 vo.setFile1(rs.getString(7));
				}
				
				//자원 반납
				//con.close();
				
			}catch(Exception e) {
				e.printStackTrace();
				
			}
			return vo;
		}
		
		//update 와 delete시 필요한 패스워드 값을 리턴해 주는 메소드
		   public String getPass(String id) {
		      //리턴할 변수 객체 선언 
		      String pass = "";
		      
		      try {      
		         //쿼리 준비 
		         String sql = "SELECT password FROM memtable WHERE id=?";
		         
		         //쿼리 실행할 객체 선언
		         pstmt = con.prepareStatement(sql);
		         pstmt.setString(1,id);
		         
		         //쿼리 실행후 결과를 리턴
		         rs= pstmt.executeQuery();
		         
		         //패스워드 값을 저장
		         if(rs.next()) {
		            pass = rs.getString(1);
		         }

		         //자원 반납
				//con.close();
						
				}catch(Exception e) {
					e.printStackTrace();
					
				}
				
				return pass;
			}
		
			//하나의 게시글을 수정하는 메소드
			public void updateBoard(Notice_VO vo){
				
				try {		
					String oldFilename = null;
					if ( rs.next() ) {
						oldFilename = rs.getString( "file1" );
					}
					
					if(vo.getFile1() != null) { // 첨부파일 있을 시
					//쿼리 준비 
					String sql = "UPDATE Notice_D SET Title_ND=? , Content_ND=? , File_ND=? WHERE Num_ND=?";
					
					//쿼리 실행할 객체 선언
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1,vo.getTitle());
					pstmt.setString(2,vo.getContent1());
					pstmt.setString(3, vo.getFile1());
					pstmt.setInt(4,vo.getNum());
					
					} else { // 첨부파일 없을 시
						String sql = "UPDATE Notice_D SET Title_ND=? , Content_ND=? WHERE Num_ND=?";
						
						//쿼리 실행할 객체 선언
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1,vo.getTitle());
						pstmt.setString(2,vo.getContent1());
						pstmt.setInt(3,vo.getNum());
					}
					//쿼리 실행후 결과를 리턴
					pstmt.executeUpdate();
					
					//자원 반납
					//con.close();
					
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
			
			//하나의 게시글을 삭제하는 매소드
			public void deleteBoard(int num) {
				
				try {		
					//쿼리 준비 
					String sql = "DELETE FROM Notice_D WHERE Num_ND=?";
					
					//쿼리 실행할 객체 선언
					pstmt = con.prepareStatement(sql);
					//?
					pstmt.setInt(1,num);
					
					//쿼리 실행
					pstmt.executeUpdate();
					
					//자원 반납
					//con.close();
						
				}catch(Exception e) {
					e.printStackTrace();
					
				}
			}
			
			public int getAllCount(){
				
				//게시글 전체수를 저장하는 변수 
				int count = 0;
				
				try {		
					//쿼리 준비 
					String sql = "SELECT count(*) FROM Notice_D";
					
					//쿼리 실행할 객체 선언
					pstmt = con.prepareStatement(sql);
					
					//쿼리 실행후 결과를 리턴 
					rs = pstmt.executeQuery();
					if(rs.next()){
						count = rs.getInt(1);
					}
					
					//자원 반납
					//con.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				return count;
			}		
	

	
}









