ARG IMAGEVER=1.2.6
FROM golang:1.14 as builder

WORKDIR $GOPATH/src/kafka_exporter

COPY . .

RUN go get -d -v

RUN go install

FROM oraclelinux:7
ENV KAFKA_EXPORTER_HOME /opt/kafka-exporter

RUN mkdir $KAFKA_EXPORTER_HOME
COPY ./kafka_exporter_run.sh $KAFKA_EXPORTER_HOME
RUN chmod +x $KAFKA_EXPORTER_HOME/kafka_exporter_run.sh
COPY --from=builder /go/bin/kafka_exporter $KAFKA_EXPORTER_HOME