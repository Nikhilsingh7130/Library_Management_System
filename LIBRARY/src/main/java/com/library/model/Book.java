package com.library.model;

// Apne package name se replace karein
public class Book {
    // Ye fields aapke 'books' table ke columns se match honge
    private int bookId;
    private String isbn;
    private String title;
    private String author;
    private int quantity;
    private int issuedCopies;

    // Constructor
    public Book(int bookId, String isbn, String title, String author, int quantity, int issuedCopies) {
        this.bookId = bookId;
        this.isbn = isbn;
        this.title = title;
        this.author = author;
        this.quantity = quantity;
        this.issuedCopies = issuedCopies;
    }

    // --- Getter methods ---
    public int getBookId() { return bookId; }
    public String getIsbn() { return isbn; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public int getQuantity() { return quantity; }
    public int getIssuedCopies() { return issuedCopies; }

    // Setter methods abhi zaroori nahi hain.
}