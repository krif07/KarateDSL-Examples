@createArticle
Feature: Articles
    
    Background: Define URL - Login to the api and get the token
        Given url apiUrl
        And path 'users/login'
        And request {"user": {"email": "krif07@gmail.com", "password": "backtira1"}}
        When method Post
        Then status 200
        * def token = response.user.token

    @ignore
    Scenario: Create an article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"tagList": [],"title": "Krif07 Article xy1","description": "About krif07 Article 7","body": "Article 7 from krif07"}}
        When method Post
        Then status 201
        And match response.article.title == 'Krif07 Article xy1'
        And match response.article.body == 'Article 7 from krif07'
        And match response.article.description == 'About krif07 Article 7'
        And match response.article.author.username == 'krif07'
