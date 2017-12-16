cmake_minimum_required(VERSION 2.6)
PROJECT(doing)

INCLUDE_DIRECTORIES(include)

ADD_DEFINITIONS(-Os -Wall -Werror --std=gnu99 -Wmissing-declarations -Wno-unknown-warning-option -Wno-format-truncation)

SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")

SET(SOURCES
        main.c
)

SET(LIBS
        ubox ubus json-c blobmsg_json)

ADD_EXECUTABLE(doing ${SOURCES})

TARGET_LINK_LIBRARIES(doing ${LIBS})

INSTALL(TARGETS doing
        RUNTIME DESTINATION /usr/sbin/
)