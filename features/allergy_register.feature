Feature: Allows an user to manager your allergies
  In order to manage my allergies
  As an registered user
  I should be able to create, edit, remove and view my allergies

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to allergies page
    Given I am on My profile page
    When I click on "Allergies"
    Then I should be redirected to the allergies page

  Scenario: A registered user want to view the new allergy page
    Given I am on allergies page
    When I click on "Add Allergy"
    Then The Add allergy page should be displayed

  Scenario: A registered user want to add a new allergy
    Given I am on Add allergy page
    When I fill the new allergy data
    And I click on "Save Allergy" button
    Then I should be redirected to the allergies page
    And A "success" message saying "Allergy registered sucessfully" should be exibited