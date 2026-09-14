package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.entity.Family;
import org.crmkosanostra.crmkosanostra.exception.exceptions.ResourceNotFoundException;
import org.crmkosanostra.crmkosanostra.repository.FamilyRepository;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FamilyService {

    private final FamilyRepository familyRepository;

    public Family getFamilyByName(String familyName) {
        if (familyName == null || familyName.isBlank()) {
            throw new ResourceNotFoundException("Укажите имя семьи");
        }
        return familyRepository.findByNameIgnoreCase(familyName.trim()).orElseThrow(
                () -> new ResourceNotFoundException("Семьи с именем '" + familyName + "' не существует")
        );
    }

    public List<Family> getAllFamilies() {
        return familyRepository.findAll(Sort.by(Sort.Direction.ASC, "id"));
    }
}