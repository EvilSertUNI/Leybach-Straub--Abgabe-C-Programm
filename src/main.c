#include <stdio.h>
#include "developer.h"

int main(void){

//Testing the 'create_student' fucntion with sample input data 
    const char dev1_name[20] = "Ferdinand";
    const char dev1_alias[20] = "Evil_Sert";
    Developer dev = create_student(dev1_name, dev1_alias);
    printf("Name: %s, Alias: %s\n", dev.name, dev.alias);
    return 0;

/*
    printf("\033[4;92m========================\n");
    printf("Choose your action: \n");
    printf("List Developers \t[1]\n");
    printf("Print Group Logo \t[2]\n");
    printf("Print Group \t\t[3]\n");
    printf("Exit \t\t\t[4]\n");
    printf("========================\033[0m\n");

    printf("Enter your selection: ");
*/
}

