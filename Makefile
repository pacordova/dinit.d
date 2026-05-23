sysconfdir = /etc

RSYNC  = rsync -cd --ignore-non-existing
RSYNC += --backup --suffix=.orig

install:
	mkdir -p $(sysconfdir)/dinit.d/boot.d
	mkdir -p $(sysconfdir)/dinit.d 
	cp -f meta/*       $(sysconfdir)/dinit.d
	cp -f targets/*    $(sysconfdir)/dinit.d
	cp -f services/*   $(sysconfdir)/dinit.d
	cp -f etc/rc.local $(sysconfdir)/rc.local

uninstall:
	rm -f  $(sysconfdir)/rc.local
	rm -fr $(sysconfdir)/dinit.d

copy:
	$(RSYNC) $(sysconfdir)/dinit.d/ meta/
	$(RSYNC) $(sysconfdir)/dinit.d/ targets/
	$(RSYNC) $(sysconfdir)/dinit.d/ services/
	$(RSYNC) $(sysconfdir)/rc.local etc/

clean:
	find . -name \*~ -delete
	find . -name \*.orig -delete
