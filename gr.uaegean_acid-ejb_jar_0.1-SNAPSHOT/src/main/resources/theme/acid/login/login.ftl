<#import "template.ftl" as layout>

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
        <meta charset="utf-8"></meta>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
        <meta name="viewport" content="width=device-width, initial-scale=1"></meta>
        <meta name="description" content=""></meta>
        <meta name="author" content=""></meta>
        <title>Provide additional data</title>
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/css/materialize.min.css"></link>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"></link>
        <link rel="stylesheet" href="css/main.css"></link>
        <link rel="icon"
              type="image/x-icon"
              href="favicon.ico"></link>
    </head>
    
    
    <body>

         <header >
            <div class="footerClass headerContainer">
                <div class=" instructions" style="width:90%">
                    <div class="row">
                        <div class="col s6 m6 l6 " id="header-logo">
                            <img id="companyLogo" class="responsive-img" src= "img/logo2.png" style="margin-top: 1.8em;
                                 max-height: 55px;float:left;    padding-left: 40.5%;"/>
                        </div>
                        <div class="col s6 m6 l6 " id="header-logo-aegean">
                            <img id="uAegeanLogo" class="responsive-img" src="img/uaegean_logo.png" style="margin-top: 0em;
                                 margin-bottom: 1.2em;
                                 max-height: 85px;float:right; margin-right: 20%;"/>
                        </div>
                    </div>    

                </div>
            </div>
        </header>
    

        <div class="container">
            <div class="row  mainContent">
                <div class="col s12 m12 l12">
                    <div class="container" style="width: 90%;">
                        <div class="row instructions">
                            <div   class="col s12 ">
                                <div class="row">
                                    <p  class="col s12">
                                        <b>Transfer your Academic Attributes</b>: You will now be directed to GR Academic ID Service (Ministry of Education) to identify and 
                                        provide to Requesting Party the demanded academic attributes. To successfully identify please enter your personal AMKA number (The AMKA,
                                        the Greek Social Security number, is the work and insurance ID for every employee, pensioner and dependent member of a 
                                        family living in Greece. Find your AMKA <a href="http://www.amka.gr/" target="_blank">HERE!</a>). 
                                    </p>
                                </div>
                                <form  id="amkaForm" th:action="@{forward}" method="post">
                                    <div class="row">
                                        <label class="col l1 s12" for="amka" >amka</label>
                                        <input class="col l7 s12" type="text" id="amka"/> 
                                    </div>
                                    <!--<input type="hidden" name="sessionId" th:field="*{sessionId}" th:value="${amka.sessionId}"/>-->
                                    <div class="row" id="buttons">
                                        <button type="button" onclick="onCancelClick()" class="col s12 m4 l4 waves-effect waves-light btn-large swell-btn cancel-btn" style="margin-right: 2em;">
                                            Cancel
                                        </button>
                                        <button  type="button" onclick="onSubmit()" class= "col s12 m4 l4 waves-effect waves-light btn-large swell-btn next-btn" value="Submit">Submit</button>
                                    </div>
                                    <div class="row" id="preloader" style="display:none">
                                        <div class="progress">
                                            <div class="indeterminate"></div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    
    
    
    
        <div class="container footer-container" style="margin-left: 2rem;">
            <div class="row">
                <div id="border" style="    border-top: 1px solid #d0d0d0;
                     width: 91%;
                     margin-left: 0.7rem;
                     padding-top: 1em;"></div>
                <div class="col s12 m4 footerCol" id="flags" style="padding-left: 5em;">
                    <a target="_blank" href="https://ec.europa.eu/inea/en/connecting-europe-facility">
                        <img src="../img/en_cef.jpg" class="responsive-img" alt="cef"></img>
                    </a>
                </div>
                <div class="col s12  m4 footerCol" style="padding-left: 5em;">
                    <p style="margin-top: 0;text-align: justify; color: black;" th:utext="#{footer}">
                    </p>
                </div>
                <div class="col s12  m4 footerCol" style="padding-left: 5em; margin-top: 0.2%;">
                    <a target="_blank" href="//opensource.org"><img  src="img/open_source1-4.png" class="responsive-img" alt="cef"/></a>
                    <p style="margin:0">Developed with Open Source Software (OSS) </p>
                </div>

            </div>
        </div>
    
    
    
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/js/materialize.min.js"></script>
        <script type="text/javascript">
            function langGR() {
                window.location.href = 'login?localeCode=gr';
            }
            function langEN() {
                window.location.href = 'login?localeCode=en';
            }
            function onCancelClick() {
                let sessionId = document.getElementById("sessionId").value;
                window.location = "/ap/proceedAfterError?sessionId=" + sessionId;
            }


           function onSubmit(){
               let amkaForm = document.getElementById("amkaForm");
               let  buttons = document.getElementById("buttons");
               let  preloader = document.getElementById("preloader");

               buttons.style.display = "none";
               preloader.style.display = "block";
               amkaForm.submit();

           }

        </script>
    </body>
</html>



 
