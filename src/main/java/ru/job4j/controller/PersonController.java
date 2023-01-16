package ru.job4j.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import ru.job4j.domain.Person;
import ru.job4j.service.PersonService;
import ru.job4j.util.NoSuchException;
import ru.job4j.util.NotDeleteException;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/person")
@AllArgsConstructor
public class PersonController {
    private static final Logger LOGGER = LoggerFactory
            .getLogger(PersonController.class.getSimpleName());
    private final ObjectMapper objectMapper;
    private final PersonService personService;

    @GetMapping("/")
    public ResponseEntity<List<Person>> findAll() {
        List<Person> body = personService.findAll();
        return ResponseEntity.status(HttpStatus.OK)
                .header("CustomHeader", "Header")
                .body(body);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Person> findById(@PathVariable int id) {
        Optional<Person> person = personService.findById(id);
        if (person.isEmpty()) {
            throw new NoSuchException("There is no ID = " + id + " in DataBase");
        }
        return new ResponseEntity<>(person.get(), HttpStatus.OK);
    }

    @PostMapping("/")
    public ResponseEntity<Person> create(@RequestBody Person person) {
        return new ResponseEntity<>(
                personService.create(person),
                HttpStatus.CREATED
        );
    }

    @PutMapping("/")
    public ResponseEntity<byte[]> update(@RequestBody Person person) throws IOException {
        var content = Files.readAllBytes(Path.of("./test.jpeg"));
        if (!personService.update(person)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_JPEG)
                .contentLength(content.length)
                .body(content);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable int id) {
        Optional<Person> person = personService.findById(id);
        if (person.isEmpty()) {
            throw new NoSuchException("There is no ID = " + id + " in DataBase");
        }
        if (person.get().getLogin().equals("admin")) {
            throw new NotDeleteException("Admin login cannot be deleted!");
        }
        personService.delete(person.get());
        return ResponseEntity.ok()
                .body(person.get().getLogin() + " deleted");
    }

    @ExceptionHandler(value = {NotDeleteException.class})
    public void exceptionHandler(NotDeleteException e, HttpServletResponse response)
            throws IOException {
        response.setStatus(HttpStatus.NOT_ACCEPTABLE.value());
        response.setContentType("application/json");
        response.getWriter().write(objectMapper.writeValueAsString(new HashMap<>() { {
            put("message", e.getMessage());
            put("type", e.getClass());
        }}));
        LOGGER.error(e.getLocalizedMessage());
    }
}
