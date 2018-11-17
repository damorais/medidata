Feature: Allows an user to manager your reactions
  In order to manage my adverse reactions
  As an registered user
  I should be able to create, edit, remove and view my adverse reactions

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to reactions page
    Given I am on My profile page
    When I click on "Reactions"
    Then I should be redirected to the reactions page

  Scenario: A registered user want to view the new adverse reaction page
    Given I am on reactions page
    When I click on "Add Adverse Reaction"
    Then The Add Adverse Reaction page should be displayed

  Scenario: A registered user want to add a new adverse reaction
    Given I am on Add Adverse Reaction page
    When I fill the new reaction data
    And I click on "Save Adverse Reaction" button
    Then I should be redirected to the reactions page
    And A "success" message saying "Adverse Reaction registered sucessfully" should be exibited