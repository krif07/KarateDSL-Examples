
Feature: Articles
    
    Background: Define URL - Login to the api and get the token
        * url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
        * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body
        #* def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
        #* def token = tokenResponse.authToken

    Scenario: Create an article
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        And match response.article.title == articleRequestBody.article.title
        And match response.article.body == articleRequestBody.article.body
        And match response.article.description == articleRequestBody.article.description
        And match response.article.author.username == 'krif07'

    Scenario: Create and delete an article
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        And match response.article.title == articleRequestBody.article.title
        * def articleId = response.article.slug
        
        Given params {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title

        And path 'articles', articleId
        When method Delete
        Then status 204

        Given params {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title
        