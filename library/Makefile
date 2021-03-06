# ***************************************************************************
# Copyright (c) 2017 Digi International Inc.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# Digi International Inc. 11001 Bren Road East, Minnetonka, MN 55343
#
# ***************************************************************************
# Use GNU C Compiler
CC ?= gcc

# Generated Library name.
NAME := cloudconnector

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
INSTALL_HEADERS_DIR = /usr/include/cloudconnector

# Location of Platform Source Code.
PLATFORM_DIR = $(SRC)/ccimp
MINIUNZ_DIR = $(SRC)/miniunz

# Resolves where to find Source files.
vpath $(CCFSM_PRIVATE_DIR)/%.c
vpath $(PLATFORM_DIR)/%.c

# CFLAG Definition
CFLAGS += $(DFLAGS)
# Enable Compiler Warnings
CFLAGS += -Winit-self -Wbad-function-cast -Wpointer-arith
CFLAGS += -Wmissing-parameter-type -Wstrict-prototypes -Wformat-security
CFLAGS += -Wformat-y2k -Wold-style-definition -Wcast-align -Wformat-nonliteral 
CFLAGS += -Wredundant-decls -Wvariadic-macros
CFLAGS += -Wall -Werror -Wextra -pedantic
CFLAGS += -Wno-error=padded -Wno-error=format-nonliteral -Wno-unused-function -Wno-missing-field-initializers
# Use ANSIC 99
CFLAGS +=-std=c99
# Include POSIX and GNU features.
CFLAGS += -D_POSIX_C_SOURCE=200112L -D_GNU_SOURCE
# Include Public Header Files.
CFLAGS += -I $(SRC) -I $(CUSTOM_CCFSM_PUBLIC_HEADER_DIR) -I $(CCFSM_PUBLIC_HEADER_DIR)
CFLAGS += -I $(CCAPI_PUBLIC_HEADER_DIR) -I $(CUSTOM_PUBLIC_HEADER_DIR)
# Include Platform Header Files.
CFLAGS += -I $(MINIUNZ_DIR) -I $(PLATFORM_DIR)
CFLAGS += $(shell pkg-config --cflags recovery)

CFLAGS += -g -O0

# Target output to generate.
CC_PRIVATE_SRCS := $(CCFSM_PRIVATE_DIR)/connector_api.c
CCAPI_PRIVATE_SRCS := $(wildcard $(CCAPI_PRIVATE_DIR)/*.c)
PLATFORM_SRCS := $(wildcard $(PLATFORM_DIR)/*.c)
CC_DEY_SRCS := $(wildcard $(SRC)/*.c)
CC_MINIUNZ_SRCS := $(wildcard $(SRC)/miniunz/*.c)

SRCS = $(CC_DEY_SRCS) $(CC_MINIUNZ_SRCS) $(PLATFORM_SRCS) $(CC_PRIVATE_SRCS) $(CCAPI_PRIVATE_SRCS)

OBJS = $(SRCS:.c=.o)

.PHONY: all
all: lib$(NAME).a

lib$(NAME).a: $(OBJS)
	$(AR) -rcs $@ $^

.PHONY: install
install: lib$(NAME).a
	# Install library and pkg-config file
	install -d $(DESTDIR)/usr/lib/pkgconfig
	install -m 0644 lib$(NAME).a $(DESTDIR)/usr/lib/
	install -m 0644 cloudconnector.pc $(DESTDIR)/usr/lib/pkgconfig/
	# Install header files
	install -d $(DESTDIR)$(INSTALL_HEADERS_DIR)/ccapi/ \
		  $(DESTDIR)$(INSTALL_HEADERS_DIR)/custom/ \
		  $(DESTDIR)$(INSTALL_HEADERS_DIR)/ccimp/
	install -m 0644 src/cc_api/include/ccapi/*.h $(DESTDIR)$(INSTALL_HEADERS_DIR)/ccapi/
	install -m 0644 src/cc_api/include/custom/*.h $(DESTDIR)$(INSTALL_HEADERS_DIR)/custom/
	install -m 0644 src/cc_api/include/ccimp/ccimp_types.h $(DESTDIR)/$(INSTALL_HEADERS_DIR)/ccimp/
	install -m 0644 src/cloudconnector.h src/cc_init.h src/cc_logging.h $(DESTDIR)/$(INSTALL_HEADERS_DIR)/
	# Install certificates
	install -d $(DESTDIR)/etc/ssl/certs
	install -m 0644 src/cc_api/source/cc_ansic/public/certificates/*.crt $(DESTDIR)/etc/ssl/certs/

.PHONY: clean
clean:
	-rm -f *.so* lib$(NAME).a $(OBJS)
