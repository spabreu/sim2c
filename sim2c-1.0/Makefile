PROG=sim2c
M4FILES=$(wildcard *.m4)

SIMFILES=$(wildcard *.sm)
CFILES=$(subst .sm,.c,$(SIMFILES))
OFILES=$(subst .sm,.o,$(SIMFILES))
EXES=$(subst .sm,,$(SIMFILES))

all:

install:
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)/usr/share/$(PROG)
	mkdir -p $(DESTDIR)/usr/share/doc/$(PROG)/examples
	install -c -m 755 $(PROG) $(DESTDIR)/usr/bin
	install -c -m 444 $(M4FILES) $(DESTDIR)/usr/share/$(PROG)
	install -c -m 444 $(SIMFILES) $(DESTDIR)/usr/share/doc/$(PROG)/examples

test: $(EXES)

clean:
	rm -f $(CFILES) $(OFILES) $(EXES) *~ \#*

%: %.o
	gcc -m32 -g -o $@ $<

%.o: %.c
	gcc -m32 -g -c $<

%.c: %.sm
	sim2c < $< > $@
