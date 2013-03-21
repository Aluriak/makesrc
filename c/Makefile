CC=gcc
FLAGS=-Wall -Werror
FINALNAME=a.out

#################################
# ALL				#
#################################
all: compile linking


#################################
# LINKING AND COMPILE		#
#################################
linking: 
	$(CC) $(FLAGS) *.o -o $(FINALNAME)
compile: main.o








#################################
# MAIN				#
#################################
main.o:	main.c main.h
	$(CC) $(FLAGS) -c main.c








#################################
# CLEAN AND CLEAR		#
#################################
clean:
	rm *.o

clear: clean
	rm $(FINALNAME)



