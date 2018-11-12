FactoryBot.define do
  factory :platelet do
    erythrocyte { "9.99" }
    hemoglobin { "9.99" }
    hematocrit { "9.99" }
    vcm { "9.99" }
    hcm { "9.99" }
    chcm { "9.99" }
    rdw { "9.99" }
    leukocytep { "9.99" }
    neutrophilp { "9.99" }
    eosinophilp { "9.99" }
    basophilp { "9.99" }
    lymphocytep { "9.99" }
    monocytep { "9.99" }
    leukocyteul { 1 }
    neutrophilul { 1 }
    eosinophilul { 1 }
    basophilul { 1 }
    lymphocyteul { 1 }
    monocyteul { 1 }
    total { 1 }
    profile { nil }
  end
end
