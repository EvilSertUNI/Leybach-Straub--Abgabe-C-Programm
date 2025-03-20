#include <stdio.h>
#include "developer_library.h"

// Prints main menu
void print_main_menu(void) {
    printf("\033[4;92m========================\n");
    printf("Choose your action: \n");
    printf("List Developers \t[1]\n");
    printf("Print Group Logo \t[2]\n");
    printf("Print Group \t\t[3]\n");
    printf("Exit \t\t\t[4]\n");
    printf("========================\033[0m\n");
    printf("Enter your selection: ");
    return;
}

// Prints Group_Logo struct
void print_logo(const Group_Logo* logo) {
    check_pointer(logo);
    printf("Developer Group:\n%s\n\n\n", logo -> group_logo);
    printf("%s\n\n\n", logo -> dev1_logo);
    printf("%s\n\n\n", logo -> dev2_logo);
}
