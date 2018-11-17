Feature: Allows an user to manager your LDL Cholesterol data
  In order to manage my LDL data
  As an registered user
  I should be able to create, edit, remove and view my LDL data

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to LDL register page
    Given I am on My profile page
    When I click on "LDL"
    Then I should be redirected to the LDL page

  Scenario: A registered user want to view the new LDL page
    Given I am on LDL page
    When I click on "Add LDL"
    Then The Add LDL page should be displayed

  Scenario: A registered user want to add a new LDL
    Given I am on Add LDL page
    When I fill the new LDL data
    And I click on "Save LDL" button
    Then I should be redirected to the LDL page
    And A "success" message saying "LDL Cholesterol registered sucessfully" should be exibited
