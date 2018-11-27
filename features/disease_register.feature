Feature: Allows an user to manager your diseases
    In order to manage my diseases
    As an registered user
    I should be able to create, edit, remove and view my diseases

	Background: 
        Given I am an registered user with "joao@example.org" email address
	
	Scenario: A registered user want to navigate to diseases page
		Given I am on My profile page
		When I click on "Diseases"
		Then I should be redirected to the diseases page
		
	 Scenario: A registered user want to view the new  disease page
        Given I am on diseases page
        When I click on "Add Disease"
        Then The Add Disease page should be displayed
		
	Scenario: A registered user want to add a new  disease
        Given I am on Add Disease page
        When I fill the new disease data
        And I click on "Save Disease" button
        Then I should be redirected to the diseases page
        And A "success" message saying "Disease registered sucessfully" should be exibited