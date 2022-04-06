ARG VERSION=5.1.3
FROM phpmyadmin:$VERSION

# fix for cloud run
RUN sed -i 's/\(tr -dc [^ ]*\) < \([^ ]*\)/head -c 10000 \2 | \1/' /docker-entrypoint.sh
