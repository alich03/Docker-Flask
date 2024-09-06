FROM ubuntu:20.04



RUN apt update && apt install software-properties-common -y
RUN apt install python3 -y && apt install python3-pip -y 

RUN pip install numpy pandas matplotlib seaborn flask

RUN pip install flask_cors

WORKDIR test_app

COPY . .

ENV FLASK_RUN_HOST=0.0.0.0

RUN apt install software-properties-common 

EXPOSE 5000

# CMD ["python3","app.py"]


# WORKDIR

# ENV 

# COPY

# ADD