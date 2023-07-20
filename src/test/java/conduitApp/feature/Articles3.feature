Feature: Articles
    
    Background: Define URL - Login to the api and get the token
        Given url apiUrl
        #* def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
        #* def token = tokenResponse.authToken

    @ignore
    Scenario: Create an article
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Krif07 Article abc","description": "About krif07 Article abc","body": "Article abc from krif07"}}
        When method Post
        Then status 201
        And match response.article.title == 'Krif07 Article abc'
        And match response.article.body == 'Article abc from krif07'
        And match response.article.description == 'About krif07 Article abc'
        And match response.article.author.username == 'krif07'

    @deleteArticle    
    Scenario: Create and delete an article
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Krif07 Article Delete","description": "About krif07 Article xyz","body": "Article xyz from krif07"}}
        When method Post
        Then status 201
        And match response.article.title == 'Krif07 Article Delete'
        * def articleId = response.article.slug
        
        Given params {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Krif07 Article Delete'

        And path 'articles', articleId
        When method Delete
        Then status 204

        Given params {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Krif07 Article Delete'
        