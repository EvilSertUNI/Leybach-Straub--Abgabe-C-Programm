#include <stdio.h>
#include "developer.h"
#include "output_functions.h"
#include "developer_group.h"

enum { sel_invalid=0, sel_developers, sel_group_logo, sel_group, sel_exit};

static const int sel_min = sel_developers;
static const int sel_max = sel_exit;

int main(void) {

    // Defining developer names and creating the developer structs with it
    const char dev1_name[20] = "Ferdinand";
    const char dev1_alias[20] = "Evil_Sert";
    const Developer dev1 = create_developer(dev1_name, dev1_alias);
    const char dev2_name[20] = "Simon";
    const char dev2_alias[20] = "Der Allgäuer";
    const Developer dev2 = create_developer(dev2_name, dev2_alias);

    // Importing group logo data for group logo creation
    extern const char group_caption[];
    extern const char developer1_logo[];
    extern const char developer2_logo[];

    // Creating the actual logo struct
    const Group_Logo logo = create_group_logo(group_caption, developer1_logo, developer2_logo);

    // Going into the programm (while-) loop (UML-diagram)
    while (1 == 1) {
        int user_input; // |:ws:| plain int is handled most efficiently by CPU. No need to use special integer size
        int input_count; // |:ws:| prototype: int scanf() return value: `number of input  items .. matched  and  assigned`
        do {
            print_main_menu();
            input_count = scanf("%d", &user_input);

            // if (exactly 1 value has been successfully read?) then (yes)
            if (input_count != 1) {
                if (input_count < 1) {
                    // error message
                    printf("Invalid input count! (%d)\n", input_count);
                }
            }
            // Cleaning input buffer by reading until encountering newline
            while (getchar() != '\n') {};
        } while (input_count != 1); // Repeats, until input is correct (In terms of type)

        // Doesn't proceed with the programm, if abort criteria is met
        if (user_input == sel_exit) {
            break;
        }

        //Produce error message if input number doesn't fit allowed parameters
        if (user_input < sel_min || user_input > sel_max) {
            printf("Input out of range! (%d not in %d-%d)\n", user_input, sel_min, sel_max);
            continue;
        }

        // Print the logo for cases sel_group_logo and sel_group
        if (user_input == sel_group_logo || user_input == sel_group){
            print_logo(&logo);
        }

        // Prints developers for cases sel_developers and sel_group
        if (user_input == sel_developers || user_input == sel_group){
            printf("***********************\n");
            print_developer(&dev1);
            print_developer(&dev2);
            printf("***********************\n");
        }
    }
    return 0;

}
