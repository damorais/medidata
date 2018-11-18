Feature: Allows an user to manager your VLDL Cholesterol data
  In order to manage my VLDL data
  As an registered user
  I should be able to create, edit, remove and view my VLDL data

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to VLDL register page
    Given I am on My profile page
    When I click on "VLDL Cholesterol"
    Then I should be redirected to the VLDL page

  Scenario: A registered user want to view the new VLDL page
    Given I am on VLDL page
    When I click on "Add VLDL Cholesterol"
    Then The Add VLDL page should be displayed

  Scenario: A registered user want to add a new VLDL
    Given I am on Add VLDL page
    When I fill the new VLDL data
    And I click on "Save VLDL" button
    Then I should be redirected to the VLDL page
    And A "success" message saying "VLDL Cholesterol registered sucessfully" should be exibited
