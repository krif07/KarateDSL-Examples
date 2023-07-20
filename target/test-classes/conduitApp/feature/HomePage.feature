Feature: Tests for the home page

    Background: Define URL
        Given url 'https://api.realworld.io/api/'

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200

    Scenario: Get all tags - validate Tags
        Given path 'tags'
        When method Get
        Then match response.tags contains 'codebaseShow'
        And match response.tags contains ['ipsum', 'qui', 'cupiditate']
        And match response.tags !contains 'krifo'
        And match response.tags == '#array'
        And match response.tags != '#string'
        And match each response.tags == '#string'

    Scenario: Get n articles from the page using param
        Given param limit = 3
        And param offset = 0
        And path 'articles'
        When method Get
        Then status 200

    Scenario: Get n articles from the page using params
        Given params {limit: 3, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[3]'
        And match response.articlesCount == 205
        

