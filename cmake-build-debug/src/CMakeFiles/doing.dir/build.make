# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.9

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/nick/clion-2017.2/bin/cmake/bin/cmake

# The command to remove a file.
RM = /home/nick/clion-2017.2/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/nick/DOING

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/nick/DOING/cmake-build-debug

# Include any dependencies generated for this target.
include src/CMakeFiles/doing.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/doing.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/doing.dir/flags.make

src/CMakeFiles/doing.dir/main.c.o: src/CMakeFiles/doing.dir/flags.make
src/CMakeFiles/doing.dir/main.c.o: ../src/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/nick/DOING/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/CMakeFiles/doing.dir/main.c.o"
	cd /home/nick/DOING/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/doing.dir/main.c.o   -c /home/nick/DOING/src/main.c

src/CMakeFiles/doing.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/doing.dir/main.c.i"
	cd /home/nick/DOING/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/nick/DOING/src/main.c > CMakeFiles/doing.dir/main.c.i

src/CMakeFiles/doing.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/doing.dir/main.c.s"
	cd /home/nick/DOING/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/nick/DOING/src/main.c -o CMakeFiles/doing.dir/main.c.s

src/CMakeFiles/doing.dir/main.c.o.requires:

.PHONY : src/CMakeFiles/doing.dir/main.c.o.requires

src/CMakeFiles/doing.dir/main.c.o.provides: src/CMakeFiles/doing.dir/main.c.o.requires
	$(MAKE) -f src/CMakeFiles/doing.dir/build.make src/CMakeFiles/doing.dir/main.c.o.provides.build
.PHONY : src/CMakeFiles/doing.dir/main.c.o.provides

src/CMakeFiles/doing.dir/main.c.o.provides.build: src/CMakeFiles/doing.dir/main.c.o


src/CMakeFiles/doing.dir/doing_ubs.c.o: src/CMakeFiles/doing.dir/flags.make
src/CMakeFiles/doing.dir/doing_ubs.c.o: ../src/doing_ubs.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/nick/DOING/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object src/CMakeFiles/doing.dir/doing_ubs.c.o"
	cd /home/nick/DOING/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/doing.dir/doing_ubs.c.o   -c /home/nick/DOING/src/doing_ubs.c

src/CMakeFiles/doing.dir/doing_ubs.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/doing.dir/doing_ubs.c.i"
	cd /home/nick/DOING/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/nick/DOING/src/doing_ubs.c > CMakeFiles/doing.dir/doing_ubs.c.i

src/CMakeFiles/doing.dir/doing_ubs.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/doing.dir/doing_ubs.c.s"
	cd /home/nick/DOING/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/nick/DOING/src/doing_ubs.c -o CMakeFiles/doing.dir/doing_ubs.c.s

src/CMakeFiles/doing.dir/doing_ubs.c.o.requires:

.PHONY : src/CMakeFiles/doing.dir/doing_ubs.c.o.requires

src/CMakeFiles/doing.dir/doing_ubs.c.o.provides: src/CMakeFiles/doing.dir/doing_ubs.c.o.requires
	$(MAKE) -f src/CMakeFiles/doing.dir/build.make src/CMakeFiles/doing.dir/doing_ubs.c.o.provides.build
.PHONY : src/CMakeFiles/doing.dir/doing_ubs.c.o.provides

src/CMakeFiles/doing.dir/doing_ubs.c.o.provides.build: src/CMakeFiles/doing.dir/doing_ubs.c.o


# Object files for target doing
doing_OBJECTS = \
"CMakeFiles/doing.dir/main.c.o" \
"CMakeFiles/doing.dir/doing_ubs.c.o"

# External object files for target doing
doing_EXTERNAL_OBJECTS =

src/doing: src/CMakeFiles/doing.dir/main.c.o
src/doing: src/CMakeFiles/doing.dir/doing_ubs.c.o
src/doing: src/CMakeFiles/doing.dir/build.make
src/doing: src/CMakeFiles/doing.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/nick/DOING/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable doing"
	cd /home/nick/DOING/cmake-build-debug/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/doing.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/doing.dir/build: src/doing

.PHONY : src/CMakeFiles/doing.dir/build

src/CMakeFiles/doing.dir/requires: src/CMakeFiles/doing.dir/main.c.o.requires
src/CMakeFiles/doing.dir/requires: src/CMakeFiles/doing.dir/doing_ubs.c.o.requires

.PHONY : src/CMakeFiles/doing.dir/requires

src/CMakeFiles/doing.dir/clean:
	cd /home/nick/DOING/cmake-build-debug/src && $(CMAKE_COMMAND) -P CMakeFiles/doing.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/doing.dir/clean

src/CMakeFiles/doing.dir/depend:
	cd /home/nick/DOING/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/nick/DOING /home/nick/DOING/src /home/nick/DOING/cmake-build-debug /home/nick/DOING/cmake-build-debug/src /home/nick/DOING/cmake-build-debug/src/CMakeFiles/doing.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/doing.dir/depend

