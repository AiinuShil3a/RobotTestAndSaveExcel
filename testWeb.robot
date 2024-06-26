*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    OperatingSystem
Library    DateTime

*** Variables ***
${BROWSER}        Chrome
${EXCEL_FILE}     test_Login.xlsx
${TESTER_NAME}    Supphalak Meneepanpanit

*** Test Cases ***
Login success
    [Documentation]    ทดสอบการ Login
    Open Browser    http://localhost:5173/    ${BROWSER}
    ${TestCase}=    Set Variable    TS1
    Click Element    //*[@id="root"]/div[3]/div[1]/nav/div/div[1]/button
    ${Username}=    Set Variable    Supphalak.sm1@gmail.com
    ${Password}=    Set Variable    12345678
    Input Text    name=email    ${Username}
    Input Text    name=password    ${Password}
    Click Element    //*[@id="Get-Started"]/div/form/div[4]/input
    ${avatarButton}=    Run Keyword And Return Status    Element Should Be Visible    id=avatarButton
    Should Be True    ${avatarButton}
    ${status}=     Set Variable If    ${avatarButton}==True    PASSED    FAILED
    ${actual}=   Set Variable If    ${avatarButton}==True    Show Avatar before login    Avatar does not appear
    ${date}=       Get Current Date    result_format=%Y-%m-%d
    Write Test Result To Excel TS1     ${TestCase}    ${Username}    ${Password}    ${status}    ${date}    ${TESTER_NAME}  ${actual}
    Close Browser

*** Test Cases ***
Login No input Username
    [Documentation]    ทดสอบการ Login Email is null
    Open Browser    http://localhost:5173/    ${BROWSER}
    ${TestCase}=    Set Variable    TS2
    Click Element    //*[@id="root"]/div[3]/div[1]/nav/div/div[1]/button
    ${Username}=    Set Variable    
    ${Password}=    Set Variable    12345678
    Input Text    name=email    ${Username}
    Input Text    name=password    ${Password}
    Click Element    //*[@id="Get-Started"]/div/form/div[4]/input
    ${result}=    Run Keyword And Return Status    Element Should Be Visible    //*[@id="Get-Started"]/div/form/h3
    Should Be True    ${result}
    ${status}=     Set Variable If    ${result}==True    PASSED    FAILED
    ${actual}=   Set Variable If    ${result}==True    Please fill out this field in input Email    Login Success
    ${date}=       Get Current Date    result_format=%Y-%m-%d
    Write Test Result To Excel TS2     ${TestCase}    ${Username}    ${Password}    ${status}    ${date}    ${TESTER_NAME}  ${actual}
    Close Browser

*** Test Cases ***
Login No input Password
    [Documentation]    ทดสอบการ Login Password is null
    Open Browser    http://localhost:5173/    ${BROWSER}
    ${TestCase}=    Set Variable    TS3
    Click Element    //*[@id="root"]/div[3]/div[1]/nav/div/div[1]/button
    ${Username}=    Set Variable    Supphalak.sm1@gmail.com
    ${Password}=    Set Variable    
    Input Text    name=email    ${Username}
    Input Text    name=password    ${Password}
    Click Element    //*[@id="Get-Started"]/div/form/div[4]/input
    ${result}=    Run Keyword And Return Status    Element Should Be Visible    //*[@id="Get-Started"]/div/form/h3
    Should Be True    ${result}
    ${status}=     Set Variable If    ${result}==True    PASSED    FAILED
    ${actual}=   Set Variable If    ${result}==True    Please fill out this field in input Password    Login Success
    ${date}=       Get Current Date    result_format=%Y-%m-%d
    Write Test Result To Excel TS3     ${TestCase}    ${Username}    ${Password}    ${status}    ${date}    ${TESTER_NAME}  ${actual}
    Close Browser

*** Test Cases ***
Login input Password less 8 number
    [Documentation]    ทดสอบการ Login Password is less 8 number
    Open Browser    http://localhost:5173/    ${BROWSER}
    ${TestCase}=    Set Variable    TS4
    Click Element    //*[@id="root"]/div[3]/div[1]/nav/div/div[1]/button
    ${Username}=    Set Variable    Supphalak.sm1@gmail.com
    ${Password}=    Set Variable    1234
    Input Text    name=email    ${Username}
    Input Text    name=password    ${Password}
    Click Element    //*[@id="Get-Started"]/div/form/div[4]/input
    ${result}=    Run Keyword And Return Status    Element Should Be Visible    //*[@id="Get-Started"]/div/form/h3
    Should Be True    ${result}
    ${status}=     Set Variable If    ${result}==True    PASSED    FAILED
    ${actual}=   Set Variable If    ${result}==True    Password less than 8 characters    Login Success
    ${date}=       Get Current Date    result_format=%Y-%m-%d
    Write Test Result To Excel TS4     ${TestCase}    ${Username}    ${Password}    ${status}    ${date}    ${TESTER_NAME}  ${actual}
    Close Browser

*** Keywords ***
Write Test Result To Excel TS1
    [Arguments]    ${TestCase}    ${Username}    ${Password}    ${status}   ${date}     ${TESTER_NAME}  ${actual}
    Create Excel Document    ${EXCEL_FILE}  
    Write Excel Cell    1   1   Test Cases
    Write Excel Cell    1   2   Username
    Write Excel Cell    1   3   Password
    Write Excel Cell    1   4   Expected 
    Write Excel Cell    1   5   Actual
    Write Excel Cell    1   6   Result (pass, fail)
    Write Excel Cell    1   7   Date
    Write Excel Cell    1   8   Tester
    Write Excel Cell    2   1   ${TestCase}
    Write Excel Cell    2   2   ${Username}
    Write Excel Cell    2   3   ${Password}
    Write Excel Cell    2   4   Show Avatar before login
    Write Excel Cell    2   5   ${actual}
    Write Excel Cell    2   6   ${status}
    Write Excel Cell    2   7   ${date}
    Write Excel Cell    2   8   ${TESTER_NAME}
    Save Excel Document    ${EXCEL_FILE}
    Close All Excel Documents

*** Keywords ***
Write Test Result To Excel TS2
    [Arguments]    ${TestCase}    ${Username}    ${Password}    ${status}   ${date}     ${TESTER_NAME}  ${actual}
    Open Excel Document    ${EXCEL_FILE}    doc_id=doc1
    Write Excel Cell    3   1   ${TestCase}
    Write Excel Cell    3   2   ${Username}
    Write Excel Cell    3   3   ${Password}
    Write Excel Cell    3   4   Please fill out this field in input Email
    Write Excel Cell    3   5   ${actual}
    Write Excel Cell    3   6   ${status}
    Write Excel Cell    3   7   ${date}
    Write Excel Cell    3   8   ${TESTER_NAME}
    Save Excel Document    ${EXCEL_FILE}
    Close All Excel Documents

*** Keywords ***
Write Test Result To Excel TS3
    [Arguments]    ${TestCase}    ${Username}    ${Password}    ${status}   ${date}     ${TESTER_NAME}  ${actual}
    Open Excel Document    ${EXCEL_FILE}    doc_id=doc1
    Write Excel Cell    4   1   ${TestCase}
    Write Excel Cell    4   2   ${Username}
    Write Excel Cell    4   3   ${Password}
    Write Excel Cell    4   4   Please fill out this field in input Password
    Write Excel Cell    4   5   ${actual}
    Write Excel Cell    4   6   ${status}
    Write Excel Cell    4   7   ${date}
    Write Excel Cell    4   8   ${TESTER_NAME}
    Save Excel Document    ${EXCEL_FILE}
    Close All Excel Documents

*** Keywords ***
Write Test Result To Excel TS4
    [Arguments]    ${TestCase}    ${Username}    ${Password}    ${status}   ${date}     ${TESTER_NAME}  ${actual}
    Open Excel Document    ${EXCEL_FILE}    doc_id=doc1
    Write Excel Cell    5   1   ${TestCase}
    Write Excel Cell    5   2   ${Username}
    Write Excel Cell    5   3   ${Password}
    Write Excel Cell    5   4   Password less than 8 characters
    Write Excel Cell    5   5   ${actual}
    Write Excel Cell    5   6   ${status}
    Write Excel Cell    5   7   ${date}
    Write Excel Cell    5   8   ${TESTER_NAME}
    Save Excel Document    ${EXCEL_FILE}
    Close All Excel Documents
