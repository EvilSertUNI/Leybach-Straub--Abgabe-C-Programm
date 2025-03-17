#include <stdio.h>
//#include "choice.h"

void main_menu(int *input_ptr)
{

    printf("\033[4;92m========================\n"
           "Choose your action: \n"
           "List Developers \t[1]\n"
           "Print Group Logo \t[2]\n"
           "Print Group \t\t[3]\n"
           "Exit \t\t\t[4]\n"
           "========================\033[0m\n"
           "Enter your selection: ");

        int user_input;
        scanf("%d", &user_input);
        *input_ptr = user_input;

        switch (*input_ptr)
        {
        case 1:
            //developer.c
            printf("case1");
            break;
        case 2:
            //group_logo.c
            printf("case2");
            break;
        case 3:
            //group.c
            printf("case3");
            break;
        case 4:
            //Exit the program
            printf("case4");
            break;
            }

    //Test the function with sample_values

    int *test_ptr;
    int test_coice = 4;
    test_ptr = &test_coice;
    main_menu(test_ptr);

    return;
}
