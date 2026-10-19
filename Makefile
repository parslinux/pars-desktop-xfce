# ==============================================================================
# ParsLinux Desktop XFCE (pars-desktop-xfce) — Makefile
# ==============================================================================

DESTDIR ?=
PREFIX ?= /usr
SYSCONFDIR ?= /etc

all:
	@echo "pars-desktop-xfce: Derleme gerektiren ikili dosya yok (Meta paket)."

install:
	# XFCE Xfconf Varsayılan Yapılandırma Dosyaları (Whisker Menü, Temalar, Duvar Kağıdı)
	install -d $(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml
	install -m 644 etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml \
		$(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
	install -m 644 etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml \
		$(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
	install -m 644 etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml \
		$(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
	install -m 644 etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml \
		$(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

uninstall:
	rm -f $(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
	rm -f $(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
	rm -f $(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
	rm -f $(DESTDIR)$(SYSCONFDIR)/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

clean:
	rm -rf build debian/.debhelper debian/pars-desktop-xfce debian/files debian/*.substvars debian/*.debhelper.log

.PHONY: all install uninstall clean
