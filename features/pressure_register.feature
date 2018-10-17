Feature: Allows an user to manager your pressure data
    In order to manage my pressure data
    As an registered user
    I should be able to create, edit, remove and view my pressure data

    Background:
        Given I am an registered user with "joao@example.org" email address
        Scenario: A registered user want to navigate to pressure register page
            Given I am on My profile page
        When I click on "Pressures"
            Then I should be redirected to the pressures page

    Scenario: A registered user want to view the new height page
        Given I am on pressures page
        When I click on "Add pressure"
        Then The Add pressure page should be displayed

    Scenario: A registered user want to add a new pressure
        Given I am on Add pressure page
        When I fill the new pressure data
        And I click on "Save Pressure" button
        Then I should be redirected to the pressures page
        And A "success" message saying "Pressure registered sucessfully" should be exibited
