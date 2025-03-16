#include <stdio.h>
#include "developer.h"
#include "output_functions.h"


int main(void){

    // testing the 'create_developer' fucntion with sample input data 
    const char dev1_name[20] = "Ferdinand";
    const char dev1_alias[20] = "Evil_Sert";
    const Developer dev = create_developer(dev1_name, dev1_alias);
    printf("Name: %s, Alias: %s\n", dev.name, dev.alias);
    
    
    // testing the 'print_main_menu' function
    print_main_menu();

    // Testing the 'print_developer' function
    print_developer(&dev);

    return 0;
}


