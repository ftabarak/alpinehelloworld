#Grab the latest alpine images
FROM python:3.13.0a2-alpine

#Install python and pip
ADD ./webapp/requirements.txt requirements.txt

#Install dependencies
RUN pip3 install --no-cache-dir -q -r requirements.txt

#Add our code
ADD ./webapp /home/fahd/
WORKDIR /home/fahd

#Expose is NOT supported by Heroku
EXPOSE 5000

#Run the image as a non-root user
RUN adduser -D fahd
USER fahd

#Run the app. CMD is required to run on Heroku
CMD ["gunicorn", "--bind", "0000:5000", "wsgi"]
