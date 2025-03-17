#ifndef DEVELOPER_GROUP_H
#define DEVELOPER_GROUP_H
typedef struct{
    const char* group_logo;
    const char* dev1_logo;
    const char* dev2_logo;
}Group_Logo;

Group_Logo create_group_logo(const char* caption, const char* logo1, const char* logo2);


#endif
