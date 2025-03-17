#include <stdio.h>
#include "developer.h"
#include "output_functions.h"
#include "developer_group.h"

int main(void){
  
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
    
    // Declaring Input Variable and setting it to 0, so the programm just goes through
    short int user_input = 0;


    // Going into the programm (while-) loop (UML-diagram)
    while (user_input != 4) {
        char input_status;
	const char error_message[] = "That was not a valid input!\n";
	do {
	    print_main_menu();
	    printf("Enter your selection: ");
	    input_status = scanf("%hd", &user_input);

	    if (input_status != 1) { // Checks whether exactly 1 value has been successfully read
	        if (input_status < 1) {
		  printf("%s", error_message); //Produces error message if input isn't a number
		}
	    } while (getchar() != '\n'); // Cleaning input buffer by reading until encountering newline  
	} while (input_status != 1); // Repeats, until input is correct (In terms of type)
        if (user_input == 4) { // Doesn't proceed with the programm, if abort criteria is met
            break;
        }
	if (user_input != 1 && user_input != 2 && user_input != 3) {
	    printf("%s", error_message); //Produces error message if input number doesn't fit parameters
	    continue;
	}
        if (user_input == 2 || user_input == 3){ // Has to print the logo in case 2 and 3
            print_logo(&logo);
        }
        if (user_input == 1 || user_input == 3){ // Has to print developers in case 1 and 3
            printf("***********************\n");
            print_developer(&dev1);
            print_developer(&dev2);
            printf("***********************\n");
        }
    }
    return 0;

}
