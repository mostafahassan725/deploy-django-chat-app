#!/bin/bash

# Run tailwindcss to generate CSS file
npx tailwindcss -i ./static/src/tailwind.css -o ./static/src/style.css

# Run Django development server
python3 manage.py runserver 0.0.0.0:8000