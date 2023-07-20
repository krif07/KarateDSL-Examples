Feature: Sign Up new user
    
    Background: Preconditios
        Given url apiUrl


    Scenario: New user Sign Up
        Given def userData = {"email": "mail@algo4.com", "username": "user4"}}

        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #(userData.email),
                    "password": "123456",
                    "username": #(userData.username)
                }
            }
        """
        When method Post
        Then status 201