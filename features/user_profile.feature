Feature: Allows an user to administrate your profile
	Scenario: As a User I should navigate to Profile page
		Given I am on the MediData home page
		When I click on "Criar um Perfil"
		Then I should be redirected to Novo Perfil page
