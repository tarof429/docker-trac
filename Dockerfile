FROM debian:stable

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    trac \
    trac-accountmanager \
    trac-codecomments \
    trac-customfieldadmin \
    trac-mastertickets \
    trac-navadd \
    trac-tags \
    trac-email2trac \
    trac-xmlrpc \
    git-core \
    mercurial \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

COPY ./trac /trac

EXPOSE 80

ENTRYPOINT ["/usr/bin/tracd"]
CMD ["-p", "80", "-e", "/trac/projects", "--basic-auth=*,/trac/.htpasswd,Restricted"]
