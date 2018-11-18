Feature: Allows an user to manager your weight data
  In order to manage my weight data
  As an registered user
  I should be able to create, edit, remove and view my weight data

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to weight registerpage
    Given I am on My profile page
    When I click on "Weights"
    Then I should be redirected to the weights page

  Scenario: A registered user want to view the new weight page
    Given I am on weights page
    When I click on "Add Weight"
    Then The Add weight page should be displayed

  Scenario: A registered user want to add a new weight
    Given I am on Add weight page
    When I fill the new weight data
    And I click on "Save Weight" button
    Then I should be redirected to the weights page
    And A "success" message saying "Weight registered sucessfully" should be exibited

# Scenario: A registered user want to update an existing weight
#     Given I am on weights page
#     And I have a weight registered
#     And I click in "edit" of that weight
#     Then I should be redirected to the edit page of that weight

#     Given I am on the edit page of an existing weight
#     When I replace the data
#     And I click on "Save Weight" button
#     Then I should be redirected to the weights page
#     And A "success" message saying "Weight registered sucessfully" should be exibited