#ifndef PRINT_FUNCTIONS_H
#define PRINT_FUNCTIONS_H
#include "developer.h" // Include developer.h for Developer struct
#include "developer_group.h" // Include developer_group.h for developer_group struct



// functions, to print all statements needed for the programm
void print_main_menu(void);
void print_developer(const Developer* dev);
void print_logo(const Group_Logo* logo);

#endif
