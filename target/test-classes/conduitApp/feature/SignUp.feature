Feature: Sign Up new user
    
    Background: Preconditios
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * url apiUrl


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