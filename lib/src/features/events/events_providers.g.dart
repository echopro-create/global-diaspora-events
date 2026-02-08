// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(promotedEvents)
final promotedEventsProvider = PromotedEventsProvider._();

final class PromotedEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  PromotedEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promotedEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promotedEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    return promotedEvents(ref);
  }
}

String _$promotedEventsHash() => r'cd320b25c1797ae4d5968930e3bc87e80dc47eb8';

@ProviderFor(nearbyEvents)
final nearbyEventsProvider = NearbyEventsProvider._();

final class NearbyEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  NearbyEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    return nearbyEvents(ref);
  }
}

String _$nearbyEventsHash() => r'5d9c2a6ee3cd2435f536669d0c9d9e17e6ae0be8';

@ProviderFor(personalizedEvents)
final personalizedEventsProvider = PersonalizedEventsProvider._();

final class PersonalizedEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  PersonalizedEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'personalizedEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personalizedEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    return personalizedEvents(ref);
  }
}

String _$personalizedEventsHash() =>
    r'93801a27391062d0ac9c9ce9d4d280634e759c1b';

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Category>>,
          List<Category>,
          FutureOr<List<Category>>
        >
    with $FutureModifier<List<Category>>, $FutureProvider<List<Category>> {
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<Category>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Category>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'8ad67424765f759351ed804d1399783c14535dca';

@ProviderFor(tags)
final tagsProvider = TagsProvider._();

final class TagsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Tag>>,
          List<Tag>,
          FutureOr<List<Tag>>
        >
    with $FutureModifier<List<Tag>>, $FutureProvider<List<Tag>> {
  TagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagsHash();

  @$internal
  @override
  $FutureProviderElement<List<Tag>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Tag>> create(Ref ref) {
    return tags(ref);
  }
}

String _$tagsHash() => r'e035d309fcd0c2459a1a89035186885bfefe22db';

@ProviderFor(eventDetails)
final eventDetailsProvider = EventDetailsFamily._();

final class EventDetailsProvider
    extends $FunctionalProvider<AsyncValue<Event>, Event, FutureOr<Event>>
    with $FutureModifier<Event>, $FutureProvider<Event> {
  EventDetailsProvider._({
    required EventDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailsHash();

  @override
  String toString() {
    return r'eventDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Event> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Event> create(Ref ref) {
    final argument = this.argument as String;
    return eventDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailsHash() => r'55930d7dbbed03888f69fa5581a24e16526cabd2';

final class EventDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Event>, String> {
  EventDetailsFamily._()
    : super(
        retry: null,
        name: r'eventDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventDetailsProvider call(String id) =>
      EventDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'eventDetailsProvider';
}
