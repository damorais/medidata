Feature: Allows an user to manager your Total Cholesterol data
  In order to manage my Total data
  As an registered user
  I should be able to create, edit, remove and view my Total data

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to Total register page
    Given I am on My profile page
    When I click on "Total Cholesterol"
    Then I should be redirected to the Total page

  Scenario: A registered user want to view the new Total page
    Given I am on Total page
    When I click on "Add Total Cholesterol"
    Then The Add Total page should be displayed

  Scenario: A registered user want to add a new Total
    Given I am on Add Total page
    When I fill the new Total data
    And I click on "Save Total" button
    Then I should be redirected to the Total page
    And A "success" message saying "Total Cholesterol registered sucessfully" should be exibited
