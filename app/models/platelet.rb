class Platelet < ApplicationRecord
  belongs_to :profile
  validates :erythrocyte, presence: { message: "O nome do campo erythrocyte é obrigatório" },
             numericality: {
             greater_than: 0
             }
  validates :hemoglobin, presence: { message: "O nome do campo hemoglobin é obrigatório" }
  validates :hematocrit, presence: { message: "O nome do campo hematocrit é obrigatório" }
  validates :vcm, presence: { message: "O nome do campo vcm é obrigatório" }
  validates :hcm, presence: { message: "O nome do campo hcm é obrigatório" }
  validates :chcm, presence: { message: "O nome do campo chcm é obrigatório" }
  validates :rdw, presence: { message: "O nome do campo rdw é obrigatório" }
  validates :leukocytep, presence: { message: "O nome do campo leukocytep é obrigatório" }
  validates :neutrophilp, presence: { message: "O nome do campo neutrophilp é obrigatório" }
  validates :eosinophilp, presence: { message: "O nome do campo eosinophilp é obrigatório" }
  validates :basophilp, presence: { message: "O nome do campo basophilp é obrigatório" }
  validates :lymphocytep, presence: { message: "O nome do campo lymphocytep é obrigatório" }
  validates :monocytep, presence: { message: "O nome do campo monocytep é obrigatório" }
  validates :leukocyteul, presence: { message: "O nome do campo leukocyteul é obrigatório" }
  validates :neutrophilul, presence: { message: "O nome do campo neutrophilul é obrigatório" }
  validates :eosinophilul, presence: { message: "O nome do campo eosinophilul é obrigatório" }
  validates :basophilul, presence: { message: "O nome do campo erythrocyte é obrigatório" }
  validates :lymphocyteul, presence: { message: "O nome do campo lymphocyteul é obrigatório" }
  validates :monocyteul, presence: { message: "O nome do campo monocyteul é obrigatório" }
  validates :total, presence: { message: "O nome do campo total é obrigatório" }
end
