#ทดสอบยังไม่ได้
*** Settings ***
Library           RequestsLibrary
Library           String
Library           Collections

*** Variables ***
${BASE_URL}       https://reqres.in/api
${CREATE_USER_ID} None

*** Test Cases ***
Test GET All Users
    [Documentation]    Verify that we can get all users
    ${response}=    GET Request    ${BASE_URL}/users
    Should Be Equal As Numbers    ${response.status_code}    200

Test GET User Info
    [Documentation]    Verify that we can get information for a specific user
    ${response}=    GET Request    ${BASE_URL}/users/1
    Should Be Equal As Numbers    ${response.status_code}    200

Test POST Create User
    [Documentation]    Verify that we can create a new user
    ${response}=    POST Create User    Yourname    Your Position
    Should Be Equal As Numbers    ${response.status_code}    201
    Set Suite Variable    ${CREATE_USER_ID}    ${response.json()['id']}

Test PATCH Update User
    [Documentation]    Verify that we can update an existing user
    [Setup]    POST Create User    Yourname    Your Position
    ${response}=    PATCH Update User    ${CREATE_USER_ID}    YourNickname    Your Position
    Should Be Equal As Numbers    ${response.status_code}    200

Test DELETE User
    [Documentation]    Verify that we can delete an existing user
    [Setup]    POST Create User    Yourname    Your Position
    ${response}=    DELETE User    ${CREATE_USER_ID}
    Should Be Equal As Numbers    ${response.status_code}    204

*** Keywords ***
POST Create User
    [Arguments]    ${name}    ${job}
    [Documentation]    Send a POST request to create a new user
    ${data}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    POST Request    ${BASE_URL}/users    json=${data}
    [Return]    ${response}

PATCH Update User
    [Arguments]    ${user_id}    ${name}    ${job}
    [Documentation]    Send a PATCH request to update an existing user
    ${data}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    PATCH Request    ${BASE_URL}/users/${user_id}    json=${data}
    [Return]    ${response}

DELETE User
    [Arguments]    ${user_id}
    [Documentation]    Send a DELETE request to remove an existing user
    ${response}=    DELETE Request    ${BASE_URL}/users/${user_id}
    [Return]    ${response}
