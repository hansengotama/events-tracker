// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Event extends DataClass implements Insertable<Event> {
  final int id;
  final int price;
  final String location;
  final String cityLocation;
  final String name;
  Event(
      {@required this.id,
      @required this.price,
      @required this.location,
      @required this.cityLocation,
      @required this.name});
  factory Event.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Event(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      location: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      cityLocation: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}city_location']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || cityLocation != null) {
      map['city_location'] = Variable<String>(cityLocation);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      cityLocation: cityLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(cityLocation),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      price: serializer.fromJson<int>(json['price']),
      location: serializer.fromJson<String>(json['location']),
      cityLocation: serializer.fromJson<String>(json['cityLocation']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'price': serializer.toJson<int>(price),
      'location': serializer.toJson<String>(location),
      'cityLocation': serializer.toJson<String>(cityLocation),
      'name': serializer.toJson<String>(name),
    };
  }

  Event copyWith(
          {int id,
          int price,
          String location,
          String cityLocation,
          String name}) =>
      Event(
        id: id ?? this.id,
        price: price ?? this.price,
        location: location ?? this.location,
        cityLocation: cityLocation ?? this.cityLocation,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('price: $price, ')
          ..write('location: $location, ')
          ..write('cityLocation: $cityLocation, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          price.hashCode,
          $mrjc(location.hashCode,
              $mrjc(cityLocation.hashCode, name.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.price == this.price &&
          other.location == this.location &&
          other.cityLocation == this.cityLocation &&
          other.name == this.name);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<int> price;
  final Value<String> location;
  final Value<String> cityLocation;
  final Value<String> name;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.price = const Value.absent(),
    this.location = const Value.absent(),
    this.cityLocation = const Value.absent(),
    this.name = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    this.price = const Value.absent(),
    @required String location,
    @required String cityLocation,
    @required String name,
  })  : location = Value(location),
        cityLocation = Value(cityLocation),
        name = Value(name);
  static Insertable<Event> custom({
    Expression<int> id,
    Expression<int> price,
    Expression<String> location,
    Expression<String> cityLocation,
    Expression<String> name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (price != null) 'price': price,
      if (location != null) 'location': location,
      if (cityLocation != null) 'city_location': cityLocation,
      if (name != null) 'name': name,
    });
  }

  EventsCompanion copyWith(
      {Value<int> id,
      Value<int> price,
      Value<String> location,
      Value<String> cityLocation,
      Value<String> name}) {
    return EventsCompanion(
      id: id ?? this.id,
      price: price ?? this.price,
      location: location ?? this.location,
      cityLocation: cityLocation ?? this.cityLocation,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (cityLocation.present) {
      map['city_location'] = Variable<String>(cityLocation.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  final GeneratedDatabase _db;
  final String _alias;
  $EventsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn('price', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _locationMeta = const VerificationMeta('location');
  GeneratedTextColumn _location;
  @override
  GeneratedTextColumn get location => _location ??= _constructLocation();
  GeneratedTextColumn _constructLocation() {
    return GeneratedTextColumn(
      'location',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cityLocationMeta =
      const VerificationMeta('cityLocation');
  GeneratedTextColumn _cityLocation;
  @override
  GeneratedTextColumn get cityLocation =>
      _cityLocation ??= _constructCityLocation();
  GeneratedTextColumn _constructCityLocation() {
    return GeneratedTextColumn(
      'city_location',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, price, location, cityLocation, name];
  @override
  $EventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'events';
  @override
  final String actualTableName = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location'], _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('city_location')) {
      context.handle(
          _cityLocationMeta,
          cityLocation.isAcceptableOrUnknown(
              data['city_location'], _cityLocationMeta));
    } else if (isInserting) {
      context.missing(_cityLocationMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Event.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(_db, alias);
  }
}

class TrackEvent extends DataClass implements Insertable<TrackEvent> {
  final int id;
  final int eventId;
  final int index;
  TrackEvent({@required this.id, @required this.eventId, @required this.index});
  factory TrackEvent.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return TrackEvent(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      eventId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}event_id']),
      index: intType.mapFromDatabaseResponse(data['${effectivePrefix}index']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || eventId != null) {
      map['event_id'] = Variable<int>(eventId);
    }
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    return map;
  }

  TrackEventsCompanion toCompanion(bool nullToAbsent) {
    return TrackEventsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      eventId: eventId == null && nullToAbsent
          ? const Value.absent()
          : Value(eventId),
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
    );
  }

  factory TrackEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TrackEvent(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      index: serializer.fromJson<int>(json['index']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'index': serializer.toJson<int>(index),
    };
  }

  TrackEvent copyWith({int id, int eventId, int index}) => TrackEvent(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        index: index ?? this.index,
      );
  @override
  String toString() {
    return (StringBuffer('TrackEvent(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('index: $index')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(eventId.hashCode, index.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TrackEvent &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.index == this.index);
}

class TrackEventsCompanion extends UpdateCompanion<TrackEvent> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<int> index;
  const TrackEventsCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.index = const Value.absent(),
  });
  TrackEventsCompanion.insert({
    this.id = const Value.absent(),
    @required int eventId,
    @required int index,
  })  : eventId = Value(eventId),
        index = Value(index);
  static Insertable<TrackEvent> custom({
    Expression<int> id,
    Expression<int> eventId,
    Expression<int> index,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (index != null) 'index': index,
    });
  }

  TrackEventsCompanion copyWith(
      {Value<int> id, Value<int> eventId, Value<int> index}) {
    return TrackEventsCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      index: index ?? this.index,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    return map;
  }
}

class $TrackEventsTable extends TrackEvents
    with TableInfo<$TrackEventsTable, TrackEvent> {
  final GeneratedDatabase _db;
  final String _alias;
  $TrackEventsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _eventIdMeta = const VerificationMeta('eventId');
  GeneratedIntColumn _eventId;
  @override
  GeneratedIntColumn get eventId => _eventId ??= _constructEventId();
  GeneratedIntColumn _constructEventId() {
    return GeneratedIntColumn(
      'event_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _indexMeta = const VerificationMeta('index');
  GeneratedIntColumn _index;
  @override
  GeneratedIntColumn get index => _index ??= _constructIndex();
  GeneratedIntColumn _constructIndex() {
    return GeneratedIntColumn(
      'index',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, eventId, index];
  @override
  $TrackEventsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'track_events';
  @override
  final String actualTableName = 'track_events';
  @override
  VerificationContext validateIntegrity(Insertable<TrackEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id'], _eventIdMeta));
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index'], _indexMeta));
    } else if (isInserting) {
      context.missing(_indexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackEvent map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TrackEvent.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TrackEventsTable createAlias(String alias) {
    return $TrackEventsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EventsTable _events;
  $EventsTable get events => _events ??= $EventsTable(this);
  $TrackEventsTable _trackEvents;
  $TrackEventsTable get trackEvents => _trackEvents ??= $TrackEventsTable(this);
  EventDao _eventDao;
  EventDao get eventDao => _eventDao ??= EventDao(this as AppDatabase);
  TrackEventDao _trackEventDao;
  TrackEventDao get trackEventDao =>
      _trackEventDao ??= TrackEventDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [events, trackEvents];
}
