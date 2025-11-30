// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$randomMealsHash() => r'08b9b167b9e53e23bbbf4a1d03d0f1a0af803782';

/// See also [randomMeals].
@ProviderFor(randomMeals)
final randomMealsProvider =
    AutoDisposeFutureProvider<List<MealEntity>>.internal(
  randomMeals,
  name: r'randomMealsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$randomMealsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RandomMealsRef = AutoDisposeFutureProviderRef<List<MealEntity>>;
String _$categoriesHash() => r'63c6d4b7174ff652d0bb91f06090043e7c8d7a28';

/// See also [categories].
@ProviderFor(categories)
final categoriesProvider =
    AutoDisposeFutureProvider<List<CategoryEntity>>.internal(
  categories,
  name: r'categoriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$categoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesRef = AutoDisposeFutureProviderRef<List<CategoryEntity>>;
String _$cousineHash() => r'0bfa533eed9e85e907bdc3ea97df70d7e640f14b';

/// See also [cousine].
@ProviderFor(cousine)
final cousineProvider = AutoDisposeFutureProvider<List<CousinEntity>>.internal(
  cousine,
  name: r'cousineProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cousineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CousineRef = AutoDisposeFutureProviderRef<List<CousinEntity>>;
String _$mealDetailsHash() => r'6da8b247b4b9f6cb12df0524c92b81f97c24c5f4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [mealDetails].
@ProviderFor(mealDetails)
const mealDetailsProvider = MealDetailsFamily();

/// See also [mealDetails].
class MealDetailsFamily extends Family<AsyncValue<List<MealEntity>>> {
  /// See also [mealDetails].
  const MealDetailsFamily();

  /// See also [mealDetails].
  MealDetailsProvider call(
    String mealId,
  ) {
    return MealDetailsProvider(
      mealId,
    );
  }

  @override
  MealDetailsProvider getProviderOverride(
    covariant MealDetailsProvider provider,
  ) {
    return call(
      provider.mealId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mealDetailsProvider';
}

/// See also [mealDetails].
class MealDetailsProvider extends AutoDisposeFutureProvider<List<MealEntity>> {
  /// See also [mealDetails].
  MealDetailsProvider(
    String mealId,
  ) : this._internal(
          (ref) => mealDetails(
            ref as MealDetailsRef,
            mealId,
          ),
          from: mealDetailsProvider,
          name: r'mealDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mealDetailsHash,
          dependencies: MealDetailsFamily._dependencies,
          allTransitiveDependencies:
              MealDetailsFamily._allTransitiveDependencies,
          mealId: mealId,
        );

  MealDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mealId,
  }) : super.internal();

  final String mealId;

  @override
  Override overrideWith(
    FutureOr<List<MealEntity>> Function(MealDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MealDetailsProvider._internal(
        (ref) => create(ref as MealDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mealId: mealId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MealEntity>> createElement() {
    return _MealDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MealDetailsProvider && other.mealId == mealId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mealId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MealDetailsRef on AutoDisposeFutureProviderRef<List<MealEntity>> {
  /// The parameter `mealId` of this provider.
  String get mealId;
}

class _MealDetailsProviderElement
    extends AutoDisposeFutureProviderElement<List<MealEntity>>
    with MealDetailsRef {
  _MealDetailsProviderElement(super.provider);

  @override
  String get mealId => (origin as MealDetailsProvider).mealId;
}

String _$searchHash() => r'a6fb8b0472c11c29fcc2c7b3c6b22f9a3fab7211';

/// See also [search].
@ProviderFor(search)
const searchProvider = SearchFamily();

/// See also [search].
class SearchFamily extends Family<AsyncValue<SearchMealsNotifier>> {
  /// See also [search].
  const SearchFamily();

  /// See also [search].
  SearchProvider call(
    String mealId,
  ) {
    return SearchProvider(
      mealId,
    );
  }

  @override
  SearchProvider getProviderOverride(
    covariant SearchProvider provider,
  ) {
    return call(
      provider.mealId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchProvider';
}

/// See also [search].
class SearchProvider extends AutoDisposeFutureProvider<SearchMealsNotifier> {
  /// See also [search].
  SearchProvider(
    String mealId,
  ) : this._internal(
          (ref) => search(
            ref as SearchRef,
            mealId,
          ),
          from: searchProvider,
          name: r'searchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchHash,
          dependencies: SearchFamily._dependencies,
          allTransitiveDependencies: SearchFamily._allTransitiveDependencies,
          mealId: mealId,
        );

  SearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mealId,
  }) : super.internal();

  final String mealId;

  @override
  Override overrideWith(
    FutureOr<SearchMealsNotifier> Function(SearchRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchProvider._internal(
        (ref) => create(ref as SearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mealId: mealId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SearchMealsNotifier> createElement() {
    return _SearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchProvider && other.mealId == mealId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mealId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchRef on AutoDisposeFutureProviderRef<SearchMealsNotifier> {
  /// The parameter `mealId` of this provider.
  String get mealId;
}

class _SearchProviderElement
    extends AutoDisposeFutureProviderElement<SearchMealsNotifier>
    with SearchRef {
  _SearchProviderElement(super.provider);

  @override
  String get mealId => (origin as SearchProvider).mealId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
