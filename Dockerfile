ARG ARCH=
FROM ${ARCH}alpine:3


ARG USER_ID=1000
ARG GROUP_ID=1000

LABEL Description="vsftpd Docker image based on Alpine 3. Supports passive mode and virtual users." \
	License="MIT" \
	Usage="docker run -d -p [HOST PORT NUMBER]:21 -v [HOST FTP HOME]:/home/vsftpd enricoferro/vsftpd" \
	Version="1.0"

RUN apk add --no-cache  vsftpd bash db db-utils


ENV FTP_USER **String**
ENV FTP_PASS **Random**
ENV PASV_ADDRESS **IPv4**
ENV PASV_ADDR_RESOLVE NO
ENV PASV_ENABLE YES
ENV PASV_MIN_PORT 21100
ENV PASV_MAX_PORT 21110
ENV XFERLOG_STD_FORMAT NO
ENV LOG_STDOUT **Boolean**
ENV FILE_OPEN_MODE 0666
ENV LOCAL_UMASK 077
ENV REVERSE_LOOKUP_ENABLE YES
ENV PASV_PROMISCUOUS NO
ENV PORT_PROMISCUOUS NO

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/

RUN chmod +x /usr/sbin/run-vsftpd.sh
RUN mkdir -p /home/vsftpd/
RUN chown -R ftp:ftp /home/vsftpd/

VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

EXPOSE 20 21

CMD ["/usr/sbin/run-vsftpd.sh"]
