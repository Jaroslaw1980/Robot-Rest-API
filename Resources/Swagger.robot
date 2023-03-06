*** Settings ***
Library     JSONLibrary
Library    Collections

*** Variables ***


*** Keywords ***
Json Payload
    [Arguments]    ${jsonpath}
    ${json}      Load Json From File    ${jsonpath}
    [Return]    ${json}

Create endpoint with ID
    [Arguments]     ${endpoint}     ${ID}
    ${endpoint string}       Convert To String        ${endpoint}
    ${get with id endpoint}   Catenate   SEPARATOR=    ${endpoint string}      ${ID}
    [Return]       ${get with id endpoint}

Payload ID
    [Arguments]    ${ID}
    ${Payload ID}   Catenate    SEPARATOR=      /       ${ID}
    [Return]    ${Payload ID}

Create Header
    [Arguments]    ${header string}
    ${header}  Convert To Dictionary    ${header string}
    [Return]    ${header}



