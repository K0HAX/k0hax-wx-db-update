FROM alpine
RUN apk add --no-cache mysql-client wget dcron unzip ca-certificates bash
RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d

ADD parse-wx.sh /parse-wx.sh
ADD run.sh /run.sh
ADD entrypoint.sh /entrypoint.sh
RUN chmod 0755 parse-wx.sh run.sh entrypoint.sh
ADD crontab /etc/cron.d/wx-cron
RUN chmod 0644 /etc/cron.d/wx-cron
RUN touch /var/log/cron.log
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]

