*** Settings ***
Library           RequestsLibrary
Library           String
Library           Collections

*** Variables ***
${BASE_URL}       https://reqres.in/api
${USER_ID}        1
${CREATE_USER_ID} None

*** Test Cases ***
Test GET All Users
    [Documentation]    Verify that we can get all users
    GET All Users
    Should Be Equal As Numbers    ${response.status_code}    200

Test GET User Info
    [Documentation]    Verify that we can get information for a specific user
    GET User Info    ${USER_ID}
    Should Be Equal As Numbers    ${response.status_code}    200

Test POST Create User
    [Documentation]    Verify that we can create a new user
    POST Create User    Yourname    Your Position
    Should Be Equal As Numbers    ${response.status_code}    201
    Set Suite Variable    ${CREATE_USER_ID}    ${response.json()['id']}

Test PATCH Update User
    [Documentation]    Verify that we can update an existing user
    [Setup]    POST Create User    Yourname    Your Position
    PATCH Update User    ${CREATE_USER_ID}    YourNickname    Your Position
    Should Be Equal As Numbers    ${response.status_code}    200

Test DELETE User
    [Documentation]    Verify that we can delete an existing user
    [Setup]    POST Create User    Yourname    Your Position
    DELETE User    ${CREATE_USER_ID}
    Should Be Equal As Numbers    ${response.status_code}    204

*** Keywords ***
GET All Users
    [Documentation]    Send a GET request to retrieve all users
    ${response}=    Get Request    ${BASE_URL}/users
    [Return]    ${response}

GET User Info
    [Arguments]    ${user_id}
    [Documentation]    Send a GET request to retrieve user info by ID
    ${response}=    Get Request    ${BASE_URL}/users/${user_id}
    [Return]    ${response}

POST Create User
    [Arguments]    ${name}    ${job}
    [Documentation]    Send a POST request to create a new user
    ${data}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    Post Request    ${BASE_URL}/users    json=${data}
    [Return]    ${response}

PATCH Update User
    [Arguments]    ${user_id}    ${name}    ${job}
    [Documentation]    Send a PATCH request to update an existing user
    ${data}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    Patch Request    ${BASE_URL}/users/${user_id}    json=${data}
    [Return]    ${response}

DELETE User
    [Arguments]    ${user_id}
    [Documentation]    Send a DELETE request to remove an existing user
    ${response}=    Delete Request    ${BASE_URL}/users/${user_id}
    [Return]    ${response}
