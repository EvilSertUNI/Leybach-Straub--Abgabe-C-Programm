#include <assert.h>
#include <stdio.h>
#include <malloc.h>
#include "developer_library.h"

// constructor for Developer
Developer *developer_new(Developer *dev, const char* name, const char* alias) {
    // Validating input pointers
    assert(name != NULL);
    assert(alias != NULL);
    if (dev == NULL) {
        dev = (Developer *) malloc(sizeof(Developer));
        assert(dev != NULL);
    }
    dev->name = name;
    dev->alias = alias;
    return dev;
}

// destructor for Developer
void developer_delete(Developer *dev) {
    if (dev == NULL) {
        fprintf ( stderr, "warning: double free of developer\n" );
        return;
    }
    /* facilitate detection of access to deleted objects */
    dev->name = NULL;
    dev->alias = NULL;
    free(dev);
}

// Prints Developer struct
void developer_print(const Developer* dev) {
    check_pointer(dev);
    printf("========================\n");
    printf("Developer:\n");
    printf("name: %s\n", dev->name);
    printf("alias: %s\n", dev->alias);
    printf("========================\n");
    return;
}
