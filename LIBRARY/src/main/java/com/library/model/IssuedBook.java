package com.library.model;

import java.sql.Date;

public class IssuedBook {
    private String title;
    private String author;
    private String isbn;
    private Date issueDate;
    private Date dueDate;
    private int transactionId;

    public IssuedBook(String title, String author, String isbn, Date issueDate, Date dueDate, int transactionId) {
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.issueDate = issueDate;
        this.dueDate = dueDate;
        this.transactionId = transactionId;
    }

    // --- Getter methods ---
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public String getIsbn() { return isbn; }
    public Date getIssueDate() { return issueDate; }
    public Date getDueDate() { return dueDate; }
    public int getTransactionId() { return transactionId; }
}