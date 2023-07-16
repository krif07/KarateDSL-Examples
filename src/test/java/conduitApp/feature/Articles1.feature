@creatArticle
Feature: Articles
    
    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'

    @ignore
    Scenario: Login to the api and get the token - and create an article
        Given path 'users/login'
        And request {"user": {"email": "krif07@gmail.com", "password": "backtira1"}}
        When method Post
        Then status 200
        * def token = response.user.token

        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"tagList": [],"title": "Krif07 Article x3","description": "About krif07 Article x1","body": "Article x1 from krif07"}}
        When method Post
        Then status 201
        And match response.article.title == 'Krif07 Article x3'
        And match response.article.body == 'Article x1 from krif07'
        And match response.article.description == 'About krif07 Article x1'
        And match response.article.author.username == 'krif07'
