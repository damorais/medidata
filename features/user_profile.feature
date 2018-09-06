Feature: Allows an user to administrate your profile
	Scenario: As a User I should navigate to Profile page
		Given I am on the MediData home page
		When I click on "Criar um Perfil"
		Then I should be redirected to Novo Perfil page
	
	Scenario: As a new User, I can create a New Profile
		Given I am on Novo Perfil page
		When I fill "email" with "joao_silva@example.org"
		And I fill "firstname" with "João"
		And I fill "lastname" with "Silva"
		And I fill "birthdate" with "10/12/1980"
		And I select "Masculino"
		And I fill "gender" with "Masculino"
		And I click on "Criar meu perfil"
		Then A New Profile with "joao_silva@example.org" email should be created
		And A "success" message saying "O perfil foi criado com sucesso" should be exibited
