Feature: Allows an user to manager your medication data
  In order to manage my medication data
  As an registered user
  I should be able to create, edit, remove and view my medication data

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to medication register page
    Given I am on My profile page
    When I click on "Medications"
    Then I should be redirected to the medications page

  Scenario: A registered user want to view the new medication page
    Given I am on medications page
    When I click on "Add Medication"
    Then The Add medication page should be displayed

  Scenario: A registered user want to add a new medication
    Given I am on Add medication page
    When I fill the new medication data
    And I click on "Save Medication" button
    Then I should be redirected to the medications page
    And A "success" message saying "Medication registered sucessfully" should be exibited
