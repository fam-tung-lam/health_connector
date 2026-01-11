package com.phamtunglam.health_connector_hc_android

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Provides coroutine dispatchers for dependency injection.
 */
internal interface DispatcherProvider {
    /**
     * Dispatcher for UI/Main thread operations.
     */
    val main: CoroutineDispatcher

    /**
     * Dispatcher for I/O operations (network, disk, database).
     */
    val io: CoroutineDispatcher

    /**
     * Dispatcher for CPU-intensive operations.
     */
    val default: CoroutineDispatcher
}

/**
 * Production implementation of [DispatcherProvider] using standard Kotlin dispatchers.
 */
internal object StandardDispatcherProvider : DispatcherProvider {
    override val main: CoroutineDispatcher
        get() = Dispatchers.Main

    override val io: CoroutineDispatcher
        get() = Dispatchers.IO

    override val default: CoroutineDispatcher
        get() = Dispatchers.Default
}
