*** Settings ***

Library        RequestsLibrary
Library        Collections
Library        JSONLibrary
Library        String
Resource       ../Resources/Swagger.robot
Resource       ../Resources/Endpoints.robot

Test Setup    Create Session    e2e     ${Base_url}

# robot -d Results Tests/Activities_E2E.robot

*** Variables ***

&{activities header}       Content-Type=application/json; v=1.0
${activities json path}    Payloads/activity_e2e.json

*** Test Cases ***

Test E2E

    ${activity_payload}     Json Payload       ${activities json path}

    ${post_response}    POST On Session
        ...     e2e
        ...     ${activities endpoint}
        ...     json=${activity_payload}
        ...     headers=&{activities header}
    Log     ${post_response.json()}
    &{post_dict}      Convert To Dictionary        ${post_response.json()}
    ${ID}       Get From Dictionary    ${post_dict}     id
    Log    ${ID}
    Status Should Be    200

    ${payload id}       Payload ID    ${ID}
    ${get with id endpoint}     Create Endpoint With ID     ${activities endpoint}     ${payload id}
    ${get_response}     GET On Session    e2e       ${get with id endpoint}
    &{get_dict}     Convert To Dictionary    ${get_response.json()}
    ${title}    Get From Dictionary    ${get_dict}      title
    Should Be Equal As Strings    ${title}      Activity 15
    Log    ${title}
    Status Should Be    200

    ${payload id}      Payload ID    ${ID}
    ${get with id endpoint}     Create Endpoint With ID     ${activities endpoint}     ${payload id}
    ${delete_response}  DELETE On Session    e2e    ${get with id endpoint}
    Log     ${delete_response}
    Status Should Be    200




