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
    dev->next = NULL;
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

// Developer list
Developers _developers = { .first = NULL, .last = NULL };
Developers *developers = &_developers;

// Developer list methods
void devs_add_developer(Developers *devs, Developer *dev) {
    assert(dev != NULL);
    if (devs->first == NULL) {
        devs->first = dev;
    }
    if (devs->last != NULL) {
        devs->last->next = dev;
    }
    devs->last = dev;
}

void devs_add_developers(Developers *devs, const DeveloperInit *data) {
    Developer *dev;
    while (data[0][0] != NULL) {
        dev = developer_new(NULL, data[0][0], data[0][1]);
        devs_add_developer(devs, dev);
        data++;
    }
}

void devs_print_all (const Developers *devs) {
    printf("***********************\n");
    Developer *dev = devs->first;
    // Explicit `if (dev != NULL)` is always better than implicit `if
    // (dev)`, since it relates what the intended purpose is.
    while (dev != NULL) {
        developer_print(dev);
        dev = dev->next;
    }
    printf("***********************\n");
}
