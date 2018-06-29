FROM ubuntu:16.04

ENV PATH /usr/local/lsws/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget

RUN cd /root && wget -c http://rpms.litespeedtech.com/debian/enable_lst_debain_repo.sh && chmod +x enable_lst_debain_repo.sh && chmod +x enable_lst_debain_repo.sh && bash enable_lst_debain_repo.sh

RUN apt-get install -y openlitespeed

RUN apt-get install -y --no-install-recommends lsphp72 lsphp72-common lsphp72-mysql lsphp72-imap lsphp72-dev lsphp72-curl lsphp72-dbg

RUN rm -rf /usr/local/lsws/conf/httpd_config.conf /usr/local/lsws/lsphp72/etc/php/7.2/litespeed/php.ini /var/lib/apt/lists/* ./enable_lst_debain_repo.sh && apt-get remove --purge -y wget

COPY ./httpd_config.conf /usr/local/lsws/conf/
COPY ./php.ini /usr/local/lsws/lsphp72/etc/php/7.2/litespeed/

VOLUME ["/usr/local/lsws/conf", "/usr/local/lsws/Example"]

EXPOSE 80
EXPOSE 7080

ENTRYPOINT ["openlitespeed", "-n"]
