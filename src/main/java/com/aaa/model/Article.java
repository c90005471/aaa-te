package com.aaa.model;

public class Article {
	Integer id ;
	String title ;
	String keyword ;
	String myEditor ;
	String author;
	String time;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public String getMyEditor() {
		return myEditor;
	}
	public void setMyEditor(String myEditor) {
		this.myEditor = myEditor;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	@Override
	public String toString() {
		return "Article [id=" + id + ", title=" + title + ", keyword="
				+ keyword + ", myEditor=" + myEditor + ", author=" + author
				+ ", time=" + time + "]";
	}
	
	
}
