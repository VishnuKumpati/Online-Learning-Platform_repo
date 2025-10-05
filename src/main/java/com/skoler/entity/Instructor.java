package com.skoler.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "instructors")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Instructor extends User {

    private String expertiseArea;   // e.g., "Data Science", "Web Development"
    private String certification;   // e.g., "AWS Certified", "Oracle Java SE"

    private Integer experienceYears;

}

