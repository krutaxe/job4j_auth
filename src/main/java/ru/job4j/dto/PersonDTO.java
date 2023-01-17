package ru.job4j.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@AllArgsConstructor
@Data
public class PersonDTO {
    @NotBlank(message = "Login must be not empty")
    @Size(min = 3, max = 15, message = "Login should be between 3 and 15 characters")
    private String login;

    @NotBlank(message = "Password must be not empty")
    @Size(min = 6, message = "must be more than 6 characters")
    private String password;
}
