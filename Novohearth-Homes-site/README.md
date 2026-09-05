# Novohearth Homes Website

A modern static website for **Novohearth Homes**, a real estate company. This project is built for practice, so it uses only HTML, CSS, and vanilla JavaScript.

## Overview

The website includes real estate sections that are common in company sites:

- **Hero section**: Brand name, short message, and call-to-action buttons.
- **Featured listings**: Property cards with images, prices, locations, and details.
- **Services**: Buying, selling, and investment support.
- **About section**: Short company story and client benefits.
- **Testimonials**: Simple client feedback cards.
- **Contact form**: Practice form with basic validation.

## Features

- **Responsive design**: Works on desktop, tablet, and mobile screens.
- **Mobile navigation**: The menu becomes a hamburger button on smaller screens.
- **Smooth scrolling**: Navigation links scroll to each section.
- **Contact form validation**: Checks that the user completes required fields.
- **Real estate visual style**: Uses property images, warm colors, and clean spacing.
- **No build tools needed**: Open `index.html` directly in a browser.

## Project Structure

```text
novohearth-homes/
|-- assets/
|   |-- favicon.svg       # Browser tab icon
|   `-- logo.svg          # Novohearth Homes logo
|-- .dockerignore         # Files Docker should ignore
|-- app.js                # Mobile menu and form behavior
|-- dockerfile            # Docker image instructions
|-- index.html            # Main webpage content
|-- nginx.conf            # Optional server config example
|-- styles.css            # Website design and responsive layout
`-- README.md             # Project explanation
```

## How To Use It

1. Open the `novohearth-homes` folder.
2. Double-click `index.html`.
3. The website will open in your browser.
4. Edit the text, colors, listings, or images to practice.

## How To Run With Docker

If Docker is installed, open Git Bash inside this folder and run:

```bash
docker build -t novohearth-homes-site -f dockerfile .
docker run --name novohearth-site -p 8080:80 novohearth-homes-site
```

Then open this address in your browser:

```text
http://localhost:8080
```

To stop the container:

```bash
docker stop novohearth-site
docker rm novohearth-site
```

## What Each File Does

### `index.html`

This is the main webpage. It contains all the visible sections, including the navigation, property listings, services, about area, testimonials, contact form, and footer.

### `styles.css`

This controls the design. You can change colors, spacing, fonts, card layouts, mobile styles, and the hero image here.

### `app.js`

This adds small interactive behavior:

- Opens and closes the mobile menu.
- Closes the menu after a navigation link is clicked.
- Validates the contact form.
- Shows a practice success message after the form is completed.

### `assets/`

This folder stores visual files used by the site, like the logo and favicon.

### `nginx.conf`

This is optional. It is useful if you later want to serve the static site with Nginx, for example in a Docker container or on a web server.

### `dockerfile`

This tells Docker how to package the Novohearth Homes static website using Nginx.

### `.dockerignore`

This keeps unnecessary files out of the Docker image.

## Practice Ideas

- Change the company colors in `styles.css`.
- Replace the property listing details in `index.html`.
- Add a fourth property card.
- Add a new section for neighborhoods.
- Change the form fields.
- Replace the images with your own.

## Notes

This is a static practice project. The contact form does not send messages to a real email address or database. To make the form real, you would need a backend service or form handling tool.
