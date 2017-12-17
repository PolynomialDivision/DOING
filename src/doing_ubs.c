//
// Created by nick on 16.12.17.
//

#include "doing_ubus.h"

static struct ubus_context *ctx = NULL;
static struct ubus_context *ctx_clients; /* own ubus conext otherwise strange behavior... */

static struct ubus_subscriber hostapd_event;
static struct blob_buf b;

void update_clients(struct uloop_timeout *t);

struct uloop_timeout client_timer = {
        .cb = update_clients
};
struct uloop_timeout hostapd_timer = {
        .cb = update_hostapd_sockets
};

int hostapd_array_check_id(uint32_t id);
void hostapd_array_insert(uint32_t id);
void hostapd_array_delete(uint32_t id);

void add_client_update_timer(time_t time)
{
    uloop_timeout_set(&client_timer, time);
}

int hostapd_array_check_id(uint32_t id)
{
    for(int i = 0; i <= hostapd_sock_last; i++)
    {
        if(hostapd_sock_arr[i] == id)
        {
            return 1;
        }
    }
    return 0;
}

#define MAX_HOSTAPD_SOCKETS 10
uint32_t hostapd_sock_arr[MAX_HOSTAPD_SOCKETS];
int hostapd_sock_last = -1;

enum {
    AUTH_BSSID_ADDR,
    AUTH_CLIENT_ADDR,
    AUTH_TARGET_ADDR,
    AUTH_SIGNAL,
    AUTH_FREQ,
    __AUTH_MAX,
};

static const struct blobmsg_policy auth_policy[__AUTH_MAX] = {
        [AUTH_BSSID_ADDR] = {.name = "bssid", .type = BLOBMSG_TYPE_STRING},
        [AUTH_CLIENT_ADDR] = {.name = "address", .type = BLOBMSG_TYPE_STRING},
        [AUTH_TARGET_ADDR] = {.name = "target", .type = BLOBMSG_TYPE_STRING},
        [AUTH_SIGNAL] = {.name = "signal", .type = BLOBMSG_TYPE_INT32},
        [AUTH_FREQ] = {.name = "freq", .type = BLOBMSG_TYPE_INT32},
};

enum {
    PROB_BSSID_ADDR,
    PROB_CLIENT_ADDR,
    PROB_TARGET_ADDR,
    PROB_SIGNAL,
    PROB_FREQ,
    PROB_HT_SUPPORT,
    PROB_VHT_SUPPORT,
    __PROB_MAX,
};

static const struct blobmsg_policy prob_policy[__PROB_MAX] = {
        [PROB_BSSID_ADDR] = {.name = "bssid", .type = BLOBMSG_TYPE_STRING},
        [PROB_CLIENT_ADDR] = {.name = "address", .type = BLOBMSG_TYPE_STRING},
        [PROB_TARGET_ADDR] = {.name = "target", .type = BLOBMSG_TYPE_STRING},
        [PROB_SIGNAL] = {.name = "signal", .type = BLOBMSG_TYPE_INT32},
        [PROB_FREQ] = {.name = "freq", .type = BLOBMSG_TYPE_INT32},
        [PROB_HT_SUPPORT] = {.name = "ht_support", .type = BLOBMSG_TYPE_INT8},
        [PROB_VHT_SUPPORT] = {.name = "vht_support", .type = BLOBMSG_TYPE_INT8},
};

enum {
    CLIENT_TABLE,
    CLIENT_TABLE_BSSID,
    CLIENT_TABLE_FREQ,
    CLIENT_TABLE_HT,
    CLIENT_TABLE_VHT,
    CLIENT_TABLE_CHAN_UTIL,
    CLIENT_TABLE_NUM_STA,
    __CLIENT_TABLE_MAX,
};

static const struct blobmsg_policy client_table_policy[__CLIENT_TABLE_MAX] = {
        [CLIENT_TABLE] = {.name = "clients", .type = BLOBMSG_TYPE_TABLE},
        [CLIENT_TABLE_BSSID] = {.name = "bssid", .type = BLOBMSG_TYPE_STRING},
        [CLIENT_TABLE_FREQ] = {.name = "freq", .type = BLOBMSG_TYPE_INT32},
        [CLIENT_TABLE_HT] = {.name = "ht_supported", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_TABLE_VHT] = {.name = "vht_supported", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_TABLE_CHAN_UTIL] = {.name = "channel_utilization", .type = BLOBMSG_TYPE_INT32},
        [CLIENT_TABLE_NUM_STA] = {.name = "num_sta", .type = BLOBMSG_TYPE_INT32},
};

enum {
    CLIENT_AUTH,
    CLIENT_ASSOC,
    CLIENT_AUTHORIZED,
    CLIENT_PREAUTH,
    CLIENT_WDS,
    CLIENT_WMM,
    CLIENT_HT,
    CLIENT_VHT,
    CLIENT_WPS,
    CLIENT_MFP,
    CLIENT_AID,
    __CLIENT_MAX,
};

static const struct blobmsg_policy client_policy[__CLIENT_MAX] = {
        [CLIENT_AUTH] = {.name = "auth", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_ASSOC] = {.name = "assoc", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_AUTHORIZED] = {.name = "authorized", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_PREAUTH] = {.name = "preauth", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_WDS] = {.name = "wds", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_WMM] = {.name = "wmm", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_HT] = {.name = "ht", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_VHT] = {.name = "vht", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_WPS] = {.name = "wps", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_MFP] = {.name = "mfp", .type = BLOBMSG_TYPE_INT8},
        [CLIENT_AID] = {.name = "aid", .type = BLOBMSG_TYPE_INT32},
};

static int subscribe_to_hostapd(char *hostapd_dir) {

    if(ctx == NULL)
    {
        return 0;
    }

    printf("Registering ubus event subscriber!\n");
    int ret = ubus_register_subscriber(ctx, &hostapd_event);
    if (ret) {
        fprintf(stderr, "Failed to add watch handler: %s\n", ubus_strerror(ret));
        return -1;
    }

    // add callbacks
    hostapd_event.remove_cb = hostapd_handle_remove;
    hostapd_event.cb = hostapd_notify;

    subscribe_to_hostapd_interfaces(hostapd_dir);

    return 0;
}


int doing_init_ubus(const char *ubus_socket, char *hostapd_dir) {
    uloop_init();
    signal(SIGPIPE, SIG_IGN);

    ctx = ubus_connect(ubus_socket);
    if (!ctx) {
        fprintf(stderr, "Failed to connect to ubus\n");
        return -1;
    } else {
        printf("Connected to ubus\n");
    }

    ubus_add_uloop(ctx);

    uloop_run();

    ubus_free(ctx);
    uloop_done();
    return 0;
}