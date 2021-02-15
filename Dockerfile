FROM kalilinux/kali-bleeding-edge:latest
RUN apt update \
    && apt install sudo git -y \
    && apt install python3 -y \
    && apt install python3-pip -y \
    && python3 -m pip install --user pipx \
    && python3 -m pipx ensurepath \
    && python3 -m pip install git+https://github.com/rung/AutoRecon.git \
    && apt install seclists curl enum4linux gobuster dirb nbtscan nikto \
                   nmap onesixtyone oscanner smbclient smbmap smtp-user-enum \
                   snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf \
                   nfs-common vim iputils-ping net-tools -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
RUN echo "Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/kali/.local/bin"" >> /etc/sudoers
RUN sed -i -e 's/^MinProtocol =.*$/MinProtocol = SSLv3/g' -e 's/DEFAULT@SECLEVEL=[0-9]/DEFAULT@SECLEVEL=0/g' /etc/ssl/openssl.cnf

ENTRYPOINT ["autorecon"]
