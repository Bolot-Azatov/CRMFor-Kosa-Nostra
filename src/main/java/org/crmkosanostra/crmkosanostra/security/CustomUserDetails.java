package org.crmkosanostra.crmkosanostra.security;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

@Getter
public class CustomUserDetails extends User {
    private final Long familyId;
    private final Long userId;

    public CustomUserDetails(String username,
                             String password,
                             Collection<? extends GrantedAuthority> authorities,
                             Long familyId,
                             Long userId) {
        super(username, password, authorities);
        this.familyId = familyId;
        this.userId = userId;
    }
}