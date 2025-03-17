# Define the minimum CMake version
cmake_minimum_required(VERSION 3.20)

# Define the project name
project(Abgabe-C--Leybach-Straub)

# Define the C standard version
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)

# Add some compile options
add_compile_options(-Wall -Wextra -Werror -pedantic -O0)

# Add a single library with all source files
add_library(developer_library src/developer.c src/developer_group.c src/output_functions.c src/pointer_utils.c)

# Add the includes to the library
target_include_directories(developer_library PUBLIC include)

# Add an executable and assign files to it
add_executable(exam src/main.c)

# Link the single library with the project
target_link_libraries(exam developer_library)
