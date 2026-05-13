# install to libdir by default
sysconfdir = /etc
libdir = /lib64

RSYNC  = rsync -cd --ignore-non-existing
RSYNC += --backup --suffix=.orig

install:
#	mkdir -p $(sysconfdir)/dinit.d/boot.d
	mkdir -p $(libdir)/dinit.d 
	cp -f meta/* $(libdir)/dinit.d
	cp -f targets/* $(libdir)/dinit.d
	cp -f services/* $(libdir)/dinit.d
	cp -f etc/rc.local $(sysconfdir)/rc.local

uninstall:
	rm -f  $(sysconfdir)/rc.local
	rm -fr $(sysconfdir)/dinit.d
	rm -fr $(libdir)/dinit.d

copy:
	$(RSYNC) $(libdir)/dinit.d/     meta/
	$(RSYNC) $(libdir)/dinit.d/     targets/
	$(RSYNC) $(libdir)/dinit.d/     services/
#	$(RSYNC) $(sysconfdir)/dinit.d/ services/
	$(RSYNC) $(sysconfdir)/rc.local etc/

clean:
	find . -name \*~ -delete
	find . -name \*.orig -delete
