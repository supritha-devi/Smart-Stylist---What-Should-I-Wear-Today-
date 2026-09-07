# 👗 Smart Stylist — "What Should I Wear Today"

An R Shiny web application that recommends outfits based on weather, occasion, and — most importantly — your own wardrobe.

## 📖 Description

Deciding what to wear means juggling the day's weather, how formal or festive the occasion is, and any dress-code expectations tied to your role (student or working professional). Most outfit-suggestion tools give generic advice regardless of what you actually own, so the suggestion often can't be worn as-is.

Smart Stylist solves this by personalizing recommendations to your own wardrobe whenever possible, and falling back to a sensible generic suggestion only when nothing suitable is available.

The app walks you through a themed splash screen, a one-time gender selection (which switches the app's visual theme), login/sign-up, a one-time profile setup (district, area, and role or student type), and a one-time wardrobe entry step — all editable afterwards. For each day, you pick an occasion and a date; the app looks up local weather and the occasion's typical outfit, applies any role/student dress-code override, adjusts for hot weather or rain, and then checks your own wardrobe for a matching item. When a match is found, that item's actual colour and material become the recommendation instead of a generic placeholder.

## ✨ Features

- 🎬 Splash screen that auto-advances after 5 seconds
- 🎨 Gender-based theme switching (pink / blue) that persists for the session
- 🔐 Login / sign-up with persistent user records
- 👤 One-time, editable profile setup (district, area, role or student type)
- 👕 One-time, editable wardrobe entry (clothing, footwear, jewelry)
- 🌦️ Weather and occasion based outfit lookup
- 🎓 Role/student dress-code overrides (e.g. uniform requirements)
- 🧥 Wardrobe-aware matching — recommends your own item and its actual colour/material when one fits
- 📜 Persistent, per-user recommendation history

## 🛠️ Tech Stack

- **Language:** R
- **Framework:** Shiny (R Shiny web application)
- **Timing:** `later` package (splash-screen auto-advance)
- **Client/Server messaging:** Shiny custom message handlers (`session$sendCustomMessage`)
- **Data storage:** CSV files (persistent user, wardrobe, and history records)
- **Styling:** Custom CSS (`style.css`)
- **IDE:** RStudio
- **Version Control / Hosting:** Git and GitHub

## 📊 Dataset

The app reads five reference CSVs at startup and maintains three persistent CSVs that grow as people use the app:

**Reference data:**
- `weather.csv` — district/area temperature and rainfall reference data
- `occasion_rules.csv` — typical clothing type, colour, and material per occasion
- `locations.csv` — list of districts and areas available for profile setup
- `role_rules.csv` — dress-code rules for working professionals by role
- `student_rules.csv` — dress-code norms for different student types

**Persistent data:**
- `users.csv` — each user's login, gender, and profile details
- `wardrobe.csv` — each user's own clothing, footwear, and jewelry items
- `history.csv` — every recommendation ever generated, per user

## ▶️ How to Run

1. Open the project folder in RStudio
2. Install required packages (one-time): `install.packages(c("shiny", "later"))`
3. Open `app.R` (or `ui.R`/`server.R`)
4. Click **Run App**

## 👩‍💻 Author

Suprithadevi M
