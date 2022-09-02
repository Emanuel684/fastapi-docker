FROM ubuntu:20.04 as builder

WORKDIR /usr/src/

RUN apt update

RUN apt install -y git

RUN git clone https://github.com/Emanuel684/fastApi-learn.git

RUN cd fastApi-learn/

FROM python:3.9

#
WORKDIR /code

#
COPY --from=builder ["./usr/src/fastApi-learn/requeriments.txt", "/code/requeriments.txt"]

#
RUN pip install --no-cache-dir --upgrade -r /code/requeriments.txt pip install pytz

#
COPY --from=builder ["./usr/src/fastApi-learn/app", "/code/app"]

#
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]