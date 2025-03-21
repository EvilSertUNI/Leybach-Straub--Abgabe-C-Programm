/*
 * -*- mode: c; -*- 
 */

#if !defined (DEVELOPER_LIBRARY_H)
#define DEVELOPER_LIBRARY_H

// |:ws:| the pointer should not be immutable, otherwise
// Developer->name = "some string" would not work, i.e. nobody can
// get married and the alias cannot be changed
// Developer struct containing two addresses of inmutable strings
typedef struct Developer Developer;
struct Developer {
    Developer      *next;
    const char     *name;
    const char     *alias;
};

// typedef for static initialization of developer data
typedef const char *DeveloperInit[2];

// constructor and destructor for Developer
extern Developer *developer_new(Developer * dev, const char *name,
                                const char *alias);
extern void     developer_delete(Developer * dev);

// methods for Developer
extern void     developer_print(const Developer * dev);

// Developer List
// A single linked list allows for simple dynamic manipulation of
// developers without the arbitrary limits of an array.
typedef struct Developers Developers;
struct Developers {
    Developer      *first;
    Developer      *last;
};

// methods for Developers
extern void     devs_add_developer(Developers * devs, Developer * dev);
extern void     devs_add_developers(Developers * devs,
                                    const DeveloperInit * data);
extern void     devs_print_all(const Developers * devs);

extern Developers *developers;

// Group_Logo
typedef struct {
    const char     *group_logo;
    const char     *dev1_logo;
    const char     *dev2_logo;
} Group_Logo;

// constructor for Group_Logo
extern Group_Logo create_group_logo(const char *caption, const char *logo1,
                                    const char *logo2);

// All exported symbols of a library must be defined extern in the
// header, so that API clashes can be detected by the compiler.
extern const char group_caption[];
extern const char developer1_logo[];
extern const char developer2_logo[];

// functions, to print all statements needed for the programm
extern void     print_main_menu(void);
extern void     print_logo(const Group_Logo * logo);

extern void     check_pointer(const void *ptr);

// |:here:|

#endif                          /* !defined (DEVELOPER_LIBRARY_H) */
