#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>

/* create a file of provided length */
int main(int argc, char* argv[])
{
    if (argc != 4) {
        fprintf(stderr, "usage: ./create_file 4 1 -o/-h (1KB, 1 file, output folder or here)\n");
        exit(-1);
    }
    int i = 0;
    for(i=0; i<atoi(argv[2]); i++){
        // int length = atoi(argv[1])*1048576; // MB
        int length = atoi(argv[1])*1024; // KB
        char* file_name = calloc(1, 20);
        if(strcmp(argv[3], "-o") == 0){
            sprintf(file_name, "./output/%sKB_%d", argv[1], i+1);
        }else{
            sprintf(file_name, "%sKB_%d", argv[1], i+1);
        }
        if (open(file_name, O_RDONLY) != -1) {
            remove(file_name);
        }

        struct stat st;
        if (stat("./output", &st) == -1) {
            mkdir("./output", 0700);
        }  

        char* buffer = calloc(1, length);
        memset(buffer, 'a', length);
        int file_to_create = creat(file_name, S_IRUSR | S_IWUSR);
        if (write(file_to_create, buffer, length) == -1) {
            fprintf(stderr, "Writing error\n");
            exit(1);
        }
        free(file_name);
        free(buffer);
        close(file_to_create);
    }
    
    return 0;
}