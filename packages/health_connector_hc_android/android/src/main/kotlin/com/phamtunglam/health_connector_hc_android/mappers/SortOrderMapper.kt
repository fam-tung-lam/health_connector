package com.phamtunglam.health_connector_hc_android.mappers

import com.phamtunglam.health_connector_hc_android.pigeon.SortOrderDto

/**
 * Converts [SortOrderDto] to a boolean flag indicating ascending or descending order.
 *
 * @return true for ascending order, false for descending order
 */
internal fun SortOrderDto.isAscending(): Boolean = when (this) {
    SortOrderDto.TIME_ASCENDING -> true
    SortOrderDto.TIME_DESCENDING -> false
}
