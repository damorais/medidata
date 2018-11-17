Feature: Allows an user to manager your glucose measure data
    In order to manage my glucose measure data
    As an registered user
    I should be able to create, edit, remove and view my glucose measure data

Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

    Scenario: A registered user want to navigate to glucose measure register page
		Given I am on My profile page
        When I click on "Glucose Measure"
		Then I should be redirected to the glucose measures page

    Scenario: A registered user want to view the new glucose measure page
        Given I am on glucose measures page
        When I click on "Add"
        Then The Add glucose measure page should be displayed

    Scenario: A registered user want to add a new glucose measure
        Given I am on Add glucose measure page
        When I fill the new glucose measure data
        And I click on "Save" button
        Then I should be redirected to the glucose measures page
        And A "success" message saying "Glucose measure registered successfully" should be exibited
