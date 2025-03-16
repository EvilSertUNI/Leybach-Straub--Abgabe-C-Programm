#include "developer.h"
#include <string.h>


/*

***********************
=====================
Developer: 
name: Selina Kyle
alias: Catwoman
=====================
=====================
Developer: 
name: Clark Kent
alias: Superman
=====================
***********************


*/

// Initialising Developer structure and defining it directly by passing in the required data as pointers 
Developer create_developer(const char* name, const char* alias){
    Developer dev = {.name = name, .alias = alias};
    return dev;
}



