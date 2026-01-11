package com.phamtunglam.health_connector_hc_android.utils

import com.phamtunglam.health_connector_hc_android.DispatcherProvider
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.test.TestDispatcher

/**
 * Test implementation of [DispatcherProvider] for unit testing.
 *
 * All dispatcher properties return the same [TestDispatcher] instance,
 * enabling deterministic, controllable coroutine execution in tests.
 *
 * @property testDispatcher The test dispatcher to use for all operations
 */
class TestDispatcherProvider(val testDispatcher: TestDispatcher) : DispatcherProvider {
    override val main: CoroutineDispatcher
        get() = testDispatcher

    override val io: CoroutineDispatcher
        get() = testDispatcher

    override val default: CoroutineDispatcher
        get() = testDispatcher
}
