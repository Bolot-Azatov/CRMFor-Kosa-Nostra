package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.request.RegisterRequest;
import org.crmkosanostra.crmkosanostra.dto.response.UserResponse;
import org.crmkosanostra.crmkosanostra.entity.Family;
import org.crmkosanostra.crmkosanostra.entity.Role;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.exception.exceptions.BadRequestException;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final FamilyService familyService;
    private final UserRepository userRepository;

    public UserResponse register(RegisterRequest registerRequest) {

        if(userService.isUserExistsByUsername(registerRequest.getUsername())) {
            throw new BadRequestException("Пользователь с таким username уже существует");
        }

        User userAfterMap = mapToUser(registerRequest);

        User savedUser = userRepository.save(userAfterMap);

        return mapToUserResponse(savedUser);

    }

    private User mapToUser(RegisterRequest registerRequest) {

        Family family = familyService.getFamilyByName(registerRequest.getFamilyName());

        return User.builder()
                .username(registerRequest.getUsername())
                .passwordHash(passwordEncoder.encode(registerRequest.getPassword()))
                .role(Role.SOLDIER)
                .family(family)
                .photoUrl(registerRequest.getPhotoUrl())
                .bio(registerRequest.getBio())
                .build();
    }

    private UserResponse mapToUserResponse(User user) {

        return UserResponse.builder()
                .id(user.getId())
                .username(user.getUsername())
                .role(user.getRole().name())
                .familyId(user.getFamily().getId())
                .build();
    }


}
