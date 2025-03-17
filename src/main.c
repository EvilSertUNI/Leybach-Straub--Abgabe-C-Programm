#include <stdio.h>
#include "developer.h"
#include "choice.h"

int main(void){

//Testing the 'create_student' fucntion with sample input data 
    const char dev1_name[20] = "Ferdinand";
    const char dev1_alias[20] = "Evil_Sert";
    Developer dev = create_student(dev1_name, dev1_alias);
    printf("Name: %s, Alias: %s\n", dev.name, dev.alias);

    //Test the main_menu function with sample_values
    int test_choice;
    main_menu(&test_choice);

    return 0;
}

