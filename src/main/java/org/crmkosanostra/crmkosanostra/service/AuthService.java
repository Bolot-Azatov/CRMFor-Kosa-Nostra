package org.crmkosanostra.crmkosanostra.service;


import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.request.LoginRequest;
import org.crmkosanostra.crmkosanostra.dto.response.AuthResponse;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.crmkosanostra.crmkosanostra.security.JwtUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;

    public AuthResponse login(LoginRequest request) {
        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new RuntimeException("Неверное имя пользователя или пароль"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPasswordHash())) {
            throw new RuntimeException("Неверное имя пользователя или пароль");
        }

        Long familyId = user.getFamily() != null ? user.getFamily().getId() : null;
        String token = jwtUtils.generateToken(user.getUsername(), user.getRole().name(), familyId);

        return new AuthResponse(token, user.getUsername(), user.getRole().name(), familyId);
    }
}
