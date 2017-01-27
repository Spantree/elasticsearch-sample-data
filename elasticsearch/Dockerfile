FROM elasticsearch:2.4

RUN plugin install cloud-aws \
 && plugin install lmenezes/elasticsearch-kopf

COPY ./config /usr/share/elasticsearch/config
