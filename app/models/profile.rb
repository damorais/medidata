class Profile < ApplicationRecord
  has_many :weights
  has_many :heights

  validates :email, uniqueness: { case_sensitive: false,
                                  message: "Já existe um perfil com este e-mail" },
                    presence: { message: "O e-mail é obrigatório" }
                    
  
  validates :firstname, presence: { message: "O nome é obrigatório" }
  validates :lastname, presence: { message: "O sobrenome é obrigatório" }
  validates :birthdate, presence: { message: "A data de nascimento é obrigatória" }

  def latest_weight 
    self.weights.order(:date).reverse_order().take
  end

  def latest_height 
    self.heights.order(:date).reverse_order().take
  end

end
