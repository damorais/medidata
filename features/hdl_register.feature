Feature: Allows an user to manager your HDL Cholesterol data
    In order to manage my HDL data
    As an registered user
    I should be able to create, edit, remove and view my HDL data

    Background: 
        Given I am an registered user with "joao@example.org" email address

	Scenario: A registered user want to navigate to HDL register page
		Given I am on My profile page
        When I click on "HDL"
		Then I should be redirected to the HDL page

    Scenario: A registered user want to view the new HDL page
        Given I am on HDL page
        When I click on "Add HDL"
        Then The Add HDL page should be displayed
    
    Scenario: A registered user want to add a new HDL
        Given I am on Add HDL page
        When I fill the new HDL data
        And I click on "Save HDL" button
        Then I should be redirected to the HDL page
        And A "success" message saying "HDL Cholesterol registered sucessfully" should be exibited
