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

✨ Features
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
👩‍💻 Author
Suprithadevi M




On Fri, Sep 25, 2026 at 10:50 AM Supritha <suprithdevi@gmail.com> wrote:
# Rocket Launch Trajectory Simulator

> An interactive R Shiny application for simulating and analyzing rocket trajectories using projectile-motion equations, gravitational models, and real-world geographic data.

---

## Overview

**Rocket Launch Trajectory Simulator** is an interactive Physics and Mathematics application developed using **R and Shiny**.

The application models the trajectory of a rocket from launch to landing using mathematical equations of projectile motion. Users can select a celestial body, configure launch parameters, visualize the resulting trajectory, and analyze key flight characteristics.

The application also provides a destination-based calculation mode that determines the launch conditions required to reach a selected destination.

An optional step-by-step explanation feature presents the mathematical calculations in a clear and understandable manner, making the application suitable for both simulation and educational purposes.

---

## Key Features

### Multi-Body Simulation

The application supports seven celestial bodies, each with its corresponding gravitational acceleration:

- Earth
- Moon
- Mars
- Mercury
- Venus
- Jupiter
- Saturn

### Real-World Launch Sites

For Earth-based simulations, users can select from real-world launch locations, including:

- Kennedy Space Center
- Baikonur Cosmodrome
- Satish Dhawan Space Centre, Sriharikota
- Guiana Space Centre, Kourou
- Tanegashima Space Center
- Other supported launch locations

### Simulation Modes

The application provides two calculation modes.

#### Speed and Angle Mode

Users provide:

- Celestial body
- Launch location
- Initial velocity
- Launch angle

The simulator calculates:

- Horizontal velocity
- Vertical velocity
- Time to maximum height
- Total flight time
- Maximum altitude
- Horizontal range
- Landing coordinates
- Nearest city

#### Destination Mode

Users specify:

- Starting location
- Destination
- Required calculation parameter

The application uses the geographic distance between the selected locations to determine the required launch conditions, such as initial velocity or launch angle.

### Trajectory Visualization

The simulator generates a trajectory graph representing the rocket's flight path.

The visualization identifies:

- Launch point
- Maximum altitude
- Landing point
- Flight distance

### Landing Location Detection

The calculated landing coordinates are compared against geographic city data to identify the nearest real-world city.

### Step-by-Step Explanations

An optional explanation mode presents the formulas and calculations used by the simulator in a structured, plain-language format.

This helps users understand not only the result, but also how the result was obtained.

---

## Mathematical Model

The simulator is based on standard projectile-motion equations.

### Horizontal Velocity

```text
vx = v₀ × cos(θ)

On Fri, 25 Sep, 2026, 10:47 am SUPRITHADEVI M 25AD102, <25ad102@drngpit.ac.in> wrote:
🚀 Rocket Launch Trajectory Simulator
An interactive R Shiny application that simulates a rocket's flight path using real physics and math formulas — built as a combined Physics + Mathematics mini-project.

📖 Description
This project lets you launch a virtual rocket and watch exactly what happens to it. Pick a real-world launch site on Earth (or another planet/moon), set a speed and angle, and the simulator plots the rocket's entire journey — from liftoff to peak height to landing — on an interactive graph. It also works in reverse: choose a starting point and a destination, and the app calculates the exact speed or angle needed to reach it, using real-world map distances. Every result comes with an optional step-by-step explanation, breaking down the formulas (trigonometry, gravity, motion equations) in plain language, so the user doesn't just see the answer — they understand how it was calculated.

✨ Features
🌍 7 planets/moons to launch from (Earth, Moon, Mars, Mercury, Venus, Jupiter, Saturn) — each with its own gravity value
🚀 Real launch sites on Earth, grouped by country (Kennedy Space Center, Baikonur, Sriharikota, Kourou, Tanegashima, and more)
🎯 Two calculation modes:
Know your speed & angle → find out where you'll land
Know your start & destination → find out the speed/angle needed to get there
📍 Real-world landing lookup — finds the nearest real city to your rocket's landing point
📊 Interactive trajectory graph with peak height and landing point labeled
📘 Step-by-step explanation mode — walks through every formula used, with plain-English reasoning
🧮 Formulas Used
Formula	What it calculates
vx = v0·cos(angle)	Forward speed
vy = v0·sin(angle)	Upward speed
t_peak = vy/g	Time to reach the peak
total_time = 2·t_peak	Total flight time
max_height = vy²/(2g)	Highest point reached
range = vx·total_time	Total distance traveled
range = v0²·sin(2·angle)/g	Used to solve for speed or angle in destination mode
🛠️ Built With
R and Shiny — application framework
Base R graphics — trajectory plotting
maps package — offline city database for real-world landing lookups
📂 Project Structure
RocketLaunchTrajectorySimulator/ ├── Rocket Launch Trajectory Simulator Using R.Rproj ├── global.R # Shared data: gravity values, launch sites, coordinates, formulas ├── ui.R # App layout and pages ├── server.R # App logic, calculations, and page navigation └── www/ └── styles.css # App styling

▶️ How to Run
Open Rocket Launch Trajectory Simulator Using R.Rproj in RStudio
Install required packages (one-time): install.packages(c("shiny", "maps"))
Open ui.R, server.R, or global.R
Click Run App
👩‍💻 Author
Suprithadevi M




On Fri, Sep 25, 2026 at 10:44 AM Supritha <suprithdevi@gmail.com> wrote:
# SUPRITHADEVI M

### Aspiring Web Developer | Front-End Development | Accessible Web Design

A modern, responsive, and accessibility-focused personal portfolio website designed to showcase my technical skills, projects, and professional interests.

---

## Overview

This portfolio represents my journey in web development and my interest in creating clean, responsive, accessible, and user-friendly digital experiences.

The website has been developed using semantic HTML5 and modern CSS3 principles, with particular attention to accessibility, responsive design, usability, and visual consistency.

---

## Key Highlights

- Professional Royal Navy Blue visual identity
- Semantic HTML5 structure
- Responsive and mobile-friendly layouts
- Accessibility-focused development
- Keyboard-friendly navigation
- Skip-to-content functionality
- Accessible contact form
- Clear heading hierarchy
- SEO-friendly page structure
- Consistent typography and spacing
- Responsive project card layout
- Visible keyboard focus indicators
- Reduced-motion support

---

## Website Structure

The portfolio consists of four primary pages:

| Page | Description |
|------|-------------|
| **Home** | Introduction, professional focus, and key skills |
| **About** | Background, technical interests, skills, and career goals |
| **Projects** | Selected web development projects and technologies |
| **Contact** | Accessible contact form for professional communication |

---

## Technologies

- **HTML5** — Semantic structure and accessible markup
- **CSS3** — Styling, responsive layouts, and visual design
- **Responsive Web Design** — Adaptation across devices
- **Web Accessibility** — Keyboard navigation and accessible interaction
- **SEO Fundamentals** — Page titles and descriptive metadata

---

## Accessibility

Accessibility is an integral part of the website's development.

The portfolio incorporates:

- Semantic HTML elements
- Descriptive navigation
- Logical heading hierarchy
- Skip navigation functionality
- Keyboard-accessible controls
- Visible focus states
- Properly associated form labels
- Required form fields
- Responsive layouts
- Reduced-motion considerations

The objective is to provide a clear, consistent, and usable experience across different devices and interaction methods.

---

## Responsive Design

The website is designed to provide a consistent experience across:

- Desktop
- Laptop
- Tablet
- Mobile devices

Responsive CSS techniques and media queries are used to adapt navigation, typography, project cards, forms, and page spacing to different screen sizes.

---

## Project Structure

```text
portfolio/
│
├── index.html
├── about.html
├── projects.html
├── contact.html
├── README.md
│
├── css/
│   └── style.css
│
└── images/
