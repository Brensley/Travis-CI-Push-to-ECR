# location: containers/sample_container/.dockerfile
# Base Image
FROM python:3.7-slim


# DocStr
LABEL environment for test_task
MAINTAINER Brensley Foster

# Installing necessary build requirements
RUN apt-get update
RUN apt-get install build-essential -y

# Installing Python dependency for model env
COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt
RUN rm ./requirements.txt


# Installing AWS CLI and adding path variable
RUN echo 'export PATH=~/.local/bin:$PATH\n' >> $HOME/.bashrc

# Setting AWS Credentials
ARG AWS_KEY
ARG AWS_SECRET_KEY
ENV AWS_ACCESS_KEY_ID=${AWS_KEY}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_KEY}

# COPY folder of code and model
COPY .dockerfile /usr/code

# Set working_directory
WORKDIR /usr/code

# Code for the model scoring
CMD python3 sample.py