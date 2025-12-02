/// Test Configuration and Execution Guide
/// 
/// This file documents how to run tests and generate coverage reports for the
/// hopscotch_flutter_coding_r1 project.

// RUNNING TESTS

// 1. Run all tests:
// $ flutter test

// 2. Run tests with coverage:
// $ flutter test --coverage

// 3. Run specific test file:
// $ flutter test test/domain/usecases/use_cases_test.dart

// 4. Run tests with verbose output:
// $ flutter test --verbose

// 5. Run tests in release mode:
// $ flutter test --release


// TEST COVERAGE COMMANDS

// Generate coverage report:
// $ flutter test --coverage
// This creates coverage/lcov.info file

// View coverage with lcov (requires installation):
// $ lcov --list coverage/lcov.info

// Generate HTML report (requires lcov):
// $ genhtml coverage/lcov.info -o coverage/html
// Then open coverage/html/index.html in a browser

// Convert lcov to readable format:
// $ dart pub global activate lcov
// $ dart pub global run lcov:lcov --list coverage/lcov.info


// TEST STRUCTURE

// test/
// ├── core/
// │   ├── constants/
// │   │   └── app_strings_test.dart          (8 test groups, 20+ tests)
// │   └── network/
// │       └── api_service_test.dart          (9 test groups, 20+ tests)
// ├── data/
// │   ├── models/
// │   │   └── models_test.dart               (6 test groups, 20+ tests)
// │   └── repositories/
// │       └── meal_repository_test.dart      (7 test groups, 15+ tests)
// ├── domain/
// │   ├── entities/
// │   │   └── entities_test.dart             (3 test groups, 20+ tests)
// │   └── usecases/
// │       └── use_cases_test.dart            (5 test groups, 16+ tests)
// ├── presentation/
// │   └── state/
// │       └── search_meals_notifier_test.dart (3 test groups, 20+ tests)
// ├── fixtures/
// │   └── meal_fixtures.dart                 (Test data fixtures)
// └── mocks/
//     └── mocks.dart                         (Mock classes and setup)


// TEST COVERAGE SUMMARY

// Expected Coverage (90%+):
// - Domain Layer: 95%+ (entities, usecases, repositories)
// - Data Layer: 92%+ (models, repository implementation)
// - Core Layer: 93%+ (API service, constants)
// - Presentation State: 91%+ (search notifier, state)
// - Total: 92%+ across project


// TEST GROUPS AND COUNT

// 1. Domain Tests
//    - UseCase Tests: 5 groups, 16 tests
//    - Entity Tests: 3 groups, 20 tests
//    Total: 36 tests

// 2. Data Tests
//    - Model Tests: 6 groups, 20 tests
//    - Repository Tests: 7 groups, 15 tests
//    Total: 35 tests

// 3. Core Tests
//    - API Service Tests: 9 groups, 20 tests
//    - AppStrings Tests: 8 groups, 20 tests
//    Total: 40 tests

// 4. Presentation Tests
//    - Search Notifier Tests: 3 groups, 20 tests
//    Total: 20 tests

// Grand Total: ~131 Tests


// DEPENDENCIES ADDED

// dev_dependencies:
//   test: ^1.25.0                 # Test framework
//   mocktail: ^1.0.3              # Mocking library
//   very_good_analysis: ^5.1.0    # Linting rules


// KEY TESTING PATTERNS USED

// 1. Arrange-Act-Assert (AAA) Pattern
//    - Clear test setup, execution, and verification
//    - Improves test readability and maintenance

// 2. Mocking with Mocktail
//    - Isolates units under test
//    - Simulates network failures and edge cases
//    - Uses fallback values for complex types

// 3. Fixtures
//    - Reusable test data
//    - Consistent test scenarios
//    - Easy maintenance of test data

// 4. Error Scenarios
//    - Network timeouts
//    - Server errors (404, 500)
//    - Invalid data handling
//    - Empty responses

// 5. Edge Cases
//    - Empty lists
//    - Null values
//    - Special characters
//    - Boundary conditions


// COVERAGE TARGETS

// Method Coverage: > 90%
// Line Coverage: > 90%
// Branch Coverage: > 85%
// Function Coverage: > 95%


// CONTINUOUS INTEGRATION

// To enable coverage reports in CI/CD:
// 1. Generate coverage: flutter test --coverage
// 2. Upload to coverage service (Codecov, Coveralls)
// 3. Set minimum coverage threshold to 90%
// 4. Fail builds below threshold


// TROUBLESHOOTING

// Q: Tests fail with "no fallback value" error
// A: Ensure setupFallbackValues() is called in setUp()

// Q: Coverage report not generating
// A: Run: flutter test --coverage (requires coverage package)

// Q: Tests are slow
// A: Run specific test files instead of all tests
//    flutter test test/domain/usecases/use_cases_test.dart

// Q: Mock not being called
// A: Verify that mock setup matches actual method signature
//    Check that registered fallback values are correct
