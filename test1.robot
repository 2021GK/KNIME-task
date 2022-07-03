*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Log Into Knime
    [Arguments]     ${USERNAME}     ${PASSWORD}
    Open Browser    ${WEBSITE}      ${BROWSER}
    Wait Until Element Is Visible       ${COOKIES}
    Click Element       ${COOKIES}
    Sleep       2s
    Click Element    ${SIGN_IN}
    Wait Until Element Is Visible       id:edit-name
    Input Text      id:edit-name      ${USERNAME}
    Input Text      id:edit-pass        ${PASSWORD}
    Click Element       id:edit-submit

Go To Spaces Page
    Wait Until Element Is Visible       ${USER_DROPDOWN_MENU}
    Click Element     ${USER_DROPDOWN_MENU}
    Page Should Contain Element     ${SPACES_LINK}
    Click Element     ${SPACES_LINK}

Create New Space
    [Arguments]     ${space_type}
    Wait Until Element Is Visible       //div[@class="create-space-card"]//div[@class="buttons"]//button[@class="button compact"][${space_type}]
    Click Element       //div[@class="create-space-card"]//div[@class="buttons"]//button[@class="button compact"][${space_type}]
    Wait Until Element Is Visible       ${SAVE_SPACE}
    Click Element       ${SAVE_SPACE}
    Element Should Contain    ${NOTIFICATION_MESSAGE}    ${CREATE_SUCCESS_MESSAGE}

Get New Space Name
    Wait Until Element Is Visible       ${NEW_SPACE_NAME}
    ${CURRENT_SPACE}      Get Text       ${NEW_SPACE_NAME}
    Set Global Variable     ${CURRENT_SPACE}

Check If New Space Exists
    Click Element       ${LINK_TO_SPACES_PAGE}
    Sleep       2s
    ${href}=    Get Location
    Should Be Equal     ${USERS_SPACES_PAGE}        ${href}
    Sleep       2s
    Wait Until Page Contains     ${CURRENT_SPACE.strip()}

Select Space
    [Arguments]     ${SELECTED_SPACE}
    Wait Until Element Is Visible       //div[@class="card-body"]//h3[@class="title"][normalize-space()="${SELECTED_SPACE}"]
    Click Element       //div[@class="card-body"]//h3[@class="title"][normalize-space()="${SELECTED_SPACE}"]

Delete Space
    [Arguments]     ${SELECTED_SPACE}
    Wait Until Element Is Visible       ${SPACE_MORE_MENU}
    Click Element       ${SPACE_MORE_MENU}
    Wait Until Element Is Visible      ${DELETE_BUTTON}
    Click Element       ${DELETE_BUTTON}
    Wait Until Element Is Visible       ${SPACE_NAME_INPUT}
    Input Text      ${SPACE_NAME_INPUT}      ${SELECTED_SPACE}
    Click Element       ${CONFIRM_DELETE}
    Sleep       3s

Loop Through Spaces List
    [Arguments]     ${SELECTED_SPACE}
    ${SPACES_COUNT}    Get Element Count    ${SPACE_CARD}
    FOR     ${i}        IN RANGE        1       ${SPACES_COUNT}
            ${TITLE}       Get Text        //ul[@class="space-list"]//li[${i}]//div[@class="card-body"]//h3[@class="title"]
            Run Keyword If      "${TITLE.strip()}" == "${SELECTED_SPACE}"       FAIL
    END

Check If Space Deleted
    [Arguments]     ${SELECTED_SPACE}
    ${href}=    Get Location
    Should Be Equal     ${USERS_SPACES_PAGE}        ${href}
    Element Should Contain    ${NOTIFICATION_MESSAGE}    ${DELETE_SUCCESS_MESSAGE}
    Loop Through Spaces List        ${SELECTED_SPACE}

Check If Current Space Deleted
    [Arguments]     ${SELECTED_SPACE}
    ${href}=    Get Location
    Should Be Equal     ${USERS_SPACES_PAGE}        ${href}
    Element Should Contain    ${NOTIFICATION_MESSAGE}    ${DELETE_SUCCESS_MESSAGE}
    Loop Through Spaces List        ${SELECTED_SPACE}

*** Variables ***
${WEBSITE}      https://hub.knime.com/
${BROWSER}      chrome
${COOKIES}      //button[@class="accept-button button primary"]
${SIGN_IN}       //div[@class="login"]//button
${USER_DROPDOWN_MENU}       //div[@class="avatar avatar-placeholder "]
${space_type}      1
${num}      2
${SPACES_LINK}       //div[@class="submenu"]//div[@class="menu-wrapper expanded"]//ul//li[2]
${SAVE_SPACE}       //button[@title="Save"]
${NOTIFICATION_MESSAGE}     //div[@class="title"]//span[@class="message"]
${CREATE_SUCCESS_MESSAGE}       Your new space was created successfully!
${LINK_TO_SPACES_PAGE}      //nav[@class="breadcrumb"]//ul//li[3]//a
${NEW_SPACE_NAME}    //nav[@class="breadcrumb"]//ul//li[4]//span
${SPACE_MORE_MENU}      //button[@class="toggle function-button single"]
${DELETE_BUTTON}        //button[contains(text(), "Delete space")]
${SPACE_NAME_INPUT}     //input[@placeholder="space name"]
${CONFIRM_DELETE}       //button[@form="confirmationForm"]
${DELETE_SUCCESS_MESSAGE}       Space was deleted successfully!
${USERS_SPACES_PAGE}        https://hub.knime.com/${USERNAME}/spaces
${NEW_SPACE}        New space
${SPACE_CARD}        //ul[@class="space-list"]//li//div[@class="card-body"]//h3[@class="title"]

*** Test Cases ***
Create Space Test
    [Documentation]     This test creates a single space. Variables needed are the user's KNIME username and password.
    ...                 Type of space needs to be specified as well: space_type=1 is for private, space_type=2 is for public.
    ...                 If the type of space is not defined, the default is private
    [Tags]      KH-1
    Log Into Knime      ${USERNAME}     ${PASSWORD}
    Go To Spaces Page
    Create New Space        ${space_type}
    Sleep       1s
    Get New Space Name
    Check If New Space Exists
    [Teardown]      Close All Browsers

Delete Single Space Test
    [Tags]      KH-2
    [Documentation]     This test deletes a space with a name which the user defines through "SPACE_TO_DELETE" variable
    Log Into Knime  ${USERNAME}     ${PASSWORD}
    Go To Spaces Page
    Select Space    ${SPACE_TO_DELETE}
    Delete Space    ${SPACE_TO_DELETE}
    Sleep       2s
    Check If Space Deleted  ${SPACE_TO_DELETE}
    [Teardown]      Close All Browsers

Create Multiple Spaces Test
    [Tags]      KH-3
    [Documentation]     This tests creates multiple spaces. The number of spaces to create is defined through the "num" variable
    Log Into Knime      ${USERNAME}     ${PASSWORD}
    Go To Spaces Page
    FOR     ${k}        IN RANGE        1       ${num}+1
        Create New Space        ${space_type}
        Sleep       1s
        Get New Space Name
        Check If New Space Exists
        Reload Page
        Sleep       2s
    END
    [Teardown]      Close All Browsers

Delete All Spaces Test
    [Tags]      KH-4
    [Documentation]     This tests deletes all the spaces from the spaces page
     Log Into Knime      ${USERNAME}     ${PASSWORD}
     Go To Spaces Page
     Sleep       3s
     ${SPACES_COUNT}    Get Element Count    ${SPACE_CARD}
     ${j}=       Set Variable        ${SPACES_COUNT}
     WHILE       ${j} > 0
        ${CURRENT_SPACE_NAME_UNTRIMMED}       Get Text        //li[${j}]//div[@class="card-body"]//h3[@class="title"]
        ${CURRENT_SPACE_NAME}=      Set Variable        ${CURRENT_SPACE_NAME_UNTRIMMED.strip()}
        Click Element       //li[${j}]//div[@class="card-body"]//h3[@class="title"]
        Sleep       2s
        Delete Space    ${CURRENT_SPACE_NAME}
        Check If Current Space Deleted      ${CURRENT_SPACE_NAME}
        Reload Page
        ${j}=   Evaluate       ${j} -1
     END
     [Teardown]      Close All Browsers
