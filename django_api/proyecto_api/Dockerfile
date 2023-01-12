FROM python:3.10.8

ENV PYTHONUNBUFFERED=1

RUN mkdir proyecto_api

WORKDIR /proyecto_api

ADD . /proyecto_api

RUN ./setup.sh

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 80