#include "developer.h"
#include "pointer_utils.h"
#include <stdio.h>


// Initialising Developer structure and defining it directly by passing in the required data as pointers 
Developer create_developer(const char* name, const char* alias){
    check_pointer(name);
    check_pointer(alias);
    Developer dev = {.name = name, .alias = alias};
    return dev;
}



