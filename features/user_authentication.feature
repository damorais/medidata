Feature: Allows an user to create and manage his account
  In order to use Medidada
  As a new user
  I should be able to create an account and use it to access the application

  Scenario: As an User, I should be able to navigate to Sign Up page
    Given I am on the main page
    When I click on "Sign up now!"
    Then I should be redirected to the Sign Up page
  
  Scenario: As an User, I should be able to navigate to Sign Ip page
    Given I am on the main page
    When I click on "Sign in"
    Then I should be redirected to the Sign In page
  
  Scenario: As an User, I should be able to create a new account
    Given I am on the Sign Up page
    When I fill the new account form
    And I click on "Sign Up"
    Then My new account should be created
    And I should be redirected to Novo Perfil page

  Scenario: As an User, I should not be able to create a account with the same email as other user
    Given I am on the Sign Up page
    When I fill the new account form with an already registered email
    And I click on "Sign Up"
    Then An error message saying that "There are another user with the same email address" should be exibited

  Scenario: As a Registered User, I should not be able to Log In in the application
    Given I have an account with "joao@example.org" email address
    And I am on the Sign In page
    When I fill my Email and Password
    And I click on "Log in"
    Then I should be redirected to Novo Perfil page