package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.response.UserResponse;
import org.crmkosanostra.crmkosanostra.entity.Role;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.exception.exceptions.BadRequestException;
import org.crmkosanostra.crmkosanostra.exception.exceptions.ResourceNotFoundException;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

//    User
    public UserResponse findUserById(Long id) {

        User user = userRepository.findUserById(id).orElseThrow(
                () -> new ResourceNotFoundException("Пользователь с таким id не найден")
        );

        return UserResponse.mapToUserResponse(user);

    }



//    Boolean
    public boolean isUserExistsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }


//    Role
    public Role getRoleByName(String roleName) {

        if(roleName.isBlank()) {
            throw new BadRequestException("Имя роли не может быть пустым");
        }

        try {
            return Role.valueOf(roleName.trim().toUpperCase());
        } catch (IllegalArgumentException ex) {
            throw new BadRequestException("Указанная роль '" + roleName + "' не существует");
        }


    }


}
