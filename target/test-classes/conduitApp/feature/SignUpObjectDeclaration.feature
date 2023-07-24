@ignore
Feature: Sign Up new user
    
    Background: Preconditios
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * url apiUrl


    Scenario: New user Sign Up
        * def randomEmail = dataGenerator.getRandomEmail()
        
        * def jsFunction = 
        """
            function () {
                var DataGenerator = Java.type('helpers.DataGenerator')
                var generator = new DataGenerator()
                return generator.getRandomUserName2()
            }
        """

        * def randomUsername2 = call jsFunction

        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password": "123456",
                    "username": #(randomUsername2)
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
                    "username": #(randomUsername2),
                    "bio": null,
                    "image": "##string",
                    "token": "#string"
                }
            }
        """