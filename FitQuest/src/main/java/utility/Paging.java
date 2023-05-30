package utility;

public class Paging {
	//페이징 관련 변수	
	private int totalCount = 0 ; //총 레코드 건수
	private int totalPage = 0 ; //전체 페이지 수
	private int pageNumber = 0 ; //보여줄 페이지 넘버(표현 가능한 페이지는 1부터 totalPage까지이다.)
	private int pageSize = 0 ; //한 페이지에 보여줄 건수
	private int beginRow = 0 ; //현재 페이지의 시작 행
	private int endRow = 0 ; //현재 페이지의 끝 행
	private int pageCount = 3 ; // 한 화면에 보여줄 페이지 링크 수 (페이지 갯수) [1][2][3] [다음] 이런거
	private int beginPage = 0 ; //페이징 처리 시작 페이지 번호
	private int endPage = 0 ; //페이징 처리 끝 페이지 번호
	private int offset = 0 ;
	private int limit = 0 ;
	private String url = "" ; //예시 ==>  http://localhost:8989/MyServlet/list.do
	private String pagingHtml = "";//하단의 숫자 페이지 링크
	//private String pagingStatus = ""; //상단 우측의 현재 페이지 위치 표시
	//검색을 위한 변수 추가
	private String whatColumn = "" ; //검색 모드(작성자, 글제목, 전체 검색은 all) 등등
	private String keyword = "" ; //검색할 단어 

	public int getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}


	public int getTotalPage() {
		return totalPage;
	}


	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}


	public int getPageNumber() {
		return pageNumber;
	}


	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getBeginRow() {
		return beginRow;
	}


	public void setBeginRow(int beginRow) {
		this.beginRow = beginRow;
	}


	public int getEndRow() {
		return endRow;
	}


	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}


	public int getPageCount() {
		return pageCount;
	}


	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}


	public int getBeginPage() {
		return beginPage;
	}


	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	public int getOffset() {
		return offset;
	}


	public void setOffset(int offset) {
		this.offset = offset;
	}


	public int getLimit() {
		return limit;
	}


	public void setLimit(int limit) {
		this.limit = limit;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public String getPagingHtml() {
		System.out.println("pagingHtml:"+pagingHtml);
		
		return pagingHtml;
//		pagingHtml:
//			&nbsp;<font color='red'>1</font>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=2&pageSize=2&whatColumn=null&keyword=null'>2</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>3</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=4&pageSize=2&whatColumn=null&keyword=null'>4</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=5&pageSize=2&whatColumn=null&keyword=null'>5</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=6&pageSize=2&whatColumn=null&keyword=null'>6</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=7&pageSize=2&whatColumn=null&keyword=null'>7</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=8&pageSize=2&whatColumn=null&keyword=null'>8</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=9&pageSize=2&whatColumn=null&keyword=null'>9</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=10&pageSize=2&whatColumn=null&keyword=null'>10</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=11&pageSize=2&whatColumn=null&keyword=null'>다음</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=22&pageSize=2&whatColumn=null&keyword=null'>맨 끝</a>&nbsp;

	}


	public void setPagingHtml(String pagingHtml) {
		this.pagingHtml = pagingHtml;
	}


	public String getWhatColumn() {
		return whatColumn;
	}


	public void setWhatColumn(String whatColumn) {
		this.whatColumn = whatColumn;
	}


	public String getKeyword() {
		return keyword;
	}


	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	// 생성자
	public Paging(
			String _pageNumber, 
			String _pageSize,  
			int totalCount,
			String url, 
			String whatColumn, 
			String keyword,
			String whologin) {		

		if(  _pageNumber == null || _pageNumber.equals("null") || _pageNumber.equals("")  ){
			
			System.out.println("_pageNumber:"+_pageNumber); // null
			_pageNumber = "1" ;
		}
		this.pageNumber = Integer.parseInt( _pageNumber ) ; 

		if( _pageSize == null || _pageSize.equals("null") || _pageSize.equals("") ){
			_pageSize = "3" ; // 한 페이지에 보여줄 레코드 갯수 -> 여기서 수정해도 되고 컨트롤러에서 생성자부를때 해도 ㄱㅊ
		}		
		this.pageSize = Integer.parseInt( _pageSize ) ;
		
		this.limit = pageSize ; // 한 페이지에 보여줄 레코드 갯수

		this.totalCount = totalCount ; 

		this.totalPage = (int)Math.ceil((double)this.totalCount / this.pageSize) ;
		// ceil 무조건 올림 -> 10/3 = 3.333333 -> 4가 나온다.
		
		
		/*
			pageNumber : 2
			pageSize : 3 // 변함없음
			beginRow : 4 -> 시작레코드번호인듯
			endRow : 6 -> 끝
			
			만약 1페이지 클릭하면 
			pageNumber : 1
			pageSize : 3 // 변함없음
			beginRow : 1
			endRow : 3
		*/
		this.beginRow = ( this.pageNumber - 1 )  * this.pageSize  + 1 ;
		this.endRow =  this.pageNumber * this.pageSize ;
		
		// 마지막 페이지인 3페이지에 하나의 레코드가 있다고 가정하자.
		// 그럴때 마지막 레코드를 삭제하면 다시 2페이지로 가야함 . 그거에 대한 계산
		if( this.pageNumber > this.totalPage ){
			this.pageNumber = this.totalPage ;
		}
		
		// 만약 내가 선택한 페이지가(pageNumber) : 3
		// (3-1)*3 = 6 (offset)
		// 1페이지 : 0 (offset)
		// 2페이지 : 3 (offset)
		// 즉, offset은 건너뛸 레코드수를 말한다
		// -> 1페이지를 선택하면 0이므로 건너뛸 것이 없이 1번째 레코드부터 가져온다.
		// -> 2페이지를 선택하면 건너뛸 레코드가 3이므로 3개 건너뛴 후 4번째 레코드부터 가져온다.
		// -> 3페이지를 선택하면 건너 뛸 레코드가 6이므로 6개 건너뛴 후 7번째 레코드부터 가져온다.
		this.offset = ( pageNumber - 1 ) * pageSize ; 
		// 중요!!!
		
		// 만약 전체 레코드가 5개면 2페이지에는 4와 5만 보여주면 되지만 계산상으로 나온것은 6이다.
		// 그럴때 바꾸는거
		if( this.endRow > this.totalCount ){
			this.endRow = this.totalCount  ;
		}
		
		// ( 5 - 1 ) / 3 * 3 + 1 = 1 * 3 + 1 = 4(beginPage)
		// 4 + 3 - 1 = 6(endPage)
		this.beginPage = ( this.pageNumber - 1 ) / this.pageCount * this.pageCount + 1  ;
		this.endPage = this.beginPage + this.pageCount - 1 ;
		
		System.out.println("pageNumber:"+pageNumber+"/totalPage:"+totalPage);	
		
		// 계산상 없는 페이지가 나올수있어서 그러면 바꾸라는 의미 
		if( this.endPage > this.totalPage ){
			this.endPage = this.totalPage ;
		}
		
		System.out.println("pageNumber2:"+pageNumber+"/totalPage2:"+totalPage);	
		this.url = url ; //  /ex/list.ab
		this.whatColumn = whatColumn ;
		this.keyword = keyword ;
		System.out.println("whatColumn:"+whatColumn+"/keyword:"+keyword);
		
		// url을 넘긴당. 이제 넘어가서 진자 필요한 문자열이 만들어지는거임!!!
		// 1 2 3 [다음] 이런거!
		this.pagingHtml = getPagingHtml(url) ;
	
	}
	
	private String getPagingHtml( String url ){ //페이징 문자열을 만든다.
		System.out.println("getPagingHtml url:"+url); 
		// getPagingHtml url:/ex/list.ab
		
		String result = "" ;
		String added_param = "&whatColumn=" + whatColumn + "&keyword=" + keyword ; // &whatColumn=singer&keyword=아
		
		// 시작페이지가 1이 아니면 이전으로 가는 페이지가 필요하다 따라서 해당되는 링크가 생김
		if (this.beginPage != 1) { // 앞쪽, pageSize:한 화면에 보이는 레코드 수
			result += "&nbsp;<a href='" + url  
					+ "?pageNumber=" + ( 1 ) + "&pageSize=" + this.pageSize 
					+ added_param + "'>맨 처음</a>&nbsp;" ;
			result += "&nbsp;<a href='" + url 
					+ "?pageNumber=" + (this.beginPage - 1 ) + "&pageSize=" + this.pageSize 
					+ added_param + "'>이전</a>&nbsp;" ;
		}
		
		//가운데
		// 내가 보고 이쓴 ㅍㅔ이지와 같으면 빨간색으로 나오도록 설정함!!
		for (int i = this.beginPage; i <= this.endPage ; i++) {
			if ( i == this.pageNumber ) {
				result += "&nbsp;<font color='red'>" + i + "</font>&nbsp;"	;
						
			} else {
				
//				<a href='/ex/list/ab?pageNumber=3&pageSize=3&whatColumn=null&keyword=null'>
				// 위처럼 링크설정된 문자열이 리턴이 되는것이당
				result += "&nbsp;<a href='" + url   
						+ "?pageNumber=" + i + "&pageSize=" + this.pageSize 
						+ added_param + "'>" + i + "</a>&nbsp;" ;
				
			}
		}
		
		System.out.println("result:"+result); 
		System.out.println();
		
		if ( this.endPage != this.totalPage) { // 뒤쪽
			
			result += "&nbsp;<a href='" + url  
					+ "?pageNumber=" + (this.endPage + 1 ) + "&pageSize=" + this.pageSize 
					+ added_param + "'>다음</a>&nbsp;" ;
			
			result += "&nbsp;<a href='" + url  
					+ "?pageNumber=" + (this.totalPage ) + "&pageSize=" + this.pageSize 
					+ added_param + "'>맨 끝</a>&nbsp;" ;
		}		
		System.out.println("result2:"+result);
		// result2 : <a href='/ex/list.ab?pageNumber=1&pageSize=2'>맨 처음</a>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>이전</a>&nbsp;&nbsp;<font color='red'>4</font>&nbsp;&nbsp;<a href='/ex/list.ab?pageNumber=5&pageSize=2&whatColumn=null&keyword=null'>5</a>&nbsp;
		// 즉 위에잇는게 list.jsp 맨 밑에 보여질것
		
		return result ;
	}	
	
}

