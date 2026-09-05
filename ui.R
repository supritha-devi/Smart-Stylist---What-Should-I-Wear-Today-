# =================================================================
# ui.R
# FRONTEND ONLY - defines what the user sees and interacts with.
# =================================================================

ui <- fluidPage(
  
  tags$head(
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "style.css"
    ),
    
    # Registered once at page load - guaranteed to run, unlike a
    # <script> tag re-inserted via renderUI/uiOutput.
    tags$script(HTML(
      "Shiny.addCustomMessageHandler('setBodyClass', function(cls) {
         document.body.className = cls;
       });"
    ))
  ),
  
  uiOutput("main_ui")
)
