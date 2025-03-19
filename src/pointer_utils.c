#include <stdio.h>
#include "developer_library.h"

// Function, that checks if a pointer is a NULL pointer and then produces an error
void check_pointer(const void* ptr) {
  if (ptr == NULL) {
        printf("ERROR: NULL pointer detected\n"
               "Data Input Failed!");
  }
  return;
}
