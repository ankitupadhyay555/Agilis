*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://agilischemicals.com/palmer-holland/portfolio
${BROWSER}        Chrome

*** Test Cases ***
Test1
    Open Browser    ${LOGIN URL}    ${BROWSER}
    maximize browser window
    title should be     Agilis | eCommerce Platform Provider for the Chemical Industry
    Current Frame Should Contain    This website uses cookies to enhance the user experience.These cookies are used to collect information about how you interact with our website and allow us to remember you. We use this information in order to improve and customize your browsing experience and for analytics and metrics about our visitors both on this website and other media.
    Click Button    xpath://button[@id='']

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


#Examine in the same page as step above, assert there is an anchor tag with href
#property to be “/palmer-holland/product/caramel-color-i-palmer-holland-inc”, e.g.
#<a href="/palmer-holland/product/caramel-color-i-palmer-holland-inc">, click on
#that link to land on the product detail page
#    ${link}=
#    Scroll Element Into View    ${link}
#    Wait Until Element is visible    ${link}     timeout=5s
#    Set Focus To Element    ${link}
    click link  xpath://a[@href="/palmer-holland/product/caramel-color-i-palmer-holland-inc"]


#  On the product detail page, assert there a request quote button, e.g.
#<button>Request Quote</button>. Also assert it’s clickable, clicking it load a form
    Sleep   5s
    Element Should Be Visible       xpath://button[contains(text(),'Request Quote')]
    Click Button        xpath://button[contains(text(),'Request Quote')]
    Sleep	20s
    Element Text Should Be  //div[contains(text(),'Quote Request')]    Quote Request
    Log to console	OK
#    Select Frame	xpath://form[@class='_3l6NL7AMidRfuzK_PwUzOw']
#    Log to console	OK
#Dashboard Page Should Be Open
#    Location Should Be    ${DASHBOARD URL}
#    Title Should Be    Dashboard
#    Go Back



