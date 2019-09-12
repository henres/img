FROM  r.j3ss.co/img as img

USER root

RUN apk add --no-cache bash 

USER user

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
