# ***************************************************************************
# Copyright (c) 2016 Digi International, Inc.
# All rights not expressly granted are reserved.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Digi International, Inc. 11001 Bren Road East, Minnetonka, MN 55343
#
# ***************************************************************************

# Location of Source Code.
SRC = src

# Location of CC API dir.
CCAPI_DIR = $(SRC)/cc_api

# Location of Connector dir.
CCFSM_DIR = $(CCAPI_DIR)/source/cc_ansic

# Location of Private Connector Source Code.
CCAPI_PRIVATE_DIR = $(CCAPI_DIR)/source
CCFSM_PRIVATE_DIR = $(CCFSM_DIR)/private

# Location of Public Include Header Files.
CCFSM_PUBLIC_HEADER_DIR = $(CCFSM_DIR)/public/include
CCAPI_PUBLIC_HEADER_DIR = $(CCAPI_DIR)/include
CUSTOM_PUBLIC_HEADER_DIR = $(SRC)/custom
CUSTOM_CCFSM_PUBLIC_HEADER_DIR = $(CCAPI_DIR)/source/cc_ansic_custom_include

# Location of Platform Source Code.
PLATFORM_DIR = $(SRC)/ccimp

# Resolves where to find Source files.
vpath $(CCFSM_PRIVATE_DIR)/%.c
vpath $(PLATFORM_DIR)/%.c

# CFLAG Definition
CFLAGS += -I $(SRC) -I $(CUSTOM_CCFSM_PUBLIC_HEADER_DIR) -I $(CCFSM_PUBLIC_HEADER_DIR) -I $(CCAPI_PUBLIC_HEADER_DIR) -I $(CUSTOM_PUBLIC_HEADER_DIR) -I $(PLATFORM_DIR)
CFLAGS += -std=c99 -D_POSIX_C_SOURCE=200112L -D_GNU_SOURCE
CFLAGS += -Wall -Wextra -O2

# Target output to generate.
APP_SRCS = $(SRC)/main.c
CC_PRIVATE_SRCS = $(CCFSM_PRIVATE_DIR)/connector_api.c
CCAPI_PRIVATE_SRCS = $(CCAPI_PRIVATE_DIR)/ccapi.c $(CCAPI_PRIVATE_DIR)/ccapi_data_handler.c $(CCAPI_PRIVATE_DIR)/ccapi_init.c $(CCAPI_PRIVATE_DIR)/ccapi_logging.c $(CCAPI_PRIVATE_DIR)/ccapi_transport_tcp.c $(CCAPI_PRIVATE_DIR)/ccapi_firmware_update_handler.c
PLATFORM_SRCS = $(PLATFORM_DIR)/ccimp_os.c $(PLATFORM_DIR)/ccimp_logging.c $(PLATFORM_DIR)/ccimp_hal.c $(PLATFORM_DIR)/ccimp_network_tcp.c $(PLATFORM_DIR)/dns_helper.c
SRCS = $(APP_SRCS) $(PLATFORM_SRCS) $(CC_PRIVATE_SRCS) $(CCAPI_PRIVATE_SRCS)

# Libraries to Link
LDLIBS += -lpthread

# Linking Flags.
LDFLAGS += $(DFLAGS) -Wl,-Map,$(EXECUTABLE).map,--sort-common

# Generated Executable Name.
EXECUTABLE = cc_dey

OBJS = $(SRCS:.c=.o)

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

.PHONY: clean	
clean:
	-rm -f $(EXECUTABLE) $(OBJS) $(EXECUTABLE).map

