##################################################################################################################
# Author: ivo@marvan.cz
#
# - compile whycon common library to *.o files
# - link to whycon_core.so
# - install library to linux enviroment
#
# Some params (like DEBUG_MAKEFILE, OPENCV_CXXFLAGS, OPENCV_LIBS, OPENCV_VERSION) can be set fom environment.
#	(make OPENCV_CXXFLAGS=..., OPENCV_LIBS=...)
##################################################################################################################

DEBUG_MAKEFILE := 0

ROOT_DIR 	:= $(shell realpath .)
OPENCV_NAME 	:= opencv 	# opencv4 OR opencv
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
	OPENCV_CXXFLAGS := $(shell python -c 'import pkgconfig; print(pkgconfig.cflags("$(OPENCV_NAME)"))')
	OPENCV_LIBS := $(shell python -c 'import pkgconfig; print(pkgconfig.libs("$(OPENCV_NAME)"))')
else
	OPENCV_CXXFLAGS := $(shell pkg-config $(OPENCV_NAME) --cflags)
	OPENCV_LIBS := $(shell pkg-config $(OPENCV_NAME) --libs)
endif


LIB_HEADER_FILES:= $(wildcard $(LIB_HEADER_DIR)/*.h) 
LIB_CPP_FILES	:= $(wildcard $(LIB_CPP_DIR)/*.cpp) 
LIB_OBJ_FILES	:= $(patsubst $(LIB_CPP_DIR)/%.cpp, $(LIB_BUILD_DIR)/%.o, $(LIB_CPP_FILES))

# compile params
LIB_CXXFLAGS += -Wall  -fPIC
# use same version of opencv as python
LIB_CXXFLAGS 	+= $(OPENCV_CXXFLAGS)

# linking params
LINK_PARAMS += -O3 -shared -std=gnu++11
LINK_LIBS 	+= $(OPENCV_LIBS)

info:
	$(info    )
	$(info    === Variables === $(ROOT_DIR) ===)
	$(info    OPENCV_NAME 			$(OPENCV_NAME))
	$(info    OPENCV_VERSION 		$(OPENCV_VERSION))

	$(info    OPENCV_CXXFLAGS 	$(OPENCV_CXXFLAGS))
	$(info    OPENCV_LIBS 		$(OPENCV_LIBS))
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
	
