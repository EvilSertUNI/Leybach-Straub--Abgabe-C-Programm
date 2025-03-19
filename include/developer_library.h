/* -*- mode: c; -*- */

#if !defined (DEVELOPER_LIBRARY_H)
#define DEVELOPER_LIBRARY_H

// |:ws:| the pointer should not be immutable, otherwise
// Developer->name = "some string" would not work, i.e. nobody can
// get married and the alias cannot be changed
// Developer struct containing two addresses of inmutable strings
typedef struct {
    const char* name;
    const char* alias;
} Developer;

extern Developer create_developer(const char* name, const char* alias);

// Group_Logo
typedef struct{
    const char* group_logo;
    const char* dev1_logo;
    const char* dev2_logo;
} Group_Logo;

// constructor for Group_Logo
extern Group_Logo create_group_logo(const char* caption, const char* logo1, const char* logo2);

// All exported symbols of a library must be defined extern in the
// header, so that API clashes can be detected by the compiler.
extern const char group_caption[];
extern const char developer1_logo[];
extern const char developer2_logo[];

// functions, to print all statements needed for the programm
extern void print_main_menu(void);
extern void print_logo(const Group_Logo* logo);
extern void print_developer(const Developer* dev);

extern void check_pointer(const void* ptr);

// |:here:|

#endif /* !defined (DEVELOPER_LIBRARY_H) */

/*
Local Variables:
mode: c
snip-mode: c
truncate-lines: t
eIDE-comment-start: ""
eIDE-comment-start-rx: "\\(\\|//\\|/[*]\\)"
End:
*/
