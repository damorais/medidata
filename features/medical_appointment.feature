Feature: Allows an user to manager your medical appointment history
    In order to manage my medical appointment history
    As an registered user
    I should be able to create, edit, remove and view my medical appointment data

Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

    Scenario: A registered user want to navigate to medical appointment register page
		Given I am on My profile page
        When I click on "Medical Appointment"
		Then I should be redirected to the medical appointments page

    Scenario: A registered user want to view the new medical appointment page
        Given I am on medical appointments page
        When I click on "Add Medical Appointment"
        Then The Add medical appointment page should be displayed

    Scenario: A registered user want to add a new medical appointment
        Given I am on Add medical appointment page
        When I fill the new medical appointment data
        And I click on "Save Medical Appointment" button
        Then I should be redirected to the medical appointments page
        And A "success" message saying "Medical Appointment registered successfully" should be exibited
