Feature: Allows an user to manager your weight data
    In order to manage my weight data
    As an registered user
    I should be able to create, edit, remove and view my weight data

    Background: 
        Given I am an registered user with "joao@example.org" email address

	Scenario: A registered user want to navigate to weight registerpage
		Given I am on My profile page
        When I click on "Weights"
		Then I should be redirected to weights page

    Scenario: A registered user want to view the new weight page
        Given I am on "weights" page
        When I click on "Add weight"
        Then The "Add weight" page should be displayed
    
    Scenario: A registered user want to add a new weight
        Given I am on "Add weight" page
        When I fill the new weight data
        And I click on "Save Weight" button
        Then I should be redirected to "Weights" page
        And I should see "Weight registered sucessfully" message