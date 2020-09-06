# FROM nginx:latest as nginx
# RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
#     echo "Europe/Moscow" > /etc/timezone
# COPY nginx.conf /etc/nginx/nginx.conf

FROM debian:buster-slim as logger
COPY logger ./
CMD ["./logger"]

FROM elasticsearch:7.9.1 as elasticsearch

FROM grafana/grafana:latest as grafana
USER root
RUN chown -R root:root /etc/grafana && \
    chmod -R a+r /etc/grafana && \
    chown -R grafana:grafana /var/lib/grafana && \
    chown -R grafana:grafana /usr/share/grafana
