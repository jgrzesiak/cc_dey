/*
 * Copyright (c) 2017 Digi International Inc.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this file,
 * You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
 * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 *
 * Digi International Inc. 11001 Bren Road East, Minnetonka, MN 55343
 * =======================================================================
 */

#ifndef ccapi_rci_functions_h
#define ccapi_rci_functions_h

#include <ccapi/ccapi.h>

#include "connector_api.h"
#include "rci_setting_ethernet.h"
#include "rci_setting_wifi.h"
#include "rci_setting_static_location.h"
#include "rci_setting_system.h"
#include "rci_setting_system_monitor.h"
#include "rci_state_device_info.h"
#include "rci_state_device_state.h"
#include "rci_state_gps_stats.h"
#include "rci_state_primary_interface.h"

#define UNUSED_PARAMETER(a) (void)(a)

extern ccapi_rci_data_t const ccapi_rci_data;

typedef enum {
	CCAPI_GLOBAL_ERROR_NONE,
	CCAPI_GLOBAL_ERROR_BAD_COMMAND = 1, /* PROTOCOL DEFINED */
	CCAPI_GLOBAL_ERROR_BAD_DESCRIPTOR,
	CCAPI_GLOBAL_ERROR_BAD_VALUE,
	CCAPI_GLOBAL_ERROR_LOAD_FAIL, /* USER DEFINED (GLOBAL ERRORS) */
	CCAPI_GLOBAL_ERROR_SAVE_FAIL,
	CCAPI_GLOBAL_ERROR_MEMORY_FAIL,
	CCAPI_GLOBAL_ERROR_NOT_IMPLEMENTED,
	CCAPI_GLOBAL_ERROR_COUNT
} ccapi_global_error_id_t;

ccapi_global_error_id_t rci_session_start_cb(ccapi_rci_info_t * const info);
ccapi_global_error_id_t rci_session_end_cb(ccapi_rci_info_t * const info);

ccapi_global_error_id_t rci_action_start_cb(ccapi_rci_info_t * const info);
ccapi_global_error_id_t rci_action_end_cb(ccapi_rci_info_t * const info);

ccapi_global_error_id_t rci_do_command_cb(ccapi_rci_info_t * const info);
ccapi_global_error_id_t rci_set_factory_defaults_cb(ccapi_rci_info_t * const info);
ccapi_global_error_id_t rci_reboot_cb(ccapi_rci_info_t * const info);

#endif
