PROG = sspl

OBJECTS = parser.o scanner.o aux.o
LIBS    = -ll

CFLAGS  =
YFLAGS  = -v -d

LEX = flex
YACC = bison -y

all: $(PROG)

$(PROG): $(OBJECTS)
	cc $(CFLAGS) -o $(PROG) $(OBJECTS) $(LIBS)

tokenize: tokenize.o scanner.o
	cc -o tokenize tokenize.o scanner.o aux.o $(LIBS)
