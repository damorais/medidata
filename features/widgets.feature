Feature: Allows an user to look at a glance some of your important health data from the profile page
  In order to check my important health data
  As an registered user
  I should be able to see in profile screen those data

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: I should be able to see my latest weight on my main profile page
    Given I have at least one Weight registered
    And I am on My profile page
    Then I should see a Weight widget with the most recent register

  Scenario: I should be warned when I don't have any weight registered
    Given I don't have any weight registered
    And I am on My profile page
    Then I should see a Weight widget warning that "You don't have any weight registered"

  Scenario: I should be able to see my latest height on my main profile page
    Given I have at least one Height registered
    And I am on My profile page
    Then I should see a Height widget with the most recent register

  Scenario: I should be warned when I don't have any height registered
    Given I don't have any height registered
    And I am on My profile page
    Then I should see a Height widget warning that "You don't have any height registered"

  Scenario: I should be able to see my BMI on my profile page
    Given I have a Weight and a Height registered
    And I am on My profile page
    Then I should see a BMI widget with my BMI

  Scenario: I should be warned when I don't have a weight data to calculate my BMI
    Given I don't have any weight registered
    And I am on My profile page
    Then I should see a BMI widget warning that "You don't have enough data to calculate your BMI"

  Scenario: I should be warned when I don't have a height data to calculate my BMI
    Given I don't have any height registered
    And I am on My profile page
    Then I should see a BMI widget warning that "You don't have enough data to calculate your BMI"