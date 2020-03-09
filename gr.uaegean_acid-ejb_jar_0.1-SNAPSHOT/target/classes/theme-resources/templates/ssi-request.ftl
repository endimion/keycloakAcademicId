<#import "template.ftl" as layout>




<!DOCTYPE html>
<html>
    <head>
<#-- <title>ESMO sp-ms</title> -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
        <meta charset="utf-8"></meta>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
        <meta name="viewport" content="width=device-width, initial-scale=1"></meta>
        <meta name="description" content=""></meta>
        <meta name="author" content=""></meta>
        <title>Create a new account</title>
        <meta http-equiv="cache-control" content="max-age=0" />
        <meta http-equiv="cache-control" content="no-cache" />
        <meta http-equiv="expires" content="0" />
        <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
        <meta http-equiv="pragma" content="no-cache" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"></link>
        <link rel="stylesheet" href="${url.resourcesPath}/css/main.css"></link>
        <link rel="icon"
              type="image/x-icon"
              href="favicon.ico"></link>
        <link rel="icon"
              type="image/x-icon"
              href="favicon.ico"></link>
        <!-- Overide the sidebar css -->
        <style>
            .sideBarClass{
                margin-top: 0;
            }

            .breadCrumbs{
                font-size: 18px;
                color:  #00be9f;
                padding-left: 0px;
            }
            </style>


        </head>
<#--<!-- <body onload="document.redirect.submit()"> -->
<#--<!-- <form action="${UrlToRedirect}" id="redirect" name="redirect" method="POST"> -->
<#--<!-- <input id="authResponse" type="hidden" value="${msToken}" name="msToken"/> -->
<#--<!-- </form> -->
    <body>


        
        <header>
            <div class="footerClass headerContainer">
                <!--<div class="container">-->
                <div class=" instructions" style="width:90%">
                    <div class="row">
                        <div class="col s6 m6 l6 " id="header-logo">
                            <img id="companyLogo" class="responsive-img" src= "${url.resourcesPath}/img/logo2.png" style="margin-top: 1.8em;
                                 max-height: 55px;float:left;    padding-left: 40.5%;"/>
                            </div>
                        <div class="col s6 m6 l6 " id="header-logo-aegean">
                            <img id="uAegeanLogo" class="responsive-img" src="${url.resourcesPath}/img/uaegean_logo.png" style="margin-top: 0em;
                                 margin-bottom: 1.2em;
                                 max-height: 85px;float:right; margin-right: 5%;"/>
                            </div>
                        </div>    

                    </div>
                    <!--</div>-->


                </div>
            </header>



        <div class="container">

            <div class="row  mainContent">

                <div class="col s12 m12 l10">

                    <div class="container" style="width: 90%;">

                        <div class="row instructions">
                            <div  id="mobile" class="col s12 ">
                                <p>
                                    <b >Identify using SEAL issued Verifiable Credentials</b> 
                                    <span >Scan the following QR code with your SSI wallet on your mobile phone
                                        </span>  
                                    </p>
                                <p >
                                    If you do not have an SSI wallet, you can download it from:
                                    
                                    </p>


                                <div class="row">
                                    <div class="input-field col s12">
                                       
                                      ${qr?no_esc}
                                        </div>


                            </div>
                        </div>
                    </div>








                        <div class="row" th:replace="footer :: footer"></div>

                        </div>
                    
                    

        <!--Import jQuery before materialize.js-->
                    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
                    <!-- Compiled and minified JavaScript -->
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
                    <script th:inline="javascript">
                                 
                                   let source = new EventSource("${ssEventSource}");
                                    source.addEventListener(
                                                        "vc_received",
                                                        evt => {
                                                          console.log(evt);//returns a string so needs further parsing into a JSON
                                                              //check if event sessionId is about our session
                                                                  // and if it is proceed with authentication
                                                                let sessionId = "${ssiSessionId}";
                                                                console.log("sessionID is " + sessionId);
                                                                if(sessionId === evt.lastEventId){
                                                                    console.log("sessions Match will proceed authentication");
                                                                        let form = document.createElement("form");
                                                                        form.setAttribute("method", "POST");
                                                                        form.setAttribute("action", "${responsePostEndpoint}");
                                                                        let hiddenField = document.createElement("input");
                                                                        hiddenField.setAttribute("type", "hidden");
                                                                        hiddenField.setAttribute("name", "sessionId");
                                                                        hiddenField.setAttribute("value", "${ssiSessionId}");
                                                                        form.appendChild(hiddenField);
                                                                        document.body.appendChild(form);
                                                                        form.submit();
                                                                }
                                                              
                                                              
                                                              })
                        </script>

                    </body>
                    </html>




