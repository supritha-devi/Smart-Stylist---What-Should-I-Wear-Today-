#Smart Stylist — What Should I Wear Today

**Smart Stylist** is an R Shiny web application that provides personalized outfit recommendations based on weather, occasion, dress-code requirements, user profile, and — most importantly — the user's own wardrobe.

Instead of providing generic clothing suggestions, the application attempts to identify suitable items that the user already owns. When a matching wardrobe item is found, its actual colour and material are incorporated into the recommendation. If no suitable item is available, the system provides a rule-based generic recommendation.

---

## Overview

Choosing what to wear involves considering several factors at the same time:

- Weather conditions
- Temperature and rainfall
- Location
- Date
- Occasion
- Formality
- Professional dress-code requirements
- Student dress-code requirements
- Personal wardrobe availability
- Clothing colour and material

Smart Stylist combines these factors into a single recommendation workflow.

The application is designed to answer a practical question:

> **What should I wear today, considering the weather, occasion, dress code, and the clothes I actually own?**

---

## Key Features

### Personalized Outfit Recommendations

Generates outfit recommendations based on the user's selected date, occasion, location, profile, and wardrobe.

### Weather-Aware Recommendations

Considers local temperature and rainfall information when generating recommendations.

### Occasion-Based Styling

Uses predefined occasion rules to determine appropriate clothing type, colour, material, and level of formality.

### Professional Dress-Code Rules

Applies role-specific dress-code requirements for working professionals.

### Student Dress-Code Rules

Applies appropriate dress-code rules according to the selected student type.

### Wardrobe-Aware Matching

Searches the user's personal wardrobe for suitable clothing items before generating a generic recommendation.

### Actual Wardrobe Attributes

When a matching item is found, the recommendation can use the item's actual:

- Colour
- Material
- Clothing type
- Category

### Editable Profile

Users can update their district, area, role, student type, and other profile information after initial setup.

### Editable Wardrobe

Users can add, update, or maintain clothing, footwear, and jewelry information.

### Persistent Recommendation History

Generated recommendations are stored per user and can be retained across application sessions.

### Themed Splash Screen

The application begins with a themed splash screen that automatically advances after five seconds.

### Session-Based Visual Theme

The selected gender-based theme is maintained during the current application session.

### Shiny Client-Server Interaction

Custom Shiny message handlers are used for interactive client-side functionality such as theme changes and splash-screen behavior.

---

## Recommendation Process

The application follows a structured recommendation pipeline:

```text
User Profile
     |
     v
Date + Occasion
     |
     v
Location
     |
     v
Weather Lookup
     |
     v
Occasion Rules
     |
     v
Professional / Student Rules
     |
     v
Weather Adjustment
     |
     v
Personal Wardrobe Matching
     |
     +-------------------+
     |                   |
     v                   v
Match Found         No Match Found
     |                   |
     v                   v
User's Actual       Generic Rule-Based
Wardrobe Item       Recommendation
     |                   |
     +---------+---------+
               |
               v
      Final Recommendation
               |
               v
       Recommendation History

On Fri, 25 Sep, 2026, 11:06 am SUPRITHADEVI M 25AD102, <25ad102@drngpit.ac.in> wrote:
👗 Smart Stylist — "What Should I Wear Today"
An R Shiny web application that recommends outfits based on weather, occasion, and — most importantly — your own wardrobe.

📖 Description
Deciding what to wear means juggling the day's weather, how formal or festive the occasion is, and any dress-code expectations tied to your role (student or working professional). Most outfit-suggestion tools give generic advice regardless of what you actually own, so the suggestion often can't be worn as-is.

Smart Stylist solves this by personalizing recommendations to your own wardrobe whenever possible, and falling back to a sensible generic suggestion only when nothing suitable is available.

The app walks you through a themed splash screen, a one-time gender selection (which switches the app's visual theme), login/sign-up, a one-time profile setup (district, area, and role or student type), and a one-time wardrobe entry step — all editable afterwards. For each day, you pick an occasion and a date; the app looks up local weather and the occasion's typical outfit, applies any role/student dress-code override, adjusts for hot weather or rain, and then checks your own wardrobe for a matching item. When a match is found, that item's actual colour and material become the recommendation instead of a generic placeholder.

 Features
- Splash screen that auto-advances after 5 seconds
- Gender-based theme switching (pink / blue) that persists for the session
- Login / sign-up with persistent user records
- One-time, editable profile setup (district, area, role or student type)
- One-time, editable wardrobe entry (clothing, footwear, jewelry)
- Weather and occasion based outfit lookup
- Role/student dress-code overrides (e.g. uniform requirements)
- Wardrobe-aware matching — recommends your own item and its actual colour/material when one fits
- Persistent, per-user recommendation history
- Tech Stack

Language: R
Framework: Shiny (R Shiny web application)
Timing: later package (splash-screen auto-advance)
Client/Server messaging: Shiny custom message handlers (session$sendCustomMessage)
Data storage: CSV files (persistent user, wardrobe, and history records)
Styling: Custom CSS (style.css)
IDE: RStudio
Version Control / Hosting: Git and GitHub

📊 Dataset

The app reads five reference CSVs at startup and maintains three persistent CSVs that grow as people use the app:

Reference data:

weather.csv — district/area temperature and rainfall reference data
occasion_rules.csv — typical clothing type, colour, and material per occasion
locations.csv — list of districts and areas available for profile setup
role_rules.csv — dress-code rules for working professionals by role
student_rules.csv — dress-code norms for different student types

Persistent data:

users.csv — each user's login, gender, and profile details
wardrobe.csv — each user's own clothing, footwear, and jewelry items
history.csv — every recommendation ever generated, per user

▶️ How to Run
Open the project folder in RStudio
Install required packages (one-time): install.packages(c("shiny", "later"))
Open app.R (or ui.R/server.R)
Click Run App

Author
Suprithadevi M



