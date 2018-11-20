Feature: Allows an user to manage your health insurances
  In order to manage my heth insurances
  As an registered user
  I should be able to create, edit, remove and view my insurances

  Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

  Scenario: A registered user want to navigate to Health Insurances page
    Given I am on My profile page
    When I click on "Health Insurances"
    Then I should be redirected to the Health Insurances page

  Scenario: A registered user want to view the new Health Insurance page
    Given I am on Health Insurances page
    When I click on "Add Health Insurance"
    Then The Add Health Insurance page should be displayed

  Scenario: A registered user want to add a new Health Insurance
    Given I am on New Health Insurance page
    When I fill the new health insurance data
    And I click on "Save Health Insurance" button
    Then I should be redirected to the Health Insurances page
    And A "success" message saying "Health insurance registered sucessfully" should be exibited
