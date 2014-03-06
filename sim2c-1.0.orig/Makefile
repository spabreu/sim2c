SIMFILES=$(wildcard *.sm)
CFILES=$(subst .sm,.c,$(SIMFILES))
OFILES=$(subst .sm,.o,$(SIMFILES))
EXES=$(subst .sm,,$(SIMFILES))

all: $(EXES)

clean:
	rm -f $(CFILES) $(OFILES) $(EXES) *~ \#*

%: %.o
	gcc -g -o $@ $<

%.o: %.c
	gcc -g -c $<

%.c: %.sm
	sim2c < $< > $@
