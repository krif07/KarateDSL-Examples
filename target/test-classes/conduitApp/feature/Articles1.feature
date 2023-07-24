Feature: Articles
    
    Background: Define URL
        * def dataGenerator = Java.type('helpers.DataGenerator')
        Given url apiUrl

    Scenario: Login to the api and get the token - and create an article
        Given path 'users/login'
        * def randomTitle = dataGenerator.getRandomText()
        And request {"user": {"email": "krif07@gmail.com", "password": "backtira1"}}
        When method Post
        Then status 200
        * def token = response.user.token

        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"tagList": [],"title": #(randomTitle), "description": "About krif07 Article x1","body": "Article x1 from krif07"}}
        When method Post
        Then status 201
        And match response.article.title == randomTitle
        And match response.article.body == 'Article x1 from krif07'
        And match response.article.description == 'About krif07 Article x1'
        And match response.article.author.username == 'krif07'
