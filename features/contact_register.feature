Feature: Allows an user to manager your emergency contacts
  In order to manage my emergency contacts
  As an registered user
  I should be able to create, edit, remove and view my emergency contacts

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to emergency contacts page
    Given I am on My profile page
    When I click on "Contacts"
    Then I should be redirected to the contacts page

  Scenario: A registered user want to view the new contact page
    Given I am on contacts page
    When I click on "Add contact"
    Then The Add contact page should be displayed

  Scenario: A registered user want to add a new contact
    Given I am on Add contact page
    When I fill the new contact data
    And I click on "Save Contact" button
    Then I should be redirected to the contacts page
    And A "success" message saying "Contact registered sucessfully" should be exibited