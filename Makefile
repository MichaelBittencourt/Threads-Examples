# You can add commends using this character #

#####################Variables########################

#compiler defifition
CC=gcc
CCPP=g++

OTIMIZATION=-O2
DEBUG:=
LD_FLAGS=-W \
		-Werror \
		-Wall \
		-pedantic \
		-lpthread

DEFINES:=

INCLUDES:=

FLAGS:=$(OTIMIZATION) $(DEBUG) $(LD_FLAGS) $(DEFINES) $(INCLUDES)
CC_FLAGS= -std=c99 $(FLAGS)
CPP_FLAGS= -std=c++11 $(FLAGS)
ASSEMBLER_FLAGS= -S -fno-asynchronous-unwind-tables

SRC_FOLDER=src
C_SRC=$(wildcard $(SRC_FOLDER)/*.c)
CPP_SRC=$(wildcard $(SRC_FOLDER)/*.cpp)
HEADERS=$(wildcard $(SRC_FOLDER)/*.h)

#OBJ=$(C_SRC:.c=.o)
OBJ_FOLDER=obj
OBJ=$(subst .c,.o,$(subst $(SRC_FOLDER), $(OBJ_FOLDER),$(C_SRC)))
OBJ_CPP=$(subst .cpp,.o,$(subst $(SRC_FOLDER), $(OBJ_FOLDER),$(CPP_SRC)))
#ASSEMBLY_FILES=$(C_SRC:.c=.s)
ASSEMBLY_FOLDER=assembly
ASSEMBLY_FILES=$(subst .c,.s,$(subst $(SRC_FOLDER), $(ASSEMBLY_FOLDER), $(C_SRC)))

BIN=prog

CPP_BIN=progCpp

cpp_thread: objFolder $(CPP_BIN)

all: objFolder $(BIN)
	@ echo ' '
	@ echo 'Build finish: $(BIN)'

mutex: mutex_setup all

mutex_disable: mutex_disable_setup all

$(CPP_BIN): $(OBJ_CPP)
	@ echo "Test $(OBJ)"
	@ echo "Test $(BIN)"
	@ echo "Test $^"
	$(CCPP) $^ -o $@ $(FLAGS)

$(BIN): $(OBJ)
	@ echo "Test $(OBJ)"
	@ echo "Test $(BIN)"
	@ echo "Test $^"
	$(CC) $(OBJ) -o $@ $(FLAGS)

$(OBJ_FOLDER)/%.o: $(SRC_FOLDER)/%.c $(SRC_FOLDER)/%.h
	$(CC) -c $< -o $@ $(C_FLAGS)

$(OBJ_FOLDER)/%.o: $(SRC_FOLDER)/%.cpp $(SRC_FOLDER)/%.h
	$(CCPP) -c $< -o $@ $(CPP_FLAGS)

$(OBJ_FOLDER)/main.o: $(SRC_FOLDER)/main.c $(HEADERS)
	$(CC) -c $< -o $@ $(C_FLAGS)

$(OBJ_FOLDER)/main2.o: $(SRC_FOLDER)/main2.cpp $(HEADERS)
	$(CCPP) -c $< -o $@ $(CPP_FLAGS)

$(ASSEMBLY_FOLDER)/%.s: $(SRC_FOLDER)/%.c $(SRC_FOLDER)/%.h
	$(CC) -c $< -o $@ $(C_FLAGS)

$(ASSEMBLY_FOLDER)/main.s: $(SRC_FOLDER)/main.c $(HEADERS)
	$(CC) -c $< -o $@ $(C_FLAGS)

assembly: assemblyFolder assembly_setup $(ASSEMBLY_FILES)

assemblyFolder:
	@ mkdir -p $(ASSEMBLY_FOLDER)

objFolder:
	@ mkdir -p $(OBJ_FOLDER)

.PHONY: clean debug debug_setup assembly_setup assembly

no_otimization: no_otimization_setup all

no_otimization_setup:
	$(eval OTIMIZATION=-O0)

debug: debug_setup all

debug_setup:
	$(eval DEBUG=-g3)

assembly_setup:
	$(eval FLAGS=${FLAGS} ${ASSEMBLER_FLAGS})

clean:
	rm -f *~ $(BIN) $(CPP_BIN)
	test -e $(OBJ_FOLDER) && rm -f $(OBJ_FOLDER)/*.o && rmdir $(OBJ_FOLDER) || true
	test -e $(ASSEMBLY_FOLDER) && rm -f $(ASSEMBLY_FOLDER)/*.s && rmdir $(ASSEMBLY_FOLDER) || true

mutex_setup:
	$(eval DEFINES=-DMUTEX_EXAMPLE)

mutex_disable_setup: mutex_setup
	$(eval DEFINES=$(DEFINES) -DDISABLE_MUTEX)
