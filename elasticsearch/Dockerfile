FROM elasticsearch:2.4-alpine

RUN /usr/share/elasticsearch/bin/plugin install --batch analysis-icu
RUN /usr/share/elasticsearch/bin/plugin install --batch analysis-kuromoji
RUN /usr/share/elasticsearch/bin/plugin install --batch analysis-smartcn
RUN /usr/share/elasticsearch/bin/plugin install --batch analysis-stempel

COPY ./resources/ /usr/share/elasticsearch/

USER elasticsearch

CMD ["elasticsearch"]
