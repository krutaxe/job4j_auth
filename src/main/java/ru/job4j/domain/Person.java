package ru.job4j.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Data
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @NotBlank(message = "Login must be not empty")
    @Size(min = 3, max = 15, message = "Login should be between 3 and 15 characters")
    private String login;

    @NotBlank(message = "Password must be not empty")
    @Size(min = 6, message = "must be more than 6 characters")
    private String password;
}
