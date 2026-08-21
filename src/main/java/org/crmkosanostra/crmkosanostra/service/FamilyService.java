package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.entity.Family;
import org.crmkosanostra.crmkosanostra.exception.exceptions.ResourceNotFoundException;
import org.crmkosanostra.crmkosanostra.repository.FamilyRepository;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class FamilyService {

    private final FamilyRepository familyRepository;

    public Family getFamilyByName(String familyName) {
        return familyRepository.getFamilyByName(familyName).orElseThrow(
                () -> new ResourceNotFoundException("Семьи с таким именем не существует")
        );
    }
}
