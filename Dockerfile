FROM gentoo/portage:latest as portage

FROM gentoo/stage3:latest

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN eselect news read &> /dev/null && \
    emerge app-editors/vim \
           net-misc/dhcpcd \
	   sys-kernel/gentoo-kernel-bin \
    && rm -rf /var/db/repos/gentoo

