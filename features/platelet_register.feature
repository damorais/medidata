Feature: Allows an user to manager your platelet data
    In order to manage my platelet data
    As an registered user
    I should be able to create, edit, remove and view my platelet data

Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

    Scenario: A registered user want to navigate to platelet register page
		Given I am on My profile page
    When I click on "Platelets"
		Then I should be redirected to the platelets page

    Scenario: A registered user want to view the new platelet page
        Given I am on platelets page
        When I click on "Add Platelet"
        Then The Add platelets page should be displayed

    Scenario: A registered user want to add a new platelet
        Given I am on Add platelet page
        When I fill the new platelet data
        And I click on "Save platelet" button
        Then I should be redirected to the platelets page
        And A "success" message saying "Platelet registered sucessfully" should be exibited
