*** Settings ***
Library        RequestsLibrary
Library        Collections
Library        JSONLibrary
Library        String
Resource       ../Resources/Swagger.robot
Resource       ../Resources/Endpoints.robot

Test Setup    Create Session    activities     ${Base_url}

# robot -d Results Tests/Activities.robot

*** Variables ***

&{activities header}       Content-Type=application/json; v=1.0
${activities json path}    Payloads/activity.json
${activities ID}   5

*** Test Cases ***

Test GET
    [Tags]    get

    ${get_response}     GET On Session    activities      ${activities endpoint}
    Log  ${get_response.content}
    Status Should Be    200

Test POST
    [Tags]    post

    ${activity_payload}     Json Payload       ${activities json path}

    ${post_response}    POST On Session
        ...     activities
        ...     ${activities endpoint}
        ...     json=${activity_payload}
        ...     headers=&{activities header}
    Log  ${post_response.content}
    Status Should Be    200

Test GET with ID
    [Tags]    get with id

    ${payload id}       Payload ID    ${activities ID}
    ${get with id endpoint}     Create Endpoint With ID     ${activities endpoint}     ${payload id}

    ${get_response}     GET On Session    activities       ${get with id endpoint}
    Log    ${get_response.content}
    Status Should Be    200

Test PUT
    [Tags]    put

    ${put_load}    Create Dictionary    title=Cycling

    ${payload id}       Payload ID    ${activities ID}
    ${get with id endpoint}     Create Endpoint With ID     ${activities endpoint}     ${payload id}

    ${put_response}    PUT On Session
       ...  activities
       ...  ${get with id endpoint}
       ...  json=${put_load}
       ...  headers=&{activities header}

    Dictionary Should Contain Item   ${put_response.headers}     Content-Type       application/json; charset=utf-8; v=1.0
    Log     ${put_response.content}
    Status Should Be    200

Test Delete
    [Tags]    delete

    ${payload id}      Payload ID    ${activities ID}
    ${get with id endpoint}     Create Endpoint With ID     ${activities endpoint}     ${payload id}

    ${delete_response}  DELETE On Session    activities     ${get with id endpoint}
    Log     ${delete_response}
    Status Should Be    200





