sysconfdir = /etc

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

snarf:
	find $(sysconfdir)/dinit.d -type f -exec cp -f {} ./services \;
	cp -f $(sysconfdir)/rc.local ./etc
	mv -f ./services/agetty ./services/modprobe ./services/mount ./meta
	mv -f ./services/*.target ./targets

clean:
	find . -name \*~ -delete
	find . -name \*.orig -delete
