#include <stdio.h>
#include "developer.h"
#include "output_functions.h"


int main(void){

    //Testing the 'create_student' fucntion with sample input data 
    const char dev1_name[20] = "Ferdinand";
    const char dev1_alias[20] = "Evil_Sert";
    Developer dev = create_developer(dev1_name, dev1_alias);
    printf("Name: %s, Alias: %s\n", dev.name, dev.alias);
    
    
    //Testing the 'print_main_menu' function
    print_main_menu();

    return 0;
}


