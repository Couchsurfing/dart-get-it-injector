# 0.6.0 | 9.19.2025

## Features

- Update analyzer
- Update to sdk 3.8.0

# 0.5.6 | 4.11.2025

## Features

- Support injecting alias parameters
  - (Types that are defined with `typedef`)

## Enhancements

- Update Readme

# 0.5.3 | 2.22.2025

## Chore

- Update Dependencies

# 0.5.0 | 1.3.2025

## Features

- Support registering classes that implement multiple interfaces
  - The generator will register the class as the type argument for each interface, while respecting the registration options for each interface (e.g. `singleton`, `factory`, `lazy_singleton`)

# 0.4.0 | 9.27.2024

## Fixes

- Remove null assertions from code
  - If an import was not found, the builder would throw an exception with poor error messaging
  - Now, the builder will throw an exception with a more descriptive error message

# 0.3.1 | 7.11.2024

## Fixes

- When a dart package was added as an import, the name space would be malformed
  - e.g. `dart:core` would be `i_dart:core` which is a syntax error

# 0.3.0 | 6.21.2024

## Breaking Changes

- Force import string to not be null
  - This is a breaking change because an exception will be thrown if the import string is null

# 0.2.1 | 6.7.2024

## Enhancements

- Register classes alphabetically and then by priority

# 0.2.0 | 6.5.2024

## Enhancements

- Sort imports alphabetically

# 0.1.1 | 4.10.2024

## Enhancements

- Change import name from an index `i0` to the name of the file `i_repo`
  - Improves readability and merge conflicts

# 0.1.0+1 | 3.25.2024

Initial Release
