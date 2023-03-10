package ru.job4j.service;

import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.job4j.domain.Person;
import ru.job4j.repository.PersonRepository;

import java.util.List;
import java.util.Optional;

import static java.util.Collections.emptyList;

@Service
@AllArgsConstructor
public class PersonService implements UserDetailsService {
    private final PersonRepository personRepository;
    private final BCryptPasswordEncoder encoder;

    public List<Person> findAll() {
        return personRepository.findAll();
    }

    public Optional<Person> findById(int id) {
      return personRepository.findById(id);
    }

    public Person create(Person person) {
        person.setPassword(encoder.encode(person.getPassword()));
        return personRepository.save(person);
    }

    public boolean update(Person person) {
        if (!personRepository.existsById(person.getId())) {
            return false;
        }
        person.setPassword(encoder.encode(person.getPassword()));
        personRepository.save(person);
        return true;
    }

    public boolean delete(Person person) {
        if (!personRepository.existsById(person.getId())) {
            return false;
        }
        personRepository.delete(person);
        return true;
    }

    public Person findByLogin(String login) {
        Person person = personRepository.findByLogin(login);
        if (person == null) {
            throw new UsernameNotFoundException(login);
        }
        return person;
    }

    @Override
    public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
        Person person = findByLogin(login);
        return new User(person.getLogin(), person.getPassword(), emptyList());
    }
}
