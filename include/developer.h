#ifndef DEVELOPER_H
#define DEVELOPER_H

// Developer struct containing two inmutable pointers with inmutable content
typedef struct {
    const char* const name;
    const char* const alias;
} Developer;

Developer create_developer(const char* name, const char* alias);

#endif
