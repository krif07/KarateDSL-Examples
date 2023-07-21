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
        And match response.tags contains any ['qui', 'eteno', 'otro']
        And match response.tags !contains any ['qui', 'e']
        And match response.tags contains only ["implementations","welcome","introduction","codebaseShow","ipsum","qui","et","cupiditate","quia","deserunt"]
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
        Given params {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 205
        And match response.articlesCount != 200
        And match response == {"articles":"#array", "articlesCount": 205}
        And match response.articles[0].createdAt contains '2023'
        And match response.articles[*].favoritesCount contains 1409
        And match response.articles[*].author.bio contains null
        And match response..bio contains null
        And match each response..following == '#boolean'
        And match each response..following == false
        And match each response..favoritesCount == '#number'
        And match each response..bio == '##string' //string or null

    Scenario: Get all tags and validate the schema 
        Given path 'tags'
        When method Get
        Then match response == 
        """
            {
                "tags": '#[]'
            }
        """

    Scenario: More realistic validation
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        Given path 'articles'
        When method Get
        Then status 200
        And match response == {"articles":"#[10]", "articlesCount": 205}
        And match each response.articles == 
        """
            {
            "slug": '#string',
            "title": '#string',
            "description": '#string',
            "body": '#string',,
            "tagList": '#array',
            "createdAt": '#? timeValidator(_)',,
            "updatedAt": '#? timeValidator(_)',,
            "favorited": '#boolean',
            "favoritesCount": '#number',
            "author": {
                "username": '#string',,
                "bio": '##string',,
                "image": '#string',
                "following": '#boolean'
            }
        }
        """

