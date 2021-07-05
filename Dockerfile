FROM archlinux:latest
# directory containing source files with respect to dockerfile
ARG SRCDIR="."
# directory where the source will exist in the dockerfile
ARG PKGDIR="/latex-src"
# entry point to program
ARG ENTRYPOINT="${PKGDIR}/build.sh"
# set working directory for entrypoint in case it requires a different context
ARG WORKDIR=${PKGDIR}
# username for user
ARG USR=archie

# resetting all gnupg keys
RUN rm -rf /etc/pacman.d/gnupg && \
    pacman-key --init && \
    pacman-key --populate archlinux
# prepare pacman for use and generic dependencies
RUN pacman -Syyuu --noconfirm \
    archlinux-keyring \
    ca-certificates
# install specific dependencies we need
RUN pacman -S --noconfirm \
    biber \
    texlive-most \
    minted \
    which
# symlink biber from its strange path in /usr/bin/vendor_perl/biber to /usr/bin
RUN ln -s /usr/bin/vendor_perl/biber /usr/bin/biber

# copy all our files into the container ignoring .dockerignore'd files
COPY ${SRCDIR} ${PKGDIR}
# setting workdir to the src dir
WORKDIR ${WORKDIR}
# creating standard user to interact with files and creating an entrypoint
RUN useradd ${USR} && \
    chown -R  ${USR}:${USR} ${PKGDIR} && \
    chmod 744 ${ENTRYPOINT} && \
    echo "(cd ${WORKDIR}; ${ENTRYPOINT})" > /docker-entrypoint && \
    chown ${USR}:${USR} /docker-entrypoint && \
    chmod 744 /docker-entrypoint
USER ${USR}

ENTRYPOINT /docker-entrypoint
