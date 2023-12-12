#Grab the latest alpine image
FROM python:3.13.0a2-alpine

# Install python and pip
RUN apk add --no-cache --update python3 py3-pip bash

RUN adduser -D
USER fahd
WORKDIR /home/fahd

# Install dependencies

COPY --chown=fahd: ./webapp/requirements.txt requirements.txt

RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
ADD ./webapp /home/fahd/

# Expose is NOT supported by Heroku
 EXPOSE 5000 		

# $PORT is set by Heroku			
CMD ["gunicorn", "--bind", "0000:5000", "wsgi"]
