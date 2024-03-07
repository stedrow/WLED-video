FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt /app

# Update base debian packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libgl1-mesa-glx libglib2.0-0 && \
    python -m pip install --no-cache-dir --upgrade pip && \
    python -m pip install --no-cache-dir -r /app/requirements.txt && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy app content into the container at /app
COPY wledvideo.py /app
COPY wledvideo.spec /app
COPY ./src /app/src

# CMD [ "/usr/local/bin/python", "/app/detect.py" ]
