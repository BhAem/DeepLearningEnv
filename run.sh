#! /usr/bin/bash
ROOT_PASSWD="123456"
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && echo "root:${ROOT_PASSWD}" | chpasswd \
    && /usr/sbin/sshd \
    && echo "111111" \
    && /usr/bin/tail -f /dev/null