# define the minimum cmake version
cmake_minimum_required(VERSION 3.20)

# define the project name
project(Abgabe-C--Leybach-Straub)

# define the c standard version
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)

# add some compile options
add_compile_options(-Wall -Wextra -Werror -pedantic -O0)

# adding a library for the initialization function create_developer
add_library(create_developer src/developer.c)

# adding a library for the initialization function create_logo
add_library(create_logo src/developer_group.c)

# adding a library for the output functions
add_library(output_functions src/output_functions.c)

# add the includes to the libraries
target_include_directories(create_developer PUBLIC include)
target_include_directories(create_logo PUBLIC include)
target_include_directories(output_functions PUBLIC include)


# add an executable and assign files to it
add_executable(exam src/main.c)

# linking necessary libraries with the project
target_link_libraries(exam create_developer create_logo output_functions)
