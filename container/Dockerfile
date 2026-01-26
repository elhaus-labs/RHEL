FROM registry.access.redhat.com/ubi9/ubi

RUN dnf -y --allowerasing --setopt=install_weak_deps=False --setopt=tsflags=nodocs install \
      bash \
      openssh-server \
      openssh-clients \
      sudo \
      systemd \
      systemd-udev \
      shadow-utils \
    && dnf clean all \
    && rm -rf /var/cache/dnf

RUN useradd -m -s /bin/bash lab \
    && echo 'lab:lab' | chpasswd \
    && echo 'root:root' | chpasswd

RUN echo 'lab ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/lab \
    && chmod 0440 /etc/sudoers.d/lab

ENV container docker

COPY bash/.bashrc /home/lab/.bashrc
COPY bash/.bashrc /root/.bashrc
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /etc/systemd/system/multi-user.target.wants \
    && chmod 600 /home/lab/.bashrc /root/.bashrc \
    && chown -R lab:lab /home/lab/.bashrc \
    && ssh-keygen -A \
    && sed -i 's/^#\\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#\\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#\\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && grep -q '^PasswordAuthentication' /etc/ssh/sshd_config || echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config \
    && grep -q '^PubkeyAuthentication' /etc/ssh/sshd_config || echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config \
    && grep -q '^PermitRootLogin' /etc/ssh/sshd_config || echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && ln -sf /usr/lib/systemd/system/sshd.service /etc/systemd/system/multi-user.target.wants/sshd.service \
    && ln -sf /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/sbin/init"]
