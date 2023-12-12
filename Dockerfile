#Grab the latest alpine image
FROM alpine:latest

# Install python and pip
RUN apk add --no-cache --update python3 py3-pip bash

RUN adduser -D fahd
USER fahd
WORKDIR /home/fahd

# Install dependencies

COPY --chown=fahd: ./webapp/requirements.txt requirements.txt
RUN pip install --user -r requirements.txt
# Add our code
ADD ./webapp /home/fahd/

# Expose is NOT supported by Heroku
# EXPOSE 5000 		


# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:$PORT wsgi 

