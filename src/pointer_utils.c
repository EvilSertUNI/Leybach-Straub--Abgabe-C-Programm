#include "pointer_utils.h"
#include <stdio.h>


void check_pointer(const void* ptr){
  if (ptr == NULL) {
        printf("ERROR: NULL pointer detected\n"
	       "Data Input Failed!");
  }
  return;
}
