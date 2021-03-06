FROM dsyer/eduk8s-initializr-test:latest as initializr

FROM quay.io/eduk8s/jdk11-environment:master

COPY --from=initializr --chown=1001:0 /opt/. /opt/.
COPY --chown=1001:0 initializr/start-initializr /opt/eduk8s/sbin
COPY --chown=1001:0 initializr/initializr.conf /opt/eduk8s/etc/supervisor/

# RUN mkdir -p /home/eduk8s/.local/share/code-server/ && cp -r /opt/extensions /home/eduk8s/.local/share/code-server
COPY --chown=1001:0 . /home/eduk8s/
RUN mv /home/eduk8s/workshop /opt/workshop && rm -rf /home/eduk8s/initializr
RUN fix-permissions /home/eduk8s
