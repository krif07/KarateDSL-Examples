@ignore
Feature: Articles
    
    Background: Define URL - Login to the api and get the token
        * def dataGenerator = Java.type('helpers.DataGenerator')
        Given url apiUrl
        And path 'users/login'
        And request {"user": {"email": "krif07@gmail.com", "password": "backtira1"}}
        When method Post
        Then status 200
        * def token = response.user.token

    Scenario: Create an article
        * def randomTitle = dataGenerator.getRandomText()
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"tagList": [],"title": #(randomTitle), "description": "About krif07 Article 7","body": "Article 7 from krif07"}}
        When method Post
        Then status 201
        And match response.article.title == randomTitle
        And match response.article.body == 'Article 7 from krif07'
        And match response.article.description == 'About krif07 Article 7'
        And match response.article.author.username == 'krif07'
