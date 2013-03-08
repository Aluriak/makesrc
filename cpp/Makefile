CC=g++
FLAGS=-Wall -Werror -std=c++11
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
main.o:	main.cpp main.h
	$(CC) $(FLAGS) -c src/main.cpp








#################################
# CLEAN AND CLEAR		#
#################################
clean:
	rm *.o

clear: clean
	rm $(FINALNAME)



