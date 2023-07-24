Feature: Sign Up new user
    
    Background: Preconditios
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * url apiUrl

    @ignore
    Scenario: New user Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUserName()
        # Given def userData = {"email": "mail@algo4.com", "username": "user4"}}

        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password": "123456",
                    "username": #(randomUsername)
                }
            }
        """
        When method Post
        Then status 201
        And match response ==
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image": "##string",
                    "token": "#string"
                }
            }
        """
    
        Scenario Outline: Validate Sign up error messages
            * def randomEmail = dataGenerator.getRandomEmail()
            * def randomUsername = dataGenerator.getRandomUserName()
    
            Given path 'users'
            And request 
            """
                {
                    "user": {
                        "email": "<email>",
                        "password": "<password>",
                        "username": "<username>"
                    }
                }
            """
            When method Post
            Then status 422
            And match response == <errorResponse>

            Examples:
            | email          | password | username                    | errorResponse                                             |
            | #(randomEmail) | 123456   | user4                       | {"errors": {"username": ["has already been taken"]}}      |
            | mail@algo4.com | 123456   | #(randomUsername)           | {"errors": {"email": ["has already been taken"]}}         |
            |                | 123456   | user4                       | {"errors": {"email": ["can't be blank"]}}                 |
           