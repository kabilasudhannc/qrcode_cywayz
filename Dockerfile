# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/
FROM ubuntu
WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

RUN apt-get update
#RUN apt-get install -y knockpy
RUN apt-get -y install python3-pip
RUN apt-get install python3-dev libmysqlclient-dev -y
RUN pip install -U pip

COPY requirements.txt ./
RUN python3 -m pip install -r requirements.txt

# Switch to the non-privileged user to run the application.

# Copy the source code into the container.
COPY . .

# Expose the port that the application listens on.
EXPOSE 4000

# Run the application.
CMD python3 main.py
