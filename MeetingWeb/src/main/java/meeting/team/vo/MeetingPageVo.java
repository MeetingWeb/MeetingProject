package meeting.team.vo;

public class MeetingPageVo {
	private String status;
	private int maxPage;
	private int startPage;
	private int endPage;
	private int currPage = 1;
	private String search;
	private String searchComm;

	public String getSearchComm() {
		return searchComm;
	}

	public void setSearchComm(String searchComm) {
		this.searchComm = searchComm;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
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

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

}
