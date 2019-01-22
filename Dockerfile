# Download base image python slim
# python image is based uppon debian stable
FROM python:3.5-slim

# Install git
RUN apt-get update
RUN apt-get install -y git-core make --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Install pipenv
RUN pip install pipenv