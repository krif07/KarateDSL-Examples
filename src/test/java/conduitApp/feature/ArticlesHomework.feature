Feature: Articles homework

    Background: Define url
        * url apiUrl
        * def timeValidator = read('classpath:helpers/timeValidator.js')

    Scenario: Get Favorite count for the first article
        Given path 'articles'
        And params {limit: 1, offset: 0}
        When method Get
        * def slug = response.articles[0].slug
        * def favoritesCount = 0
        Then status 200

        Given path 'articles/' + slug + '/favorite'
        When method Post
        Then status 200
        And match response.article.favoritesCount == favoritesCount + 1
        And match response.article.slug == slug

        Given path 'articles/' + slug + '/favorite'
        When method Delete
        Then status 200
        And match response.article.favoritesCount == favoritesCount
        And match response.article.slug == slug

    @ignore
    Scenario: Get krif's favorites articles
        * def username = 'krif07'
        Given path 'articles'
        And params {limit: 1, offset: 0, author: #(username)}
        When method Get
        * def slug = response.articles[0].slug
        Then status 200

        Given path 'articles/' + slug + '/favorite'
        When method Post
        Then status 200
        And match response.article.favoritesCount == 1

        Given path 'articles'
        And params {limit:10, offset:0, favorited: #(username)}
        When method Get
        Then status 200
        And match response.articles == '#array'
        And match response.articlesCount == 1
        And match each response.articles ==
        """
            {
                "slug": '#string',
                "title": '#string',
                "description": '#string',
                "body": '#string',
                "tagList": '#array',
                "createdAt": '#? timeValidator(_)',
                "updatedAt": '#? timeValidator(_)',
                "favorited": '#boolean',
                "favoritesCount": '#number',
                "author": {
                    "username": '#string',
                    "bio": '##string',
                    "image": '#string',
                    "following": '#boolean'
                }
            }
        """

    Scenario: Comment articles
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def comment = dataGenerator.getRandomText()
        Given path 'articles'
        And params {limit: 1, offset: 0}
        When method Get
        Then status 200
        * def slug = response.articles[0].slug

        Given path 'articles/' + slug + '/comments'
        When method Get
        Then status 200
        * def commentsCount = response.comments.length
        * print '------------ xxxxxxxxxx------------ commentsCount '
        * print commentsCount
        
        Given path 'articles/' + slug + '/comments'
        And request 
        """
            {
                comment: {
                    body: #(comment)
                }
            }
        """
        When method Post
        Then status 200
        And match response ==
        """
            {
                "comment": {
                    "id": '#number',
                    "createdAt": '#? timeValidator(_)',
                    "updatedAt": '#? timeValidator(_)',
                    "body": #(comment),
                    "author": {
                        "username": '#string',
                        "bio": '##string',
                        "image":'#string',
                        "following": '#boolean'
                    }
                }
            }
        """

        Given path 'articles/' + slug + '/comments'
        When method Get
        Then status 200
        * def idToDelete = response.comments[0].id
        And match parseInt(response.comments.length) == parseInt(commentsCount) + 1

        Given path 'articles/' + slug + '/comments/' + idToDelete
        When method Delete
        Then status 200

        Given path 'articles/' + slug + '/comments'
        When method Get
        Then status 200
        And match parseInt(response.comments.length) == parseInt(commentsCount)