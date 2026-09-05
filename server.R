server <- function(input, output, session) {
  
  splash_active <- reactiveVal(TRUE)
  logged_in     <- reactiveVal(FALSE)
  current_user  <- reactiveVal(NULL)
  gender_chosen <- reactiveVal(FALSE)
  chosen_gender <- reactiveVal(NULL)
  profile_done  <- reactiveVal(FALSE)
  wardrobe_done <- reactiveVal(FALSE)
  login_error   <- reactiveVal("")
  edit_prefill  <- reactiveVal(NULL)
  
  # ---------------- SPLASH: auto-dismissed after 5 seconds (no click needed) ----------------
  later::later(function() {
    splash_active(FALSE)
  }, delay = 5)
  
  # ---------------- DYNAMIC THEME (reliable version) ----------------
  observeEvent(chosen_gender(), {
    g <- chosen_gender()
    req(g)
    cls <- if (identical(g, "Female")) "theme-female" else "theme-male"
    session$sendCustomMessage("setBodyClass", cls)
  })
  
  # ---------------- MAIN UI SWITCHER ----------------
  output$main_ui <- renderUI({
    
    if (splash_active()) {
      
      # ---- Splash screen (no click - auto-advances after 5s) ----
      div(
        class = "splash-screen",
        div(
          class = "img-wrap",
          tags$img(
            src = paste0(
              "data:image/jpeg;base64,",
              splash_img_b64
            ),
            alt = "What Should I Wear Today?"
          )
        )
      )
      
    } else if (!logged_in()) {
      
      tagList(
        h3("What Should I Wear Today?"),
        h4("Login or Create Account"),
        
        textInput(
          "username",
          "Username:"
        ),
        
        passwordInput(
          "password",
          "Password:"
        ),
        
        actionButton(
          "login_btn",
          "Login / Sign Up"
        ),
        
        tags$p(
          class = "login-error-msg",
          login_error()
        )
      )
      
    } else if (!gender_chosen()) {
      
      # ---- Gender selection ----
      div(
        class = "gender-select-wrap",
        div(
          class = "img-wrap",
          
          tags$img(
            src = paste0(
              "data:image/jpeg;base64,",
              gender_img_b64
            ),
            alt = "Who are you?"
          )
        ),
        
        div(
          class = "gender-btn-row",
          
          tags$button(
            id = "select_female_btn",
            type = "button",
            class = "btn btn-default action-button gender-btn gender-btn-female",
            HTML("Female &nbsp;&gt;")
          ),
          
          tags$button(
            id = "select_male_btn",
            type = "button",
            class = "btn btn-default action-button gender-btn gender-btn-male",
            HTML("Male &nbsp;&gt;")
          )
        )
      )
      
    } else if (!profile_done()) {
      
      pre <- edit_prefill()
      
      tagList(
        h3(
          paste(
            "Welcome,",
            current_user()
          )
        ),
        
        h4(
          if (!is.null(pre))
            "Edit your profile"
          else
            "Set up your profile (only needed once)"
        ),
        
        selectInput(
          "district",
          "District:",
          choices = unique(locations_data$District),
          selected = if (!is.null(pre)) pre$district else NULL
        ),
        
        uiOutput("area_ui"),
        
        radioButtons(
          "category_type",
          "You are a:",
          choices = c(
            "Working Professional",
            "Student"
          ),
          selected = if (!is.null(pre) && nchar(pre$category_type) > 0)
            pre$category_type
          else
            character(0)
        ),
        
        uiOutput("role_ui"),
        
        actionButton(
          "save_profile_btn",
          "Save Profile"
        )
      )
      
    } else if (!wardrobe_done()) {
      
      tagList(
        h3(
          paste(
            "Welcome,",
            current_user()
          )
        ),
        
        h4(
          "Add what you own (only needed once)"
        ),
        
        p(
          "Add a few clothing, footwear, and jewelry items you actually own. ",
          "You can skip this and use generic suggestions instead."
        ),
        
        selectInput(
          "wardrobe_category",
          "Category:",
          choices = c(
            "Clothing",
            "Footwear",
            "Jewelry"
          )
        ),
        
        textInput(
          "wardrobe_item",
          "Item Name (e.g. White Cotton T-shirt):"
        ),
        
        textInput(
          "wardrobe_colour",
          "Colour:"
        ),
        
        textInput(
          "wardrobe_material",
          "Material:"
        ),
        
        actionButton(
          "add_wardrobe_btn",
          "Add Item"
        ),
        
        hr(),
        
        h4("Items added so far"),
        
        tableOutput(
          "wardrobe_table"
        ),
        
        hr(),
        
        actionButton(
          "finish_wardrobe_btn",
          "Finish"
        ),
        
        actionButton(
          "skip_wardrobe_btn",
          "Skip for now"
        )
      )
      
    } else {
      
      tagList(
        h3(
          paste(
            "Hello,",
            current_user()
          )
        ),
        
        actionButton(
          "edit_profile_btn",
          "Edit Profile"
        ),
        
        actionButton(
          "edit_wardrobe_btn",
          "Edit Wardrobe"
        ),
        
        hr(),
        
        selectInput(
          "occasion",
          "What are you dressing for today?",
          choices = occasion_data$Occasion
        ),
        
        dateInput(
          "visit_date",
          "Date:",
          value = Sys.Date()
        ),
        
        actionButton(
          "get_rec_btn",
          "Get My Recommendation"
        ),
        
        hr(),
        
        uiOutput(
          "recommendation_ui"
        ),
        
        hr(),
        
        h4("Your Past Recommendations"),
        
        tableOutput(
          "history_table"
        )
      )
    }
  })
  
  # ---------------- AREA ----------------
  output$area_ui <- renderUI({
    
    req(input$district)
    
    areas <- locations_data$Area[
      locations_data$District == input$district
    ]
    
    pre <- edit_prefill()
    
    selectInput(
      "area",
      "Specific Area:",
      choices = areas,
      selected = if (!is.null(pre) && pre$area %in% areas)
        pre$area
      else
        NULL
    )
  })
  
  # ---------------- ROLE ----------------
  output$role_ui <- renderUI({
    
    req(input$category_type)
    
    pre <- edit_prefill()
    
    if (input$category_type == "Working Professional") {
      
      selectInput(
        "role_choice",
        "Your Role:",
        choices = role_data$Role,
        selected = if (!is.null(pre) && pre$role_choice %in% role_data$Role)
          pre$role_choice
        else
          NULL
      )
      
    } else {
      
      selectInput(
        "role_choice",
        "Student Type:",
        choices = student_data$StudentType,
        selected = if (!is.null(pre) && pre$role_choice %in% student_data$StudentType)
          pre$role_choice
        else
          NULL
      )
    }
  })
  
  # ---------------- LOGIN / SIGN UP ----------------
  observeEvent(input$login_btn, {
    
    req(
      input$username,
      input$password
    )
    
    login_error("")
    
    uname <- trimws(input$username)
    
    existing <- users_data[
      users_data$Username == uname,
    ]
    
    # New user
    if (nrow(existing) == 0) {
      
      new_row <- data.frame(
        
        Username = uname,
        Password = input$password,
        
        Gender = "",
        District = "",
        Area = "",
        
        CategoryType = "",
        RoleOrStudentType = "",
        
        stringsAsFactors = FALSE
      )
      
      users_data <<- rbind(
        users_data,
        new_row
      )
      
      write.csv(
        users_data,
        users_file,
        row.names = FALSE
      )
      
      logged_in(TRUE)
      current_user(uname)
      
      gender_chosen(FALSE)
      chosen_gender(NULL)
      
      profile_done(FALSE)
      wardrobe_done(FALSE)
      
    }
    
    # Existing user
    else if (
      existing$Password[1] ==
      input$password
    ) {
      
      logged_in(TRUE)
      current_user(uname)
      
      has_gender <-
        !is.na(existing$Gender[1]) &&
        existing$Gender[1] != ""
      
      if (has_gender) {
        
        chosen_gender(
          existing$Gender[1]
        )
        
        gender_chosen(TRUE)
        
      } else {
        
        chosen_gender(NULL)
        gender_chosen(FALSE)
      }
      
      has_profile <-
        !is.na(existing$District[1]) &&
        existing$District[1] != ""
      
      profile_done(has_profile)
      
      has_wardrobe <-
        nrow(
          wardrobe_data[
            wardrobe_data$Username == uname,
          ]
        ) > 0
      
      wardrobe_done(has_wardrobe)
      
    }
    
    # Incorrect password
    else {
      
      login_error(
        "Incorrect password. Try again."
      )
    }
  })
  
  # ---------------- FEMALE ----------------
  observeEvent(
    input$select_female_btn,
    {
      
      chosen_gender("Female")
      gender_chosen(TRUE)
    }
  )
  
  # ---------------- MALE ----------------
  observeEvent(
    input$select_male_btn,
    {
      
      chosen_gender("Male")
      gender_chosen(TRUE)
    }
  )
  
  # ---------------- EDIT PROFILE ----------------
  observeEvent(
    input$edit_profile_btn,
    {
      
      urow <- users_data[
        users_data$Username ==
          current_user(),
      ]
      
      if (nrow(urow) > 0) {
        
        edit_prefill(
          list(
            district = urow$District[1],
            area = urow$Area[1],
            category_type = urow$CategoryType[1],
            role_choice = urow$RoleOrStudentType[1]
          )
        )
      }
      
      profile_done(FALSE)
    }
  )
  
  # ---------------- EDIT WARDROBE ----------------
  observeEvent(
    input$edit_wardrobe_btn,
    {
      wardrobe_done(FALSE)
    }
  )
  
  # ---------------- SAVE PROFILE ----------------
  observeEvent(
    input$save_profile_btn,
    {
      
      req(
        chosen_gender(),
        input$district,
        input$area,
        input$category_type,
        input$role_choice
      )
      
      row_idx <- which(
        users_data$Username ==
          current_user()
      )
      
      if (length(row_idx) == 0)
        return(NULL)
      
      users_data$Gender[row_idx] <<-
        chosen_gender()
      
      users_data$District[row_idx] <<-
        input$district
      
      users_data$Area[row_idx] <<-
        input$area
      
      users_data$CategoryType[row_idx] <<-
        input$category_type
      
      users_data$RoleOrStudentType[row_idx] <<-
        input$role_choice
      
      write.csv(
        users_data,
        users_file,
        row.names = FALSE
      )
      
      edit_prefill(NULL)
      profile_done(TRUE)
    }
  )
  
  # ---------------- ADD WARDROBE ITEM ----------------
  observeEvent(
    input$add_wardrobe_btn,
    {
      
      req(
        input$wardrobe_item,
        input$wardrobe_colour,
        input$wardrobe_material
      )
      
      new_item <- data.frame(
        
        Username = current_user(),
        
        Category =
          input$wardrobe_category,
        
        ItemName =
          input$wardrobe_item,
        
        Colour =
          input$wardrobe_colour,
        
        Material =
          input$wardrobe_material,
        
        stringsAsFactors = FALSE
      )
      
      wardrobe_data <<-
        rbind(
          wardrobe_data,
          new_item
        )
      
      write.csv(
        wardrobe_data,
        wardrobe_file,
        row.names = FALSE
      )
      
      updateTextInput(
        session,
        "wardrobe_item",
        value = ""
      )
      
      updateTextInput(
        session,
        "wardrobe_colour",
        value = ""
      )
      
      updateTextInput(
        session,
        "wardrobe_material",
        value = ""
      )
    }
  )
  
  # ---------------- WARDROBE TABLE ----------------
  output$wardrobe_table <- renderTable({
    
    req(
      current_user()
    )
    
    wardrobe_data[
      wardrobe_data$Username ==
        current_user(),
      
      c(
        "Category",
        "ItemName",
        "Colour",
        "Material"
      )
    ]
  })
  
  # ---------------- FINISH / SKIP WARDROBE ----------------
  observeEvent(
    input$finish_wardrobe_btn,
    {
      wardrobe_done(TRUE)
    }
  )
  
  observeEvent(
    input$skip_wardrobe_btn,
    {
      wardrobe_done(TRUE)
    }
  )
  
  # ---------------- RECOMMENDATION ----------------
  observeEvent(
    input$get_rec_btn,
    {
      
      req(
        input$occasion
      )
      
      user_row <- users_data[
        users_data$Username ==
          current_user(),
      ]
      
      district <-
        user_row$District[1]
      
      area <-
        user_row$Area[1]
      
      role <-
        user_row$RoleOrStudentType[1]
      
      category <-
        user_row$CategoryType[1]
      
      # Weather
      w_idx <- which(
        weather_data$District ==
          district &
          weather_data$Area ==
          area
      )
      
      if (length(w_idx) == 0)
        w_idx <- 1
      
      weather_match <-
        weather_data[w_idx[1], ]
      
      temperature <-
        as.numeric(
          weather_match$Temperature[1]
        )
      
      rainfall <-
        as.numeric(
          weather_match$Rainfall[1]
        )
      
      # Occasion
      o_idx <- which(
        occasion_data$Occasion ==
          input$occasion
      )
      
      if (length(o_idx) == 0)
        o_idx <- 1
      
      occ_match <-
        occasion_data[o_idx[1], ]
      
      # Role
      if (
        identical(
          category,
          "Working Professional"
        )
      ) {
        
        r_idx <- which(
          role_data$Role == role
        )
        
        role_match <-
          if (length(r_idx) > 0)
            role_data[r_idx[1], ]
        else
          NULL
        
      } else {
        
        r_idx <- which(
          student_data$StudentType ==
            role
        )
        
        role_match <-
          if (length(r_idx) > 0)
            student_data[r_idx[1], ]
        else
          NULL
      }
      
      # Default recommendation
      clothing_type <-
        occ_match$ClothingType[1]
      
      colour <-
        occ_match$PreferredColour[1]
      
      material <-
        occ_match$Material[1]
      
      footwear <-
        occ_match$Footwear[1]
      
      jewelry <-
        occ_match$Jewelry[1]
      
      role_note <- ""
      
      # Role-based recommendation
      if (
        !is.null(role_match) &&
        identical(
          role_match$Formality[1],
          "Uniform"
        )
      ) {
        
        clothing_type <-
          role_match$ClothingType[1]
        
        material <-
          role_match$Material[1]
        
        footwear <-
          role_match$Footwear[1]
        
        role_note <-
          paste0(
            "Uniform required for '",
            role,
            "' — this overrides the occasion outfit."
          )
        
      } else if (
        !is.null(role_match)
      ) {
        
        role_note <-
          paste0(
            "Your role/student norm ('",
            role,
            "') typically expects: ",
            role_match$ClothingType[1],
            ", ",
            role_match$Footwear[1],
            "."
          )
      }
      
      # Match wardrobe FIRST (before weather adjustments), by keyword
      # overlap with the occasion's clothing type - e.g. an occasion
      # calling for "Saree / Lehenga" will match a wardrobe item named
      # "Red Silk Saree". When a match is found, its OWN colour and
      # material become the actual answer - not just a footnote.
      match_wardrobe <-
        function(
    cat,
    keyword_text
        ) {
          
          items <-
            wardrobe_data[
              wardrobe_data$Username ==
                current_user() &
                wardrobe_data$Category ==
                cat,
            ]
          
          if (nrow(items) == 0)
            return(NULL)
          
          keywords <-
            unlist(
              strsplit(
                tolower(keyword_text),
                "[^a-z]+"
              )
            )
          
          keywords <- keywords[nchar(keywords) > 2]
          
          if (length(keywords) == 0)
            return(NULL)
          
          hit_idx <-
            which(
              sapply(
                items$ItemName,
                function(nm) {
                  
                  nm_l <- tolower(nm)
                  
                  any(
                    sapply(
                      keywords,
                      function(k) grepl(k, nm_l, fixed = TRUE)
                    )
                  )
                }
              )
            )
          
          if (length(hit_idx) > 0)
            return(items[hit_idx[1], ])
          
          return(NULL)
        }
      
      clothing_match <-
        match_wardrobe(
          "Clothing",
          clothing_type
        )
      
      footwear_match <-
        match_wardrobe(
          "Footwear",
          footwear
        )
      
      jewelry_match <-
        match_wardrobe(
          "Jewelry",
          jewelry
        )
      
      clothing_owned <- NULL
      footwear_owned <- NULL
      jewelry_owned <- NULL
      
      if (!is.null(clothing_match)) {
        
        clothing_type <- clothing_match$ItemName[1]
        colour <- clothing_match$Colour[1]
        material <- clothing_match$Material[1]
        clothing_owned <- clothing_match$ItemName[1]
      }
      
      if (!is.null(footwear_match)) {
        
        footwear <- footwear_match$ItemName[1]
        footwear_owned <- footwear_match$ItemName[1]
      }
      
      if (!is.null(jewelry_match)) {
        
        jewelry <- jewelry_match$ItemName[1]
        jewelry_owned <- jewelry_match$ItemName[1]
      }
      
      # Rain
      if (
        !is.na(rainfall) &&
        rainfall > 10
      ) {
        
        clothing_type <-
          paste(
            clothing_type,
            "+ carry a raincoat/umbrella"
          )
      }
      
      # Hot weather
      if (
        !is.na(temperature) &&
        temperature >= 33
      ) {
        
        material <-
          paste(
            material,
            "(prefer breathable fabric today - it's hot)"
          )
        
      }
      
      # Cold weather
      else if (
        !is.na(temperature) &&
        temperature <= 20
      ) {
        
        clothing_type <-
          paste(
            clothing_type,
            "+ add a warm layer"
          )
      }
      
      # Recommendation UI
      output$recommendation_ui <-
        renderUI({
          
          tagList(
            
            h4(
              "Today's Recommendation"
            ),
            
            p(
              strong("Location: "),
              area,
              ", ",
              district
            ),
            
            p(
              strong("Weather: "),
              temperature,
              "C, ",
              rainfall,
              "mm rainfall"
            ),
            
            p(
              strong("Occasion: "),
              input$occasion
            ),
            
            p(
              strong("Clothing Type: "),
              clothing_type,
              if (!is.null(clothing_owned))
                " (from your wardrobe)"
              else
                " (generic suggestion - not in your wardrobe)"
            ),
            
            p(
              strong("Colour: "),
              colour
            ),
            
            p(
              strong("Material: "),
              material
            ),
            
            p(
              strong("Footwear: "),
              footwear,
              if (!is.null(footwear_owned))
                " (from your wardrobe)"
              else
                " (generic suggestion - not in your wardrobe)"
            ),
            
            p(
              strong("Jewelry: "),
              jewelry,
              if (!is.null(jewelry_owned))
                " (from your wardrobe)"
              else
                " (generic suggestion - not in your wardrobe)"
            ),
            
            if (nchar(role_note) > 0)
              p(
                em(role_note)
              )
            else
              NULL
          )
        })
      
      # Save history
      new_history <- data.frame(
        
        Username =
          current_user(),
        
        Date =
          as.character(
            input$visit_date
          ),
        
        District =
          district,
        
        Area =
          area,
        
        Occasion =
          input$occasion,
        
        Temperature =
          as.character(
            temperature
          ),
        
        Rainfall =
          as.character(
            rainfall
          ),
        
        ClothingType =
          clothing_type,
        
        Colour =
          colour,
        
        Material =
          material,
        
        Footwear =
          footwear,
        
        Jewelry =
          jewelry,
        
        stringsAsFactors = FALSE
      )
      
      history_data <<-
        rbind(
          history_data,
          new_history
        )
      
      write.csv(
        history_data,
        history_file,
        row.names = FALSE
      )
      
      # History table
      output$history_table <-
        renderTable({
          
          history_data[
            history_data$Username ==
              current_user(),
          ]
        })
    })
}
