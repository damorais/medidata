Feature: Allows an user to manager your height data
  In order to manage my height data
  As an registered user
  I should be able to create, edit, remove and view my height data

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to height register page
    Given I am on My profile page
    When I click on "Heights"
    Then I should be redirected to the heights page

  Scenario: A registered user want to view the new height page
    Given I am on heights page
    When I click on "Add Height"
    Then The Add height page should be displayed

  Scenario: A registered user want to add a new height
    Given I am on Add height page
    When I fill the new height data
    And I click on "Save Height" button
    Then I should be redirected to the heights page
    And A "success" message saying "Height registered sucessfully" should be exibited