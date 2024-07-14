*** Settings ***
Documentation   หน้าคำสั่งสำหรับเรียกใช้งาน function
Library         SeleniumLibrary
Library         Collections

*** Variables ***
${SERVER}                   https://www.nejavu.com/
${BROWSER}                  chrome
${DELAY}                    1
${CARTOON_URL}              https://www.nejavu.com/cartoon
${CONFIRM_BUTTON}           xpath=//button[contains(@class,'swal2-confirm') and contains(@class,'swal2-styled')]
${CONFIRM_MESSAGE}          ลบรายการสำเร็จ
${CONFIRM_LOCATOR}          xpath=//h2[contains(@class,'swal2-title')]
${ADD_TO_CART_BUTTON}       //div[contains(@class, 'nev-pd-card')][1]//button[contains(text(),'ใส่ตะกร้า')]
${BOOK_TITLE}               //div[contains(@class, 'nev-pd-card')][1]//h5[@class='detail-title']
${CART_BUTTON}              xpath=//a[@href='/cart']

*** Keywords ***
Open Website
    Open Browser    ${SERVER}   ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    ${DELAY}

Click Close Modal
    Click Element    class=close-modal

Click Button Cartoon
    Click Element    xpath=//a[@href='${CARTOON_URL}']

Take Screenshot
    Capture Page Screenshot
    Log    Screenshot taken

Get Book Titles
    Scroll Element Into View    (${BOOK_TITLE})[1]
    Set Selenium Implicit Wait    ${DELAY}
    ${Title1}=    Get Text    (${BOOK_TITLE})[1]
    ${Title2}=    Get Text    (${BOOK_TITLE})[2]
    ${Title3}=    Get Text    (${BOOK_TITLE})[3]
    ${Title4}=    Get Text    (${BOOK_TITLE})[4]
    ${Title5}=    Get Text    (${BOOK_TITLE})[5]
    ${book_list}=    Create List    ${Title1}    ${Title2}    ${Title3}    ${Title4}    ${Title5}
    Log To Console    ${book_list}
    Set Global Variable    ${book_list}

Add Books To Cart
    [Arguments]    ${button_xpath}
    ${buttons}=    Get WebElements    ${button_xpath}
    ${length}=     Get Length    ${buttons}
    FOR    ${index}    IN RANGE    ${length}
        Scroll Element Into View    ${button_xpath}[${index+1}]
        Click Element    ${button_xpath}[${index+1}]
        Wait Until Page Contains Element    //div[contains(text(),'เพิ่มสินค้าในตระกร้าสำเร็จ')]    timeout=10s
    END

Click Check Cart
    Click Element    ${CART_BUTTON}

Verify Book In Cart
    ${length}=    Get Length    ${book_list}
    FOR    ${num}    IN RANGE    ${length}
        ${book_name}=    Get From List    ${book_list}    ${num}
        Wait Until Page Contains Element    xpath=(//*[contains(text(),'${book_name}')])[1]    timeout=10s
    END

Delete Book
    ${length}=    Get Length    ${book_list}
    FOR    ${count}    IN RANGE    ${length}
        Click Element    (//a[@class="delete-item"])[1]
        Click Button    ${CONFIRM_BUTTON}
        Wait Until Element Is Visible    ${CONFIRM_LOCATOR}    timeout=10s
        Element Text Should Be    ${CONFIRM_LOCATOR}    ${CONFIRM_MESSAGE}
    END

Complete to Delete Book In Cart
    Wait Until Page Contains Element    //div[@id="badge-cart" and text()='0']
    Set Selenium Implicit Wait    ${DELAY}

Click Element At Index
    [Arguments]    ${element_xpath}    ${index}
    ${elements}=    Get WebElements    ${element_xpath}
    Click Element    ${elements[${index}]}