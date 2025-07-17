FROM ubuntu:22.04

RUN apt-get update && apt-get install -y python3 python3-pip
WORKDIR /app
COPY app/requirements.txt .
RUN pip3 install -r requirements.txt
COPY app/ .
EXPOSE 5000
CMD ["python3", "app.py"]

