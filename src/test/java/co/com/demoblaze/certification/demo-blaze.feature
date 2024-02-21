Feature:  Demoblaze Login y SignUp

  Background:
    * url baseUrl
    * def templatePostSignUp = read('classpath:co/com/demoblaze/certification/utils/post_request.json')
    * def responsejson = read('classpath:co/com/demoblaze/certification/utils/post_response.json')
    * def rnd = Math.floor(Math.random() * (max - min + 1) + min)

  Scenario Outline: Crear Empleado
    Given path '/signup'
    And header Content-Type = 'application/json'
    * set templatePostSignUp.username = <name> + rnd
    * set templatePostSignUp.password = rnd
    And request templatePostSignUp
    When method Post
    Then status 200
    And match response != <respuestaEsperado>
    Examples:
      | name              | respuestaEsperado              |
      | responsejson.name | responsejson.respuestaEsperado |

  Scenario Outline: Login usuario
    Given path '/login'
    * def username = <username>
    * def password = <password>
    * set templatePostSignUp.username = username
    * set templatePostSignUp.password = password
    And header Content-Type = 'application/json'
    And request templatePostSignUp
    And karate.log('Request Payload:', templatePostSignUp)
    When method post
    Then status 200
    And match response contains "Auth_token"
    Examples:
      | username                 | password             |
      | responsejson.usernameEnv | responsejson.passEnv |

  Scenario Outline: Contraseña incorrecta
    * set templatePostSignUp.username = <name>
    Given path '/login'
    And header Content-Type = 'application/json'
    And request templatePostSignUp
    When method post
    Then status 200
    And match response == <message>
    Examples:
      | name                     | message                      |
      | responsejson.usernameEnv | responsejson.messageWrong[0] |

  Scenario Outline: Duplicar Empleado
    * set templatePostSignUp.username = <name>
    Given path '/signup'
    And header Content-Type = 'application/json'
    And request templatePostSignUp
    When method Post
    Then status 200
    And match response == <message>
    Examples:
      | name                     | message                      |
      | responsejson.usernameEnv | responsejson.messageWrong[1] |