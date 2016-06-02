package meeting.team.vo;

public class PageVO {
	int currPage;
	int startPage;
	int endPage;
	int totalPage;
	int listTotal;
	public int getListTotal() {
		return listTotal;
	}
	public void setListTotal(int listTotal) {
		this.listTotal = listTotal;
	}
	public int getCurrPage() {
		return currPage;
	}
	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	
}
