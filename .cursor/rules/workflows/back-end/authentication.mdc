# Authentication Workflow for Back-End

## Overview

This workflow provides specialized behavior for back-end authentication components, focusing on secure user authentication, authorization, and identity management. It extends the base back-end workflow with authentication-specific implementation guidelines.

## Workflow Activation

This workflow is automatically attached whenever working with any file in the `back-end/` directory. It extends the base back-end workflow with specialized authentication patterns and security guidance for identity and access management.

## Behavior Specialization

This workflow specializes behavior for authentication development by:

1. **Authentication Patterns**:
   - OAuth2 implementation standards
   - JWT token management
   - Password hashing and validation
   - Multi-factor authentication

2. **Authorization Patterns**:
   - Role-based access control
   - Permission management
   - Scope-based authorization
   - Resource ownership validation

3. **Session Management**:
   - Secure session handling
   - Token rotation strategies
   - Session timeout configuration
   - Device tracking and management

4. **Identity Verification**:
   - User verification workflows
   - Account recovery processes
   - Email/phone verification
   - Identity provider integration

## Security Best Practices

1. **Password Security**:
   - Use Argon2id for password hashing
   - Implement password complexity requirements
   - Prevent password reuse
   - Detect compromised passwords

2. **Token Security**:
   - Short-lived access tokens
   - Secure refresh token handling
   - JWT signing and verification
   - Token revocation mechanisms

3. **Attack Prevention**:
   - Rate limiting on auth endpoints
   - Prevention of timing attacks
   - CSRF protection
   - Brute force detection

4. **Compliance Standards**:
   - GDPR compliance
   - CCPA compliance
   - SOC2 requirements
   - OWASP security standards

## Related Parameters

This workflow integrates with the following parameter files:

- **Plan Mode**: `parameters/back-end/plan-mode/authentication.md`
- **Dev Mode**: `parameters/back-end/dev-mode/authentication.md`
- **Direct Mode**: `parameters/back-end/direct-mode/authentication.md`

## Knowledge Integration

This workflow references the following knowledge components:

- **OAuth2**: `knowledge/back-end/authentication/oauth2.md`
- **JWT**: `knowledge/back-end/authentication/jwt.md`
- **Password Security**: `knowledge/back-end/authentication/password-security.md`
- **Authorization**: `knowledge/back-end/authentication/authorization.md`

## Integration with External Providers

1. **Steam Authentication**:
   - Uses Steam OpenID Connect
   - Integrates with `workflows/back-end/steam-web-api.md`
   - Follows Steam-specific security practices
   - Handles Steam identity verification

2. **Other OAuth Providers**:
   - Google OAuth2 integration
   - Discord OAuth2 integration
   - Facebook OAuth2 integration
   - GitHub OAuth2 integration

## Quality Requirements

Authentication components must meet these quality gates:

1. **Security Testing**: Pass all OWASP security tests
2. **Performance**: Auth operations complete in <200ms
3. **Reliability**: 99.99% uptime for auth services
4. **Compliance**: Pass all regulatory compliance checks

## Implementation Guidelines

1. **Authentication Flow**:
   - Implement proper auth state management
   - Use secure random tokens
   - Apply appropriate token expiration
   - Log authentication events

2. **User Management**:
   - Create comprehensive user model
   - Implement account lifecycle management
   - Handle user metadata securely
   - Support identity merging

3. **Testing Strategy**:
   - Test all auth flows comprehensively
   - Use security-focused test cases
   - Test token validation extensively
   - Verify all error scenarios

4. **Security Monitoring**:
   - Log authentication attempts
   - Track failed login attempts
   - Monitor suspicious activities
   - Implement alerting mechanisms 