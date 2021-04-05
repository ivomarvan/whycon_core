##################################################################################################################
# Author: ivo@marvan.cz
#
# - compile whycon common library to *.o files
# - link to whycon_core.so
# - install library to linux enviroment
##################################################################################################################

DEBUG_MAKEFILE := 0

ROOT_DIR 	:= $(shell realpath .)
OPENCV_VERSION 	:= opencv4 		# OR opencv
USE_OPENCV_FROM_PYTHON := 0

.PHONY: make_dirs all clean whycon_core_lib install uninstall info

all: make_dirs whycon_core_lib

RESULTS_BIN_DIR	:= $(ROOT_DIR)/bin

# --- common lib --------------------------------------------------------------------------------------------------
LIB_HEADER_DIR	:= $(ROOT_DIR)/src
LIB_CPP_DIR 	:= $(ROOT_DIR)/src
LIB_BUILD_DIR 	:= $(ROOT_DIR)/build
DYNAMIC_LIB 	:= $(RESULTS_BIN_DIR)/whycon_core.so

SYS_INCLUDE_DIR := /usr/include/whycon
SYS_LIB_DIR 	:= /usr/lib/whycon

ifeq ($(USE_OPENCV_FROM_PYTHON),1)
	COMPILE_OPENCV := $(shell python -c 'import pkgconfig; print(pkgconfig.cflags("$(OPENCV_VERSION)"))')
	LINKING_OPENCV := $(shell python -c 'import pkgconfig; print(pkgconfig.libs("$(OPENCV_VERSION)"))')
else
	COMPILE_OPENCV := $(shell pkg-config $(OPENCV_VERSION) --cflags)
	LINKING_OPENCV := $(shell pkg-config $(OPENCV_VERSION) --libs)
endif


LIB_HEADER_FILES:= $(wildcard $(LIB_HEADER_DIR)/*.h) 
LIB_CPP_FILES	:= $(wildcard $(LIB_CPP_DIR)/*.cpp) 
LIB_OBJ_FILES	:= $(patsubst $(LIB_CPP_DIR)/%.cpp, $(LIB_BUILD_DIR)/%.o, $(LIB_CPP_FILES))

# compile params
LIB_CXXFLAGS += -Wall  -fPIC
# use same version of opencv as python
LIB_CXXFLAGS 	+= $(COMPILE_OPENCV)

# linking params
LINK_PARAMS += -O3 -shared -std=gnu++11
LINK_LIBS 	+= $(LINKING_OPENCV)

info:
	$(info    === Variables ====)
	$(info    OPENCV_VERSION 	$(OPENCV_VERSION))
	$(info    COMPILE_OPENCV 	$(COMPILE_OPENCV))
	$(info    LINKING_OPENCV 	$(LINKING_OPENCV))
	$(info    -------------------)
	$(info    LIB_HEADER_DIR 	$(LIB_HEADER_DIR))
	$(info    LIB_CPP_DIR 		$(LIB_CPP_DIR))
	$(info    LIB_BUILD_DIR 	$(LIB_BUILD_DIR))
	$(info    LIB_HEADER_FILES 	$(LIB_HEADER_FILES))
	$(info    LIB_CPP_FILES 	$(LIB_CPP_FILES))
	$(info    LIB_OBJ_FILES 	$(LIB_OBJ_FILES))
	$(info    LIB_CXXFLAGS 		$(LIB_CXXFLAGS))
	$(info    DYNAMIC_LIB 		$(DYNAMIC_LIB))
	$(info    SYS_INCLUDE_DIR 	$(SYS_INCLUDE_DIR))
	$(info    SYS_LIB_DIR 		$(SYS_LIB_DIR))
	$(info    ================== )


whycon_core_lib: $(DYNAMIC_LIB)

# compile C++ from whycon_core_lib
$(LIB_BUILD_DIR)/%.o: $(LIB_CPP_DIR)/%.cpp $(LIB_HEADER_FILES)
	$(CXX) -I$(LIB_HEADER_DIR) $(LIB_CXXFLAGS) -o $@ -c $<

# linking to dynamic library
$(DYNAMIC_LIB): $(LIB_OBJ_FILES)
	$(CXX) $(LINK_PARAMS) -o $(DYNAMIC_LIB)  $(LIB_OBJ_FILES) $(LINK_LIBS)
	@echo "*******************************************************************"
	@echo "$(shell realpath $(DYNAMIC_LIB)) was linked."
	@echo "*******************************************************************"


# --- all ----------------------------------------------------------------------------------------------------------
make_dirs:
	@mkdir -p $(LIB_BUILD_DIR) $(RESULTS_BIN_DIR)
	
clean:
	rm -rf $(LIB_BUILD_DIR) $(RESULTS_BIN_DIR)

install: $(DYNAMIC_LIB)		# need sudo
	mkdir -p $(SYS_INCLUDE_DIR)
	mkdir -p $(SYS_LIB_DIR)
	cp $(DYNAMIC_LIB) $(SYS_LIB_DIR)
	cp $(LIB_HEADER_DIR)/*.h $(SYS_INCLUDE_DIR)
	ldconfig

uninstall:
	rm -rf  $(SYS_INCLUDE_DIR)
	rm -rf  $(SYS_INCLUDE_DIR)
	
