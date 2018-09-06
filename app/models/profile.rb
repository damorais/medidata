class Profile < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false,
                                  message: "Já existe um perfil com este e-mail" }
end
