package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.MemberDto;
import org.crmkosanostra.crmkosanostra.dto.response.FamilyHierarchyResponse;
import org.crmkosanostra.crmkosanostra.entity.Family;
import org.crmkosanostra.crmkosanostra.entity.Role;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.repository.FamilyRepository;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class HierarchyService {

    private final UserRepository userRepository;
    private final FamilyRepository familyRepository;

    @Transactional(readOnly = true)
    public FamilyHierarchyResponse getFamilyHierarchy(Long familyId) {
        Family family = familyRepository.findById(familyId)
                .orElseThrow(() -> new IllegalArgumentException("Семья с ID " + familyId + " не найдена"));

        List<User> members = userRepository.findByFamilyId(familyId);

        return FamilyHierarchyResponse.builder()
                .familyName(family.getName())
                .boss(findSingleMember(members, Role.BOSS))
                .counselor(findSingleMember(members, Role.CONSIGLIERE))
                .capos(findAllMembers(members, Role.CAPO))
                .soldiers(findAllMembers(members, Role.SOLDIER))
                .build();
    }

    private MemberDto findSingleMember(List<User> members, Role role) {
        return members.stream()
                .filter(u -> u.getRole() == role)
                .findFirst()
                .map(this::mapToDto)
                .orElse(null);
    }

    private List<MemberDto> findAllMembers(List<User> members, Role role) {
        return members.stream()
                .filter(u -> u.getRole() == role)
                .map(this::mapToDto)
                .toList();
    }

    private MemberDto mapToDto(User user) {
        return MemberDto.builder()
                .username(user.getUsername())
                .photoUrl(user.getPhotoUrl())
                .bio(user.getBio())
                .build();
    }
}