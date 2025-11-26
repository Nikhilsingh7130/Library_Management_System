package com.library.model; // Apne package name se replace karein

public class Member {
    private String studentId;
    private String name;
    private String email;
    private String phone;
    // Password aur issued_books count ko optional rakhenge, taaki security breach na ho

    // Constructor
    public Member(String studentId, String name, String email, String phone) {
        this.studentId = studentId;
        this.name = name;
        this.email = email;
        this.phone = phone;
    }

    // --- Getter methods ---
    public String getStudentId() { return studentId; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
}