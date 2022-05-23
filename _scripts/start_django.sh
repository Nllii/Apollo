echo 'django local server started'
lsof -P | grep ':8000' | awk '{print $2}' | xargs kill -9
python manage.py migrate && python manage.py makemigrations && python manage.py runserver
