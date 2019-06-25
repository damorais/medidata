Feature: Allows an user to manager your relatives
    In order to manage my relatives
    As an registered user
    I should be able to create, edit, remove and view my relatives

	Background: 
        Given I am an registered user with "joao@example.org" email address
		And I have a registered profile with "joao@example.org" email address
	
	Scenario: A registered user want to navigate to diseases page
		Given I am on My profile page
		When I click on "Relatives Historic"
		Then I should be redirected to the relatives historic page
		
	 Scenario: A registered user want to view the new relatives historic page
        Given I am on diseases page
        When I click on "Add Relative"
        Then The Add Relative page should be displayed
		
	Scenario: A registered user want to add a new  disease
        Given I am on Add Relative page
        When I fill the Relative name and description
        And I click on "Save Relative" button
        Then I should be redirected to the Relatives Historic page
        And A "success" message saying "Relative registered sucessfully" should be exibited