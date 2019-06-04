Feature: Allows an user to look at a glance your blood preassure data
    Eu, como usuário cadastrado
    Devo conseguir visualizar os meus valores de Pressão Sanguínea na minha página inicial
    De forma a conseguir acompanhar minha situação atual de saúde

Background:
    Given I am an registered user with "joao@example.org" email address
    And I have a registered profile with "joao@example.org" email address

@wip
Scenario: I should be able to see my latest blood pressure register on my main profile page
    Given I have at least one Blood Pressure registered
    And I am on My profile page
    Then I should see a Blood Pressure widget with the most recent register
