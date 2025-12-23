# Platform Interface

The platform interface defines the contract for platform-specific implementations.

## Architecture

The SDK uses a federated plugin architecture:

- **App-Facing Package**: `health_connector` - what developers import
- **Platform Interface**: `health_connector_core` - shared types and contracts
- **Implementations**: `health_connector_hc_android`, `health_connector_hk_ios`

## For Platform Implementers

Platform implementations should **extend** (not implement) the platform interface
classes. This allows new methods to be added without breaking existing implementations.
