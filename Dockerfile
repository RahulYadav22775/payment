FROM python:3.9.18-alpine3.19
EXPOSE 8080
RUN mkdir /opt/payment
WORKDIR /opt/payment
RUN  addgroup -S roboshop && adduser -S roboshop -G roboshop && \
     chown -R roboshop:roboshop /opt/shipping
RUN apk add python3-dev build-base linux-headers pcre-dev
USER roboshop
COPY *.py /opt/payment/
COPY requirements.txt /opt/payment/
COPY payment.ini /opt/payment/
RUN pip install -r requirements.txt
CMD ["uwsgi", "--ini", "payment.ini"]
