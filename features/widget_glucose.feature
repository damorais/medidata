Feature: Allows an user to look at a glance your glucose data

Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

Scenario: I should be able to see my latest glucose register on my main profile page
    Given I have at least one Glucose registered
    And I am on My profile page
    Then I should see a Glucose widget with the most recent register

Scenario: I should see "You don't have any glucose registered"
    Given I have not added any Glucose measure
    And I am on My profile page
    Then I should see a Glucose widget the phrase "You don't have any glucose registered"
    
