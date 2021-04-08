*** Settings ***
Library     SeleniumLibrary
Library     DateTime

*** Variables ***
${PATH}     C:/agilis/
${WEB}      https://agilischemicals.com/
${BROWSER}        Chrome
#${Page Title}    Agilis | eCommerce Platform Provider for the Chemical Industry

*** Test Cases ***
Verify Agilis Home Page
    Open Web    #Go to website home page https://agilischemicals.com
    Validate Home Page Title     Agilis | eCommerce Platform Provider for the Chemical Industry
    Screenshot  Home_Page
    [Documentation]  Enabling page cookies
    Current Frame Should Contain    This website uses cookies to enhance the user experience.These cookies are used to collect information about how you interact with our website and allow us to remember you. We use this information in order to improve and customize your browsing experience and for analytics and metrics about our visitors both on this website and other media.
    Click Button    xpath://button[@id='']
    Screenshot  Home_Page_With_No_Cookies_Shadow

Verify Our Truested Partners
    [Documentation]  Examine the parsed home page HTML markup code, assert that a <h2> tag exists with the verbiage of “Trusted Partners”, e.g. <h2>Our Trusted Partners</h2>
    Scroll Element into View    //div[@class='_2ClPktuQN1IdZ1KO1AWQA-']     1000    Trusted_Partners
    Sleep   2s
    Element Text Should Be   xpath:(//div[@class="_2ClPktuQN1IdZ1KO1AWQA-"]/h2)[1]      Our Trusted Partners
    [Documentation]   The next sibling <div> tag, assert that there is an anchor tag exists, with href property to be “/palmer-holland”, e.g. <a href="/palmer-holland></a>.
    Wait Until Element Is Visible   xpath://a[@href="/palmer-holland"]  timeout=15
    Screenshot  palmer-holland_Image
    ${url}=  get element attribute   xpath=//a[contains(@href, 'r-h')]  href
    Should be equal  ${url}  https://agilischemicals.com/palmer-holland
    [Documentation]   Click on the anchor link above to go to Palmer Holland’s storefront home page.
    Wait Until Element Is Visible   xpath://a[@href="/palmer-holland"]
    click element   xpath://a[@href="/palmer-holland"]

Verify palmer holland home page
    [Documentation]   Examine the parsed storefront home page in the step above, find a button with “View Products”, e.g. <button>View Products</button>.
    Sleep   5s
    Switch Window   title=Palmer Holland Health & Nutrition eCommerce Portal Home
    Validate Home Page Title     Palmer Holland Health & Nutrition eCommerce Portal Home
    Screenshot  Home_Page

Navigate to palmer holland portfolio page
    [Documentation]   Click on the button above, then it should go to
    ${condition} =     Wait Until Page Contains Element    xpath://a[@href='/palmer-holland/portfolio']    timeout=5   error=false
    Run Keyword if  '${condition}'=='false'       click element  (//*[@id="Layer_1"])[1]
    click link      xpath://a[@href='/palmer-holland/portfolio']
    [Documentation]   Examine the portfolio page’s parsed HTML markup code above, assert there is a
    Element Text Should Be  //a[@href='/palmer-holland/portfolio']     PORTFOLIO
    Screenshot  portfolio_page

Verify portfolio micro window
#   <div> tag with “MuiCardHeader-content” style, e.g. <div
#   class="MuiCardHeader-content"> and assert inside of that <div> tag, there is a
#   <span> tag with “CARAMEL COLOR I” text verbiage in it.
    Scroll Element into View    (//div[@class="MuiCardHeader-content"]//span[contains(text(),'CARAMEL COLOR I')])[1]    1000    CARAMEL_COLOR_I_Window
    Element Should Be Visible  (//div[@class="MuiCardHeader-content"]//span[contains(text(),'CARAMEL COLOR I')])[1]


Navigate to the product details page to request quote
#   Examine in the same page as step above, assert there is an anchor tag with href
#   property to be “/palmer-holland/product/caramel-color-i-palmer-holland-inc”, e.g.
#   <a href="/palmer-holland/product/caramel-color-i-palmer-holland-inc">, click on
#   that link to land on the product detail page
    click link  xpath://a[@href="/palmer-holland/product/caramel-color-i-palmer-holland-inc"]
    Screenshot  Product_details_page
    [Documentation]  On the product detail page, assert there a request quote button, e.g. <button>Request Quote</button>. Also assert it’s clickable, clicking it load a form
    Sleep   5s
    Element Should Be Visible       xpath://button[contains(text(),'Request Quote')]
    Click Button        xpath://button[contains(text(),'Request Quote')]
    Sleep	5s
    Screenshot  Request_quote_page
    Element Text Should Be  //div[contains(text(),'Quote Request')]    Quote Request
    Log to console	OK

Close all browser
    close all browsers


*** Keywords ***
Open Browser To Home Page
#    webdrivermanager     chrome --linkpath C:/agilis/drivers/
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Screenshot  agilis_homepage

Validate Home Page Title
    [Arguments]  ${Page Title}
    maximize browser window
    @{Windowtitles}    Get Window Titles
#    log to console  @{Windowtitles}
    title should be     ${Page Title}
#    Element Should Contain    @{Windowtitles}    ${Page Title}


Get DateTime
    ${date1}=  Get Current Date  result_format=%Y-%m-%d %H-%M-%S
    [Return]     ${date1}

Open Web
    Open Browser  ${WEB}   ${BROWSER}
    Maximize Browser Window
    ${Date}=      Get DateTime
    log to console    ${Date}
    Set Global Variable  ${Path}  ${PATH}/screenshot/${Date}

Screenshot
    [Arguments]  ${filename}
    Set Screenshot Directory  ${Path}
    Wait Until Page Contains  Element
    # ${datetime}=  Get DateTime
    Capture Page Screenshot  ${filename}.png
    Log To Console  ${\n}Screenshot

Scroll Element into View
    [Documentation]  Scroll to the object to focus on onject and take screenshot
    [Arguments]  ${YourElement}     ${ScrollUpTo}   ${ElementName}
    Wait Until Element is visible    ${YourElement}     timeout=5s
    execute javascript  window.scrollTo(0,${ScrollUpTo})
    Set Focus To Element    ${YourElement}
    Screenshot  ${ElementName}
