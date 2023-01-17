package ru.job4j.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class PersonDTO {
    private String login;
    private String password;
}
