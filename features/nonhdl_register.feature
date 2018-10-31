Feature: Allows an user to manager your Non-HDL Cholesterol data
    In order to manage my Non-HDL data
    As an registered user
    I should be able to create, edit, remove and view my Non-HDL data

    Background: 
        Given I am an registered user with "joao@example.org" email address

	Scenario: A registered user want to navigate to Non-HDL register page
		Given I am on My profile page
        When I click on "Non-HDL"
		Then I should be redirected to the Non-HDL page

    Scenario: A registered user want to view the new Non-HDL page
        Given I am on Non-HDL page
        When I click on "Add Non-HDL"
        Then The Add Non-HDL page should be displayed
    
    Scenario: A registered user want to add a new Non-HDL
        Given I am on Add Non-HDL page
        When I fill the new Non-HDL data
        And I click on "Save Non-HDL" button
        Then I should be redirected to the Non-HDL page
        And A "success" message saying "Non-HDL Cholesterol registered sucessfully" should be exibited
