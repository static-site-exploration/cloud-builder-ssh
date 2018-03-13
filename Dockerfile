FROM gcr.io/cloud-builders/gsutil

RUN set -e \

  # Install libraries
  && apt-get update \
  && apt-get -y install expect \

  # Cleanup
  && apt-get clean \
  && rm -rf \
          /var/lib/apt/lists/* \
          /var/tmp/* \
          /tmp/*
          
ADD ssh-copy-id.expect /ssh-copy-id.expect
RUN chmod +x /ssh-copy-id.expect

ADD setup-ssh.bash /setup-ssh.bash
RUN chmod +x /setup-ssh.bash

ENTRYPOINT ["/setup-ssh.bash"]
