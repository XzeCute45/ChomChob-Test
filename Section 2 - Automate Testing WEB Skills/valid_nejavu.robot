*** Settings ***
Documentation   A test suite with a single test for valid login


Resource        resoursetest.robot

*** Test Cases ***
เปิด Browser และไปที่ Link
    Open Website
    Take Screenshot
    [Teardown]  Close Browser

ถ้ามี Banner pop-up ขึ้นมาให้กดปิด Modal (แต่ถ้าไม่ทำข้อต่อไปได้เลย)
    Open Website
    Click Close Modal
    Take Screenshot
    [Teardown]  Close Browser

Click menu “การ์ตูน”
    Open Website
    Click Close Modal
    Click Button Cartoon
    Take Screenshot
    [Teardown]  Close Browser

Get ชื่อหนังสือทุกเล่มในแถวที่หนึ่ง
    Open Website
    Maximize Browser Window
    Click Close Modal
    Click Button Cartoon
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'nev-pd-card')]
    Get Book Titles
    Close Browser

กดปุ่ม “ใส่ตระกร้า” หนังสือทุกเล่มแถวที่หนึ่ง
    Open Website
    Maximize Browser Window
    Click Close Modal
    Click Button Cartoon
    Wait Until Element Is Visible    ${BOOK_TITLE}
    Get Book Titles
    Add Books To Cart   ${ADD_TO_CART_BUTTON}
    Click Check Cart
    Verify Book In Cart
    Take Screenshot
    Delete Book
    Complete to Delete Book In Cart
    Close Browser

กดปุ่ม “รถเข็น ตระกร้า”
    Open Website
    Maximize Browser Window
    Click Close Modal
    Click Button Cartoon
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'nev-pd-card')]
    Get Book Titles
    Add Books To Cart   ${ADD_TO_CART_BUTTON}
    Click Check Cart
    Take Screenshot
    Close Browser

ไม่สามารถเช็คชื่อสินค้าได้เนื่องจากรายชื่อสินค้าบางส่วนไม่เหมือนกัน
Verify ชื่อหนังสือทุกเล่ม ที่อยู่ในตระกร้า โดยใช้ชื่อที่ได้มาจากข้อที่แล้ว
    Open Website
    Maximize Browser Window
    Click Close Modal
    Click Button Cartoon
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'nev-pd-card')]
    Get Book Titles
    Add Books To Cart   ${ADD_TO_CART_BUTTON}
    Click Check Cart
    Verify Book In Cart
    Take Screenshot
    Close Browser

ลบหนังสือทุกเล่มที่อยู่ในตระกร้า
    Open Website
    Maximize Browser Window
    Click Close Modal
    Click Button Cartoon
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'nev-pd-card')]
    Get Book Titles
    Add Books To Cart   ${ADD_TO_CART_BUTTON}
    Click Check Cart
    Verify Book In Cart
    Delete Book
    Take Screenshot
    Close Browser

Verify badge บนรถเข็นว่าเหลือหนังสือเท่ากับ 0
    Open Website
    Maximize Browser Window
    Click Close Modal
    Click Button Cartoon
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'nev-pd-card')]
    Get Book Titles
    Add Books To Cart   ${ADD_TO_CART_BUTTON}
    Click Check Cart
    Verify Book In Cart
    Delete Book
    Complete to Delete Book In Cart
    Take Screenshot
    Close Browser