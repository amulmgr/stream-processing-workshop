#!/bin/bash

echo "creating Confluent S3 Sink Connector"

curl -X "POST" "$DOCKER_HOST_IP:8083/connectors" \
     -H "Content-Type: application/json" \
     --data '{
  "name": "s3-confluent-sink",
  "config": {
      "connector.class": "io.confluent.connect.s3.S3SinkConnector",
      "partition.duration.ms": "3600000",
      "flush.size": "100",
      "topics": "truck_position",
      "tasks.max": "1",
      "timezone": "UTC",
      "locale": "en",
      "format.class": "io.confluent.connect.s3.format.bytearray.ByteArrayFormat",
      "partitioner.class": "io.confluent.connect.storage.partitioner.TimeBasedPartitioner",
      "storage.class": "io.confluent.connect.s3.storage.S3Storage",
      "s3.region": "us-central-1",
      "s3.bucket.name": "gschmutz-kafka-confluent-1",
      "s3.part.size": "5242880",
      "store.url": "http://minio:9000",
      "key.converter": "org.apache.kafka.connect.converters.LongConverter",
      "value.converter": "org.apache.kafka.connect.converters.StringConverter",
      "path.format": "'date'=YYYY-MM-dd/'hour'=HH",
      "timestamp.extractor": "Record"
  }
}'