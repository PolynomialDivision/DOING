#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

#include <libubus.h>

#include "doing_ubus.h"

int main(int argc, char **argv) {

    const char *ubus_socket = NULL;
    int ch;
    char opt_hostapd_dir[BUFSIZE_DIR];

    while ((ch = getopt(argc, argv, "h:")) != -1) {
        switch (ch) {
            case 's':
                ubus_socket = optarg;
                break;
            case 'h':
                snprintf(opt_hostapd_dir, BUFSIZE_DIR, "%s", optarg);
                printf("hostapd dir: %s\n", opt_hostapd_dir);
                hostapd_dir_glob = optarg;
                break;
            default:
                break;
        }
    }

    doing_init_ubus(ubus_socket, opt_hostapd_dir);

    return 0;
}