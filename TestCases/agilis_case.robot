*** Settings ***
Library     SeleniumLibrary
Library     DateTime

*** Variables ***
${WEB}      https://agilischemicals.com/
${BROWSER}        Chrome
${YourElement}    //div[@class='_2ClPktuQN1IdZ1KO1AWQA-']
${Agilis Page Title}    Agilis | eCommerce Platform Provider for the Chemical Industry

*** Test Cases ***
Login Test
#    Suite Setup     open browser    about:blank    chrome
    Open Web    #Go to website home page https://agilischemicals.com
    Validate Home Page Title
    Screenshot  Home_Page
    Enable Cookies

#   Scroll to the object to focus on onject
    Scroll Element Into View    ${YourElement}
    Wait Until Element is visible    ${YourElement}     timeout=5s
    Set Focus To Element    ${YourElement}
    Screenshot  Dis_OTP

#   Examine the parsed home page HTML markup code, assert that a <h2> tag exists with the verbiage of “Trusted Partners”, e.g. <h2>Our Trusted Partners</h2>
    Sleep   2s
    Element Text Should Be   xpath:(//div[@class="_2ClPktuQN1IdZ1KO1AWQA-"]/h2)[1]      Our Trusted Partners

#   The next sibling <div> tag, assert that there is an anchor tag exists, with href property to be “/palmer-holland”, e.g. <a href="/palmer-holland></a>.
    Wait Until Element Is Visible   xpath://a[@href="/palmer-holland"]  timeout=15
    ${url}=  get element attribute   xpath=//a[contains(@href, 'r-h')]  href
    Should be equal  ${url}  https://agilischemicals.com/palmer-holland

#   Click on the anchor link above to go to Palmer Holland’s storefront home page.
    Wait Until Element Is Visible   xpath://a[@href="/palmer-holland"]
    click element   xpath://a[@href="/palmer-holland"]

#   Examine the parsed storefront home page in the step above, find a button with “View Products”, e.g. <button>View Products</button>.
    Sleep   5s
    select window       title=Palmer Holland Health & Nutrition eCommerce Portal Home
    Screenshot  PH_HomePage

#   Click on the button above, then it should go to
    Wait Until Page Contains Element    //div[@class='_1eyvFfpdFnz2Eu9SWFJhRr']    timeout=5   error=false
    click link      xpath://a[@href='/palmer-holland/portfolio']

#   Examine the portfolio page’s parsed HTML markup code above, assert there is a
    ${text}=    Get Text        xpath://a[@href='/palmer-holland/portfolio']
    log to console  ${text}
    Element Text Should Be  xpath://a[@href='/palmer-holland/portfolio']     PORTFOLIO

#   <div> tag with “MuiCardHeader-content” style, e.g. <div
#   class="MuiCardHeader-content"> and assert inside of that <div> tag, there is a
#   <span> tag with “CARAMEL COLOR I” text verbiage in it.
    Element Should Be Visible  (//div[@class="MuiCardHeader-content"]//span[contains(text(),'CARAMEL COLOR I')])[1]


#   Examine in the same page as step above, assert there is an anchor tag with href
#   property to be “/palmer-holland/product/caramel-color-i-palmer-holland-inc”, e.g.
#   <a href="/palmer-holland/product/caramel-color-i-palmer-holland-inc">, click on
#   that link to land on the product detail page
    click link  xpath://a[@href="/palmer-holland/product/caramel-color-i-palmer-holland-inc"]


#  On the product detail page, assert there a request quote button, e.g. <button>Request Quote</button>. Also assert it’s clickable, clicking it load a form
    Sleep   5s
    Element Should Be Visible       xpath://button[contains(text(),'Request Quote')]
    Click Button        xpath://button[contains(text(),'Request Quote')]
    Sleep	20s
    Element Text Should Be  //div[contains(text(),'Quote Request')]    Quote Request
    Log to console	OK

*** Keywords ***
Open Browser To Home Page
#    webdrivermanager     chrome --linkpath C:/agilis/drivers/
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Screenshot  agilis_homepage

Validate Home Page Title
    maximize browser window
    Set Focus To Element    xpath://*[@id="app"]/div[1]/div/div[4]
    title should be     ${Agilis Page Title}

Enable Cookies
    Current Frame Should Contain    This website uses cookies to enhance the user experience.These cookies are used to collect information about how you interact with our website and allow us to remember you. We use this information in order to improve and customize your browsing experience and for analytics and metrics about our visitors both on this website and other media.
    Click Button    xpath://button[@id='']

Get DateTime
    ${date1}=  Get Current Date  result_format=%Y-%m-%d %H-%M-%S
    [Return]     ${date1}

Open Web
    Open Browser  ${WEB}   ${BROWSER}
    Maximize Browser Window
    ${Date}=      Get DateTime
    log to console    ${Date}
    Set Global Variable  ${Path}  C:/agilis/screenshot/${Date}

Screenshot
    [Arguments]  ${filename}
    Set Screenshot Directory  ${Path}
    Wait Until Page Contains  Element
    # ${datetime}=  Get DateTime
    Capture Page Screenshot  ${filename}.png
    Log To Console  ${\n}Screenshot








