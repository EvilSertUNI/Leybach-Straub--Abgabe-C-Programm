#include "developer.h"
#include <string.h>


// Initialising Developer structure and defining it directly by passing in the required data as pointers 
Developer create_developer(const char* name, const char* alias){
    Developer dev = {.name = name, .alias = alias};
    return dev;
}



