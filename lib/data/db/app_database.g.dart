// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DetergentProfilesTable extends DetergentProfiles
    with TableInfo<$DetergentProfilesTable, DetergentProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetergentProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detergentTypeMeta = const VerificationMeta(
    'detergentType',
  );
  @override
  late final GeneratedColumn<String> detergentType = GeneratedColumn<String>(
    'detergent_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleStrategyMeta = const VerificationMeta(
    'ruleStrategy',
  );
  @override
  late final GeneratedColumn<String> ruleStrategy = GeneratedColumn<String>(
    'rule_strategy',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('base_plus_adjustments'),
  );
  static const VerificationMeta _doseBasisMeta = const VerificationMeta(
    'doseBasis',
  );
  @override
  late final GeneratedColumn<String> doseBasis = GeneratedColumn<String>(
    'dose_basis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('load_size'),
  );
  static const VerificationMeta _canonicalUnitMeta = const VerificationMeta(
    'canonicalUnit',
  );
  @override
  late final GeneratedColumn<String> canonicalUnit = GeneratedColumn<String>(
    'canonical_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preferredDisplayUnitMeta =
      const VerificationMeta('preferredDisplayUnit');
  @override
  late final GeneratedColumn<String> preferredDisplayUnit =
      GeneratedColumn<String>(
        'preferred_display_unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _soilEnabledMeta = const VerificationMeta(
    'soilEnabled',
  );
  @override
  late final GeneratedColumn<bool> soilEnabled = GeneratedColumn<bool>(
    'soil_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("soil_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _waterEnabledMeta = const VerificationMeta(
    'waterEnabled',
  );
  @override
  late final GeneratedColumn<bool> waterEnabled = GeneratedColumn<bool>(
    'water_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("water_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _machineVariantMeta = const VerificationMeta(
    'machineVariant',
  );
  @override
  late final GeneratedColumn<String> machineVariant = GeneratedColumn<String>(
    'machine_variant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('any'),
  );
  static const VerificationMeta _unknownWaterFallbackMeta =
      const VerificationMeta('unknownWaterFallback');
  @override
  late final GeneratedColumn<String> unknownWaterFallback =
      GeneratedColumn<String>(
        'unknown_water_fallback',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _packageQuantityCanonicalMeta =
      const VerificationMeta('packageQuantityCanonical');
  @override
  late final GeneratedColumn<double> packageQuantityCanonical =
      GeneratedColumn<double>(
        'package_quantity_canonical',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _packagePriceMeta = const VerificationMeta(
    'packagePrice',
  );
  @override
  late final GeneratedColumn<double> packagePrice = GeneratedColumn<double>(
    'package_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoRelativePathMeta = const VerificationMeta(
    'photoRelativePath',
  );
  @override
  late final GeneratedColumn<String> photoRelativePath =
      GeneratedColumn<String>(
        'photo_relative_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtUtcMeta = const VerificationMeta(
    'updatedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAtUtc = GeneratedColumn<DateTime>(
    'updated_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    brand,
    detergentType,
    ruleStrategy,
    doseBasis,
    canonicalUnit,
    preferredDisplayUnit,
    soilEnabled,
    waterEnabled,
    machineVariant,
    unknownWaterFallback,
    packageQuantityCanonical,
    packagePrice,
    currencyCode,
    photoRelativePath,
    isDefault,
    createdAtUtc,
    updatedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detergent_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<DetergentProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('detergent_type')) {
      context.handle(
        _detergentTypeMeta,
        detergentType.isAcceptableOrUnknown(
          data['detergent_type']!,
          _detergentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detergentTypeMeta);
    }
    if (data.containsKey('rule_strategy')) {
      context.handle(
        _ruleStrategyMeta,
        ruleStrategy.isAcceptableOrUnknown(
          data['rule_strategy']!,
          _ruleStrategyMeta,
        ),
      );
    }
    if (data.containsKey('dose_basis')) {
      context.handle(
        _doseBasisMeta,
        doseBasis.isAcceptableOrUnknown(data['dose_basis']!, _doseBasisMeta),
      );
    }
    if (data.containsKey('canonical_unit')) {
      context.handle(
        _canonicalUnitMeta,
        canonicalUnit.isAcceptableOrUnknown(
          data['canonical_unit']!,
          _canonicalUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalUnitMeta);
    }
    if (data.containsKey('preferred_display_unit')) {
      context.handle(
        _preferredDisplayUnitMeta,
        preferredDisplayUnit.isAcceptableOrUnknown(
          data['preferred_display_unit']!,
          _preferredDisplayUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferredDisplayUnitMeta);
    }
    if (data.containsKey('soil_enabled')) {
      context.handle(
        _soilEnabledMeta,
        soilEnabled.isAcceptableOrUnknown(
          data['soil_enabled']!,
          _soilEnabledMeta,
        ),
      );
    }
    if (data.containsKey('water_enabled')) {
      context.handle(
        _waterEnabledMeta,
        waterEnabled.isAcceptableOrUnknown(
          data['water_enabled']!,
          _waterEnabledMeta,
        ),
      );
    }
    if (data.containsKey('machine_variant')) {
      context.handle(
        _machineVariantMeta,
        machineVariant.isAcceptableOrUnknown(
          data['machine_variant']!,
          _machineVariantMeta,
        ),
      );
    }
    if (data.containsKey('unknown_water_fallback')) {
      context.handle(
        _unknownWaterFallbackMeta,
        unknownWaterFallback.isAcceptableOrUnknown(
          data['unknown_water_fallback']!,
          _unknownWaterFallbackMeta,
        ),
      );
    }
    if (data.containsKey('package_quantity_canonical')) {
      context.handle(
        _packageQuantityCanonicalMeta,
        packageQuantityCanonical.isAcceptableOrUnknown(
          data['package_quantity_canonical']!,
          _packageQuantityCanonicalMeta,
        ),
      );
    }
    if (data.containsKey('package_price')) {
      context.handle(
        _packagePriceMeta,
        packagePrice.isAcceptableOrUnknown(
          data['package_price']!,
          _packagePriceMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('photo_relative_path')) {
      context.handle(
        _photoRelativePathMeta,
        photoRelativePath.isAcceptableOrUnknown(
          data['photo_relative_path']!,
          _photoRelativePathMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('updated_at_utc')) {
      context.handle(
        _updatedAtUtcMeta,
        updatedAtUtc.isAcceptableOrUnknown(
          data['updated_at_utc']!,
          _updatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetergentProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetergentProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      detergentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detergent_type'],
      )!,
      ruleStrategy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_strategy'],
      )!,
      doseBasis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose_basis'],
      )!,
      canonicalUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_unit'],
      )!,
      preferredDisplayUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_display_unit'],
      )!,
      soilEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}soil_enabled'],
      )!,
      waterEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}water_enabled'],
      )!,
      machineVariant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}machine_variant'],
      )!,
      unknownWaterFallback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unknown_water_fallback'],
      ),
      packageQuantityCanonical: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}package_quantity_canonical'],
      ),
      packagePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}package_price'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      ),
      photoRelativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_relative_path'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      updatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at_utc'],
      )!,
    );
  }

  @override
  $DetergentProfilesTable createAlias(String alias) {
    return $DetergentProfilesTable(attachedDatabase, alias);
  }
}

class DetergentProfile extends DataClass
    implements Insertable<DetergentProfile> {
  final String id;
  final String name;
  final String? brand;
  final String detergentType;
  final String ruleStrategy;
  final String doseBasis;
  final String canonicalUnit;
  final String preferredDisplayUnit;
  final bool soilEnabled;
  final bool waterEnabled;
  final String machineVariant;
  final String? unknownWaterFallback;
  final double? packageQuantityCanonical;
  final double? packagePrice;
  final String? currencyCode;
  final String? photoRelativePath;
  final bool isDefault;
  final DateTime createdAtUtc;
  final DateTime updatedAtUtc;
  const DetergentProfile({
    required this.id,
    required this.name,
    this.brand,
    required this.detergentType,
    required this.ruleStrategy,
    required this.doseBasis,
    required this.canonicalUnit,
    required this.preferredDisplayUnit,
    required this.soilEnabled,
    required this.waterEnabled,
    required this.machineVariant,
    this.unknownWaterFallback,
    this.packageQuantityCanonical,
    this.packagePrice,
    this.currencyCode,
    this.photoRelativePath,
    required this.isDefault,
    required this.createdAtUtc,
    required this.updatedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    map['detergent_type'] = Variable<String>(detergentType);
    map['rule_strategy'] = Variable<String>(ruleStrategy);
    map['dose_basis'] = Variable<String>(doseBasis);
    map['canonical_unit'] = Variable<String>(canonicalUnit);
    map['preferred_display_unit'] = Variable<String>(preferredDisplayUnit);
    map['soil_enabled'] = Variable<bool>(soilEnabled);
    map['water_enabled'] = Variable<bool>(waterEnabled);
    map['machine_variant'] = Variable<String>(machineVariant);
    if (!nullToAbsent || unknownWaterFallback != null) {
      map['unknown_water_fallback'] = Variable<String>(unknownWaterFallback);
    }
    if (!nullToAbsent || packageQuantityCanonical != null) {
      map['package_quantity_canonical'] = Variable<double>(
        packageQuantityCanonical,
      );
    }
    if (!nullToAbsent || packagePrice != null) {
      map['package_price'] = Variable<double>(packagePrice);
    }
    if (!nullToAbsent || currencyCode != null) {
      map['currency_code'] = Variable<String>(currencyCode);
    }
    if (!nullToAbsent || photoRelativePath != null) {
      map['photo_relative_path'] = Variable<String>(photoRelativePath);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc);
    return map;
  }

  DetergentProfilesCompanion toCompanion(bool nullToAbsent) {
    return DetergentProfilesCompanion(
      id: Value(id),
      name: Value(name),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      detergentType: Value(detergentType),
      ruleStrategy: Value(ruleStrategy),
      doseBasis: Value(doseBasis),
      canonicalUnit: Value(canonicalUnit),
      preferredDisplayUnit: Value(preferredDisplayUnit),
      soilEnabled: Value(soilEnabled),
      waterEnabled: Value(waterEnabled),
      machineVariant: Value(machineVariant),
      unknownWaterFallback: unknownWaterFallback == null && nullToAbsent
          ? const Value.absent()
          : Value(unknownWaterFallback),
      packageQuantityCanonical: packageQuantityCanonical == null && nullToAbsent
          ? const Value.absent()
          : Value(packageQuantityCanonical),
      packagePrice: packagePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(packagePrice),
      currencyCode: currencyCode == null && nullToAbsent
          ? const Value.absent()
          : Value(currencyCode),
      photoRelativePath: photoRelativePath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoRelativePath),
      isDefault: Value(isDefault),
      createdAtUtc: Value(createdAtUtc),
      updatedAtUtc: Value(updatedAtUtc),
    );
  }

  factory DetergentProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetergentProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String?>(json['brand']),
      detergentType: serializer.fromJson<String>(json['detergentType']),
      ruleStrategy: serializer.fromJson<String>(json['ruleStrategy']),
      doseBasis: serializer.fromJson<String>(json['doseBasis']),
      canonicalUnit: serializer.fromJson<String>(json['canonicalUnit']),
      preferredDisplayUnit: serializer.fromJson<String>(
        json['preferredDisplayUnit'],
      ),
      soilEnabled: serializer.fromJson<bool>(json['soilEnabled']),
      waterEnabled: serializer.fromJson<bool>(json['waterEnabled']),
      machineVariant: serializer.fromJson<String>(json['machineVariant']),
      unknownWaterFallback: serializer.fromJson<String?>(
        json['unknownWaterFallback'],
      ),
      packageQuantityCanonical: serializer.fromJson<double?>(
        json['packageQuantityCanonical'],
      ),
      packagePrice: serializer.fromJson<double?>(json['packagePrice']),
      currencyCode: serializer.fromJson<String?>(json['currencyCode']),
      photoRelativePath: serializer.fromJson<String?>(
        json['photoRelativePath'],
      ),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      updatedAtUtc: serializer.fromJson<DateTime>(json['updatedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String?>(brand),
      'detergentType': serializer.toJson<String>(detergentType),
      'ruleStrategy': serializer.toJson<String>(ruleStrategy),
      'doseBasis': serializer.toJson<String>(doseBasis),
      'canonicalUnit': serializer.toJson<String>(canonicalUnit),
      'preferredDisplayUnit': serializer.toJson<String>(preferredDisplayUnit),
      'soilEnabled': serializer.toJson<bool>(soilEnabled),
      'waterEnabled': serializer.toJson<bool>(waterEnabled),
      'machineVariant': serializer.toJson<String>(machineVariant),
      'unknownWaterFallback': serializer.toJson<String?>(unknownWaterFallback),
      'packageQuantityCanonical': serializer.toJson<double?>(
        packageQuantityCanonical,
      ),
      'packagePrice': serializer.toJson<double?>(packagePrice),
      'currencyCode': serializer.toJson<String?>(currencyCode),
      'photoRelativePath': serializer.toJson<String?>(photoRelativePath),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'updatedAtUtc': serializer.toJson<DateTime>(updatedAtUtc),
    };
  }

  DetergentProfile copyWith({
    String? id,
    String? name,
    Value<String?> brand = const Value.absent(),
    String? detergentType,
    String? ruleStrategy,
    String? doseBasis,
    String? canonicalUnit,
    String? preferredDisplayUnit,
    bool? soilEnabled,
    bool? waterEnabled,
    String? machineVariant,
    Value<String?> unknownWaterFallback = const Value.absent(),
    Value<double?> packageQuantityCanonical = const Value.absent(),
    Value<double?> packagePrice = const Value.absent(),
    Value<String?> currencyCode = const Value.absent(),
    Value<String?> photoRelativePath = const Value.absent(),
    bool? isDefault,
    DateTime? createdAtUtc,
    DateTime? updatedAtUtc,
  }) => DetergentProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    brand: brand.present ? brand.value : this.brand,
    detergentType: detergentType ?? this.detergentType,
    ruleStrategy: ruleStrategy ?? this.ruleStrategy,
    doseBasis: doseBasis ?? this.doseBasis,
    canonicalUnit: canonicalUnit ?? this.canonicalUnit,
    preferredDisplayUnit: preferredDisplayUnit ?? this.preferredDisplayUnit,
    soilEnabled: soilEnabled ?? this.soilEnabled,
    waterEnabled: waterEnabled ?? this.waterEnabled,
    machineVariant: machineVariant ?? this.machineVariant,
    unknownWaterFallback: unknownWaterFallback.present
        ? unknownWaterFallback.value
        : this.unknownWaterFallback,
    packageQuantityCanonical: packageQuantityCanonical.present
        ? packageQuantityCanonical.value
        : this.packageQuantityCanonical,
    packagePrice: packagePrice.present ? packagePrice.value : this.packagePrice,
    currencyCode: currencyCode.present ? currencyCode.value : this.currencyCode,
    photoRelativePath: photoRelativePath.present
        ? photoRelativePath.value
        : this.photoRelativePath,
    isDefault: isDefault ?? this.isDefault,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
  );
  DetergentProfile copyWithCompanion(DetergentProfilesCompanion data) {
    return DetergentProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      detergentType: data.detergentType.present
          ? data.detergentType.value
          : this.detergentType,
      ruleStrategy: data.ruleStrategy.present
          ? data.ruleStrategy.value
          : this.ruleStrategy,
      doseBasis: data.doseBasis.present ? data.doseBasis.value : this.doseBasis,
      canonicalUnit: data.canonicalUnit.present
          ? data.canonicalUnit.value
          : this.canonicalUnit,
      preferredDisplayUnit: data.preferredDisplayUnit.present
          ? data.preferredDisplayUnit.value
          : this.preferredDisplayUnit,
      soilEnabled: data.soilEnabled.present
          ? data.soilEnabled.value
          : this.soilEnabled,
      waterEnabled: data.waterEnabled.present
          ? data.waterEnabled.value
          : this.waterEnabled,
      machineVariant: data.machineVariant.present
          ? data.machineVariant.value
          : this.machineVariant,
      unknownWaterFallback: data.unknownWaterFallback.present
          ? data.unknownWaterFallback.value
          : this.unknownWaterFallback,
      packageQuantityCanonical: data.packageQuantityCanonical.present
          ? data.packageQuantityCanonical.value
          : this.packageQuantityCanonical,
      packagePrice: data.packagePrice.present
          ? data.packagePrice.value
          : this.packagePrice,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      photoRelativePath: data.photoRelativePath.present
          ? data.photoRelativePath.value
          : this.photoRelativePath,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      updatedAtUtc: data.updatedAtUtc.present
          ? data.updatedAtUtc.value
          : this.updatedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetergentProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('detergentType: $detergentType, ')
          ..write('ruleStrategy: $ruleStrategy, ')
          ..write('doseBasis: $doseBasis, ')
          ..write('canonicalUnit: $canonicalUnit, ')
          ..write('preferredDisplayUnit: $preferredDisplayUnit, ')
          ..write('soilEnabled: $soilEnabled, ')
          ..write('waterEnabled: $waterEnabled, ')
          ..write('machineVariant: $machineVariant, ')
          ..write('unknownWaterFallback: $unknownWaterFallback, ')
          ..write('packageQuantityCanonical: $packageQuantityCanonical, ')
          ..write('packagePrice: $packagePrice, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('photoRelativePath: $photoRelativePath, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    brand,
    detergentType,
    ruleStrategy,
    doseBasis,
    canonicalUnit,
    preferredDisplayUnit,
    soilEnabled,
    waterEnabled,
    machineVariant,
    unknownWaterFallback,
    packageQuantityCanonical,
    packagePrice,
    currencyCode,
    photoRelativePath,
    isDefault,
    createdAtUtc,
    updatedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetergentProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.detergentType == this.detergentType &&
          other.ruleStrategy == this.ruleStrategy &&
          other.doseBasis == this.doseBasis &&
          other.canonicalUnit == this.canonicalUnit &&
          other.preferredDisplayUnit == this.preferredDisplayUnit &&
          other.soilEnabled == this.soilEnabled &&
          other.waterEnabled == this.waterEnabled &&
          other.machineVariant == this.machineVariant &&
          other.unknownWaterFallback == this.unknownWaterFallback &&
          other.packageQuantityCanonical == this.packageQuantityCanonical &&
          other.packagePrice == this.packagePrice &&
          other.currencyCode == this.currencyCode &&
          other.photoRelativePath == this.photoRelativePath &&
          other.isDefault == this.isDefault &&
          other.createdAtUtc == this.createdAtUtc &&
          other.updatedAtUtc == this.updatedAtUtc);
}

class DetergentProfilesCompanion extends UpdateCompanion<DetergentProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> brand;
  final Value<String> detergentType;
  final Value<String> ruleStrategy;
  final Value<String> doseBasis;
  final Value<String> canonicalUnit;
  final Value<String> preferredDisplayUnit;
  final Value<bool> soilEnabled;
  final Value<bool> waterEnabled;
  final Value<String> machineVariant;
  final Value<String?> unknownWaterFallback;
  final Value<double?> packageQuantityCanonical;
  final Value<double?> packagePrice;
  final Value<String?> currencyCode;
  final Value<String?> photoRelativePath;
  final Value<bool> isDefault;
  final Value<DateTime> createdAtUtc;
  final Value<DateTime> updatedAtUtc;
  final Value<int> rowid;
  const DetergentProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.detergentType = const Value.absent(),
    this.ruleStrategy = const Value.absent(),
    this.doseBasis = const Value.absent(),
    this.canonicalUnit = const Value.absent(),
    this.preferredDisplayUnit = const Value.absent(),
    this.soilEnabled = const Value.absent(),
    this.waterEnabled = const Value.absent(),
    this.machineVariant = const Value.absent(),
    this.unknownWaterFallback = const Value.absent(),
    this.packageQuantityCanonical = const Value.absent(),
    this.packagePrice = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.photoRelativePath = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.updatedAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DetergentProfilesCompanion.insert({
    required String id,
    required String name,
    this.brand = const Value.absent(),
    required String detergentType,
    this.ruleStrategy = const Value.absent(),
    this.doseBasis = const Value.absent(),
    required String canonicalUnit,
    required String preferredDisplayUnit,
    this.soilEnabled = const Value.absent(),
    this.waterEnabled = const Value.absent(),
    this.machineVariant = const Value.absent(),
    this.unknownWaterFallback = const Value.absent(),
    this.packageQuantityCanonical = const Value.absent(),
    this.packagePrice = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.photoRelativePath = const Value.absent(),
    this.isDefault = const Value.absent(),
    required DateTime createdAtUtc,
    required DateTime updatedAtUtc,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       detergentType = Value(detergentType),
       canonicalUnit = Value(canonicalUnit),
       preferredDisplayUnit = Value(preferredDisplayUnit),
       createdAtUtc = Value(createdAtUtc),
       updatedAtUtc = Value(updatedAtUtc);
  static Insertable<DetergentProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<String>? detergentType,
    Expression<String>? ruleStrategy,
    Expression<String>? doseBasis,
    Expression<String>? canonicalUnit,
    Expression<String>? preferredDisplayUnit,
    Expression<bool>? soilEnabled,
    Expression<bool>? waterEnabled,
    Expression<String>? machineVariant,
    Expression<String>? unknownWaterFallback,
    Expression<double>? packageQuantityCanonical,
    Expression<double>? packagePrice,
    Expression<String>? currencyCode,
    Expression<String>? photoRelativePath,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAtUtc,
    Expression<DateTime>? updatedAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (detergentType != null) 'detergent_type': detergentType,
      if (ruleStrategy != null) 'rule_strategy': ruleStrategy,
      if (doseBasis != null) 'dose_basis': doseBasis,
      if (canonicalUnit != null) 'canonical_unit': canonicalUnit,
      if (preferredDisplayUnit != null)
        'preferred_display_unit': preferredDisplayUnit,
      if (soilEnabled != null) 'soil_enabled': soilEnabled,
      if (waterEnabled != null) 'water_enabled': waterEnabled,
      if (machineVariant != null) 'machine_variant': machineVariant,
      if (unknownWaterFallback != null)
        'unknown_water_fallback': unknownWaterFallback,
      if (packageQuantityCanonical != null)
        'package_quantity_canonical': packageQuantityCanonical,
      if (packagePrice != null) 'package_price': packagePrice,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (photoRelativePath != null) 'photo_relative_path': photoRelativePath,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (updatedAtUtc != null) 'updated_at_utc': updatedAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DetergentProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? brand,
    Value<String>? detergentType,
    Value<String>? ruleStrategy,
    Value<String>? doseBasis,
    Value<String>? canonicalUnit,
    Value<String>? preferredDisplayUnit,
    Value<bool>? soilEnabled,
    Value<bool>? waterEnabled,
    Value<String>? machineVariant,
    Value<String?>? unknownWaterFallback,
    Value<double?>? packageQuantityCanonical,
    Value<double?>? packagePrice,
    Value<String?>? currencyCode,
    Value<String?>? photoRelativePath,
    Value<bool>? isDefault,
    Value<DateTime>? createdAtUtc,
    Value<DateTime>? updatedAtUtc,
    Value<int>? rowid,
  }) {
    return DetergentProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      detergentType: detergentType ?? this.detergentType,
      ruleStrategy: ruleStrategy ?? this.ruleStrategy,
      doseBasis: doseBasis ?? this.doseBasis,
      canonicalUnit: canonicalUnit ?? this.canonicalUnit,
      preferredDisplayUnit: preferredDisplayUnit ?? this.preferredDisplayUnit,
      soilEnabled: soilEnabled ?? this.soilEnabled,
      waterEnabled: waterEnabled ?? this.waterEnabled,
      machineVariant: machineVariant ?? this.machineVariant,
      unknownWaterFallback: unknownWaterFallback ?? this.unknownWaterFallback,
      packageQuantityCanonical:
          packageQuantityCanonical ?? this.packageQuantityCanonical,
      packagePrice: packagePrice ?? this.packagePrice,
      currencyCode: currencyCode ?? this.currencyCode,
      photoRelativePath: photoRelativePath ?? this.photoRelativePath,
      isDefault: isDefault ?? this.isDefault,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (detergentType.present) {
      map['detergent_type'] = Variable<String>(detergentType.value);
    }
    if (ruleStrategy.present) {
      map['rule_strategy'] = Variable<String>(ruleStrategy.value);
    }
    if (doseBasis.present) {
      map['dose_basis'] = Variable<String>(doseBasis.value);
    }
    if (canonicalUnit.present) {
      map['canonical_unit'] = Variable<String>(canonicalUnit.value);
    }
    if (preferredDisplayUnit.present) {
      map['preferred_display_unit'] = Variable<String>(
        preferredDisplayUnit.value,
      );
    }
    if (soilEnabled.present) {
      map['soil_enabled'] = Variable<bool>(soilEnabled.value);
    }
    if (waterEnabled.present) {
      map['water_enabled'] = Variable<bool>(waterEnabled.value);
    }
    if (machineVariant.present) {
      map['machine_variant'] = Variable<String>(machineVariant.value);
    }
    if (unknownWaterFallback.present) {
      map['unknown_water_fallback'] = Variable<String>(
        unknownWaterFallback.value,
      );
    }
    if (packageQuantityCanonical.present) {
      map['package_quantity_canonical'] = Variable<double>(
        packageQuantityCanonical.value,
      );
    }
    if (packagePrice.present) {
      map['package_price'] = Variable<double>(packagePrice.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (photoRelativePath.present) {
      map['photo_relative_path'] = Variable<String>(photoRelativePath.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (updatedAtUtc.present) {
      map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetergentProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('detergentType: $detergentType, ')
          ..write('ruleStrategy: $ruleStrategy, ')
          ..write('doseBasis: $doseBasis, ')
          ..write('canonicalUnit: $canonicalUnit, ')
          ..write('preferredDisplayUnit: $preferredDisplayUnit, ')
          ..write('soilEnabled: $soilEnabled, ')
          ..write('waterEnabled: $waterEnabled, ')
          ..write('machineVariant: $machineVariant, ')
          ..write('unknownWaterFallback: $unknownWaterFallback, ')
          ..write('packageQuantityCanonical: $packageQuantityCanonical, ')
          ..write('packagePrice: $packagePrice, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('photoRelativePath: $photoRelativePath, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DoseRulesTable extends DoseRules
    with TableInfo<$DoseRulesTable, DoseRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoseRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detergentIdMeta = const VerificationMeta(
    'detergentId',
  );
  @override
  late final GeneratedColumn<String> detergentId = GeneratedColumn<String>(
    'detergent_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES detergent_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _loadLevelMeta = const VerificationMeta(
    'loadLevel',
  );
  @override
  late final GeneratedColumn<String> loadLevel = GeneratedColumn<String>(
    'load_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _soilLevelMeta = const VerificationMeta(
    'soilLevel',
  );
  @override
  late final GeneratedColumn<String> soilLevel = GeneratedColumn<String>(
    'soil_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterLevelMeta = const VerificationMeta(
    'waterLevel',
  );
  @override
  late final GeneratedColumn<String> waterLevel = GeneratedColumn<String>(
    'water_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountCanonicalMeta = const VerificationMeta(
    'amountCanonical',
  );
  @override
  late final GeneratedColumn<double> amountCanonical = GeneratedColumn<double>(
    'amount_canonical',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    detergentId,
    loadLevel,
    soilLevel,
    waterLevel,
    amountCanonical,
    createdAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dose_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoseRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('detergent_id')) {
      context.handle(
        _detergentIdMeta,
        detergentId.isAcceptableOrUnknown(
          data['detergent_id']!,
          _detergentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detergentIdMeta);
    }
    if (data.containsKey('load_level')) {
      context.handle(
        _loadLevelMeta,
        loadLevel.isAcceptableOrUnknown(data['load_level']!, _loadLevelMeta),
      );
    }
    if (data.containsKey('soil_level')) {
      context.handle(
        _soilLevelMeta,
        soilLevel.isAcceptableOrUnknown(data['soil_level']!, _soilLevelMeta),
      );
    }
    if (data.containsKey('water_level')) {
      context.handle(
        _waterLevelMeta,
        waterLevel.isAcceptableOrUnknown(data['water_level']!, _waterLevelMeta),
      );
    }
    if (data.containsKey('amount_canonical')) {
      context.handle(
        _amountCanonicalMeta,
        amountCanonical.isAcceptableOrUnknown(
          data['amount_canonical']!,
          _amountCanonicalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCanonicalMeta);
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoseRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoseRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      detergentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detergent_id'],
      )!,
      loadLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}load_level'],
      ),
      soilLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}soil_level'],
      ),
      waterLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}water_level'],
      ),
      amountCanonical: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_canonical'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $DoseRulesTable createAlias(String alias) {
    return $DoseRulesTable(attachedDatabase, alias);
  }
}

class DoseRule extends DataClass implements Insertable<DoseRule> {
  final String id;
  final String detergentId;
  final String? loadLevel;
  final String? soilLevel;
  final String? waterLevel;
  final double amountCanonical;
  final DateTime createdAtUtc;
  const DoseRule({
    required this.id,
    required this.detergentId,
    this.loadLevel,
    this.soilLevel,
    this.waterLevel,
    required this.amountCanonical,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['detergent_id'] = Variable<String>(detergentId);
    if (!nullToAbsent || loadLevel != null) {
      map['load_level'] = Variable<String>(loadLevel);
    }
    if (!nullToAbsent || soilLevel != null) {
      map['soil_level'] = Variable<String>(soilLevel);
    }
    if (!nullToAbsent || waterLevel != null) {
      map['water_level'] = Variable<String>(waterLevel);
    }
    map['amount_canonical'] = Variable<double>(amountCanonical);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  DoseRulesCompanion toCompanion(bool nullToAbsent) {
    return DoseRulesCompanion(
      id: Value(id),
      detergentId: Value(detergentId),
      loadLevel: loadLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(loadLevel),
      soilLevel: soilLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(soilLevel),
      waterLevel: waterLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(waterLevel),
      amountCanonical: Value(amountCanonical),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory DoseRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoseRule(
      id: serializer.fromJson<String>(json['id']),
      detergentId: serializer.fromJson<String>(json['detergentId']),
      loadLevel: serializer.fromJson<String?>(json['loadLevel']),
      soilLevel: serializer.fromJson<String?>(json['soilLevel']),
      waterLevel: serializer.fromJson<String?>(json['waterLevel']),
      amountCanonical: serializer.fromJson<double>(json['amountCanonical']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'detergentId': serializer.toJson<String>(detergentId),
      'loadLevel': serializer.toJson<String?>(loadLevel),
      'soilLevel': serializer.toJson<String?>(soilLevel),
      'waterLevel': serializer.toJson<String?>(waterLevel),
      'amountCanonical': serializer.toJson<double>(amountCanonical),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  DoseRule copyWith({
    String? id,
    String? detergentId,
    Value<String?> loadLevel = const Value.absent(),
    Value<String?> soilLevel = const Value.absent(),
    Value<String?> waterLevel = const Value.absent(),
    double? amountCanonical,
    DateTime? createdAtUtc,
  }) => DoseRule(
    id: id ?? this.id,
    detergentId: detergentId ?? this.detergentId,
    loadLevel: loadLevel.present ? loadLevel.value : this.loadLevel,
    soilLevel: soilLevel.present ? soilLevel.value : this.soilLevel,
    waterLevel: waterLevel.present ? waterLevel.value : this.waterLevel,
    amountCanonical: amountCanonical ?? this.amountCanonical,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  DoseRule copyWithCompanion(DoseRulesCompanion data) {
    return DoseRule(
      id: data.id.present ? data.id.value : this.id,
      detergentId: data.detergentId.present
          ? data.detergentId.value
          : this.detergentId,
      loadLevel: data.loadLevel.present ? data.loadLevel.value : this.loadLevel,
      soilLevel: data.soilLevel.present ? data.soilLevel.value : this.soilLevel,
      waterLevel: data.waterLevel.present
          ? data.waterLevel.value
          : this.waterLevel,
      amountCanonical: data.amountCanonical.present
          ? data.amountCanonical.value
          : this.amountCanonical,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoseRule(')
          ..write('id: $id, ')
          ..write('detergentId: $detergentId, ')
          ..write('loadLevel: $loadLevel, ')
          ..write('soilLevel: $soilLevel, ')
          ..write('waterLevel: $waterLevel, ')
          ..write('amountCanonical: $amountCanonical, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    detergentId,
    loadLevel,
    soilLevel,
    waterLevel,
    amountCanonical,
    createdAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoseRule &&
          other.id == this.id &&
          other.detergentId == this.detergentId &&
          other.loadLevel == this.loadLevel &&
          other.soilLevel == this.soilLevel &&
          other.waterLevel == this.waterLevel &&
          other.amountCanonical == this.amountCanonical &&
          other.createdAtUtc == this.createdAtUtc);
}

class DoseRulesCompanion extends UpdateCompanion<DoseRule> {
  final Value<String> id;
  final Value<String> detergentId;
  final Value<String?> loadLevel;
  final Value<String?> soilLevel;
  final Value<String?> waterLevel;
  final Value<double> amountCanonical;
  final Value<DateTime> createdAtUtc;
  final Value<int> rowid;
  const DoseRulesCompanion({
    this.id = const Value.absent(),
    this.detergentId = const Value.absent(),
    this.loadLevel = const Value.absent(),
    this.soilLevel = const Value.absent(),
    this.waterLevel = const Value.absent(),
    this.amountCanonical = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoseRulesCompanion.insert({
    required String id,
    required String detergentId,
    this.loadLevel = const Value.absent(),
    this.soilLevel = const Value.absent(),
    this.waterLevel = const Value.absent(),
    required double amountCanonical,
    required DateTime createdAtUtc,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       detergentId = Value(detergentId),
       amountCanonical = Value(amountCanonical),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<DoseRule> custom({
    Expression<String>? id,
    Expression<String>? detergentId,
    Expression<String>? loadLevel,
    Expression<String>? soilLevel,
    Expression<String>? waterLevel,
    Expression<double>? amountCanonical,
    Expression<DateTime>? createdAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (detergentId != null) 'detergent_id': detergentId,
      if (loadLevel != null) 'load_level': loadLevel,
      if (soilLevel != null) 'soil_level': soilLevel,
      if (waterLevel != null) 'water_level': waterLevel,
      if (amountCanonical != null) 'amount_canonical': amountCanonical,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoseRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? detergentId,
    Value<String?>? loadLevel,
    Value<String?>? soilLevel,
    Value<String?>? waterLevel,
    Value<double>? amountCanonical,
    Value<DateTime>? createdAtUtc,
    Value<int>? rowid,
  }) {
    return DoseRulesCompanion(
      id: id ?? this.id,
      detergentId: detergentId ?? this.detergentId,
      loadLevel: loadLevel ?? this.loadLevel,
      soilLevel: soilLevel ?? this.soilLevel,
      waterLevel: waterLevel ?? this.waterLevel,
      amountCanonical: amountCanonical ?? this.amountCanonical,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (detergentId.present) {
      map['detergent_id'] = Variable<String>(detergentId.value);
    }
    if (loadLevel.present) {
      map['load_level'] = Variable<String>(loadLevel.value);
    }
    if (soilLevel.present) {
      map['soil_level'] = Variable<String>(soilLevel.value);
    }
    if (waterLevel.present) {
      map['water_level'] = Variable<String>(waterLevel.value);
    }
    if (amountCanonical.present) {
      map['amount_canonical'] = Variable<double>(amountCanonical.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoseRulesCompanion(')
          ..write('id: $id, ')
          ..write('detergentId: $detergentId, ')
          ..write('loadLevel: $loadLevel, ')
          ..write('soilLevel: $soilLevel, ')
          ..write('waterLevel: $waterLevel, ')
          ..write('amountCanonical: $amountCanonical, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DoseAdjustmentsTable extends DoseAdjustments
    with TableInfo<$DoseAdjustmentsTable, DoseAdjustment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoseAdjustmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detergentIdMeta = const VerificationMeta(
    'detergentId',
  );
  @override
  late final GeneratedColumn<String> detergentId = GeneratedColumn<String>(
    'detergent_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES detergent_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dimensionMeta = const VerificationMeta(
    'dimension',
  );
  @override
  late final GeneratedColumn<String> dimension = GeneratedColumn<String>(
    'dimension',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionKeyMeta = const VerificationMeta(
    'optionKey',
  );
  @override
  late final GeneratedColumn<String> optionKey = GeneratedColumn<String>(
    'option_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deltaCanonicalMeta = const VerificationMeta(
    'deltaCanonical',
  );
  @override
  late final GeneratedColumn<double> deltaCanonical = GeneratedColumn<double>(
    'delta_canonical',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    detergentId,
    dimension,
    optionKey,
    deltaCanonical,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dose_adjustments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoseAdjustment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('detergent_id')) {
      context.handle(
        _detergentIdMeta,
        detergentId.isAcceptableOrUnknown(
          data['detergent_id']!,
          _detergentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detergentIdMeta);
    }
    if (data.containsKey('dimension')) {
      context.handle(
        _dimensionMeta,
        dimension.isAcceptableOrUnknown(data['dimension']!, _dimensionMeta),
      );
    } else if (isInserting) {
      context.missing(_dimensionMeta);
    }
    if (data.containsKey('option_key')) {
      context.handle(
        _optionKeyMeta,
        optionKey.isAcceptableOrUnknown(data['option_key']!, _optionKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_optionKeyMeta);
    }
    if (data.containsKey('delta_canonical')) {
      context.handle(
        _deltaCanonicalMeta,
        deltaCanonical.isAcceptableOrUnknown(
          data['delta_canonical']!,
          _deltaCanonicalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoseAdjustment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoseAdjustment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      detergentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detergent_id'],
      )!,
      dimension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dimension'],
      )!,
      optionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_key'],
      )!,
      deltaCanonical: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}delta_canonical'],
      )!,
    );
  }

  @override
  $DoseAdjustmentsTable createAlias(String alias) {
    return $DoseAdjustmentsTable(attachedDatabase, alias);
  }
}

class DoseAdjustment extends DataClass implements Insertable<DoseAdjustment> {
  final String id;
  final String detergentId;
  final String dimension;
  final String optionKey;
  final double deltaCanonical;
  const DoseAdjustment({
    required this.id,
    required this.detergentId,
    required this.dimension,
    required this.optionKey,
    required this.deltaCanonical,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['detergent_id'] = Variable<String>(detergentId);
    map['dimension'] = Variable<String>(dimension);
    map['option_key'] = Variable<String>(optionKey);
    map['delta_canonical'] = Variable<double>(deltaCanonical);
    return map;
  }

  DoseAdjustmentsCompanion toCompanion(bool nullToAbsent) {
    return DoseAdjustmentsCompanion(
      id: Value(id),
      detergentId: Value(detergentId),
      dimension: Value(dimension),
      optionKey: Value(optionKey),
      deltaCanonical: Value(deltaCanonical),
    );
  }

  factory DoseAdjustment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoseAdjustment(
      id: serializer.fromJson<String>(json['id']),
      detergentId: serializer.fromJson<String>(json['detergentId']),
      dimension: serializer.fromJson<String>(json['dimension']),
      optionKey: serializer.fromJson<String>(json['optionKey']),
      deltaCanonical: serializer.fromJson<double>(json['deltaCanonical']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'detergentId': serializer.toJson<String>(detergentId),
      'dimension': serializer.toJson<String>(dimension),
      'optionKey': serializer.toJson<String>(optionKey),
      'deltaCanonical': serializer.toJson<double>(deltaCanonical),
    };
  }

  DoseAdjustment copyWith({
    String? id,
    String? detergentId,
    String? dimension,
    String? optionKey,
    double? deltaCanonical,
  }) => DoseAdjustment(
    id: id ?? this.id,
    detergentId: detergentId ?? this.detergentId,
    dimension: dimension ?? this.dimension,
    optionKey: optionKey ?? this.optionKey,
    deltaCanonical: deltaCanonical ?? this.deltaCanonical,
  );
  DoseAdjustment copyWithCompanion(DoseAdjustmentsCompanion data) {
    return DoseAdjustment(
      id: data.id.present ? data.id.value : this.id,
      detergentId: data.detergentId.present
          ? data.detergentId.value
          : this.detergentId,
      dimension: data.dimension.present ? data.dimension.value : this.dimension,
      optionKey: data.optionKey.present ? data.optionKey.value : this.optionKey,
      deltaCanonical: data.deltaCanonical.present
          ? data.deltaCanonical.value
          : this.deltaCanonical,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoseAdjustment(')
          ..write('id: $id, ')
          ..write('detergentId: $detergentId, ')
          ..write('dimension: $dimension, ')
          ..write('optionKey: $optionKey, ')
          ..write('deltaCanonical: $deltaCanonical')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, detergentId, dimension, optionKey, deltaCanonical);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoseAdjustment &&
          other.id == this.id &&
          other.detergentId == this.detergentId &&
          other.dimension == this.dimension &&
          other.optionKey == this.optionKey &&
          other.deltaCanonical == this.deltaCanonical);
}

class DoseAdjustmentsCompanion extends UpdateCompanion<DoseAdjustment> {
  final Value<String> id;
  final Value<String> detergentId;
  final Value<String> dimension;
  final Value<String> optionKey;
  final Value<double> deltaCanonical;
  final Value<int> rowid;
  const DoseAdjustmentsCompanion({
    this.id = const Value.absent(),
    this.detergentId = const Value.absent(),
    this.dimension = const Value.absent(),
    this.optionKey = const Value.absent(),
    this.deltaCanonical = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoseAdjustmentsCompanion.insert({
    required String id,
    required String detergentId,
    required String dimension,
    required String optionKey,
    this.deltaCanonical = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       detergentId = Value(detergentId),
       dimension = Value(dimension),
       optionKey = Value(optionKey);
  static Insertable<DoseAdjustment> custom({
    Expression<String>? id,
    Expression<String>? detergentId,
    Expression<String>? dimension,
    Expression<String>? optionKey,
    Expression<double>? deltaCanonical,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (detergentId != null) 'detergent_id': detergentId,
      if (dimension != null) 'dimension': dimension,
      if (optionKey != null) 'option_key': optionKey,
      if (deltaCanonical != null) 'delta_canonical': deltaCanonical,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoseAdjustmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? detergentId,
    Value<String>? dimension,
    Value<String>? optionKey,
    Value<double>? deltaCanonical,
    Value<int>? rowid,
  }) {
    return DoseAdjustmentsCompanion(
      id: id ?? this.id,
      detergentId: detergentId ?? this.detergentId,
      dimension: dimension ?? this.dimension,
      optionKey: optionKey ?? this.optionKey,
      deltaCanonical: deltaCanonical ?? this.deltaCanonical,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (detergentId.present) {
      map['detergent_id'] = Variable<String>(detergentId.value);
    }
    if (dimension.present) {
      map['dimension'] = Variable<String>(dimension.value);
    }
    if (optionKey.present) {
      map['option_key'] = Variable<String>(optionKey.value);
    }
    if (deltaCanonical.present) {
      map['delta_canonical'] = Variable<double>(deltaCanonical.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoseAdjustmentsCompanion(')
          ..write('id: $id, ')
          ..write('detergentId: $detergentId, ')
          ..write('dimension: $dimension, ')
          ..write('optionKey: $optionKey, ')
          ..write('deltaCanonical: $deltaCanonical, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeasureMarkersTable extends MeasureMarkers
    with TableInfo<$MeasureMarkersTable, MeasureMarker> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasureMarkersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detergentIdMeta = const VerificationMeta(
    'detergentId',
  );
  @override
  late final GeneratedColumn<String> detergentId = GeneratedColumn<String>(
    'detergent_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES detergent_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 24,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCanonicalMeta = const VerificationMeta(
    'amountCanonical',
  );
  @override
  late final GeneratedColumn<double> amountCanonical = GeneratedColumn<double>(
    'amount_canonical',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    detergentId,
    label,
    amountCanonical,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measure_markers';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeasureMarker> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('detergent_id')) {
      context.handle(
        _detergentIdMeta,
        detergentId.isAcceptableOrUnknown(
          data['detergent_id']!,
          _detergentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detergentIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('amount_canonical')) {
      context.handle(
        _amountCanonicalMeta,
        amountCanonical.isAcceptableOrUnknown(
          data['amount_canonical']!,
          _amountCanonicalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCanonicalMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeasureMarker map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeasureMarker(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      detergentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detergent_id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      amountCanonical: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_canonical'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $MeasureMarkersTable createAlias(String alias) {
    return $MeasureMarkersTable(attachedDatabase, alias);
  }
}

class MeasureMarker extends DataClass implements Insertable<MeasureMarker> {
  final String id;
  final String detergentId;
  final String label;
  final double amountCanonical;
  final int sortOrder;
  const MeasureMarker({
    required this.id,
    required this.detergentId,
    required this.label,
    required this.amountCanonical,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['detergent_id'] = Variable<String>(detergentId);
    map['label'] = Variable<String>(label);
    map['amount_canonical'] = Variable<double>(amountCanonical);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  MeasureMarkersCompanion toCompanion(bool nullToAbsent) {
    return MeasureMarkersCompanion(
      id: Value(id),
      detergentId: Value(detergentId),
      label: Value(label),
      amountCanonical: Value(amountCanonical),
      sortOrder: Value(sortOrder),
    );
  }

  factory MeasureMarker.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeasureMarker(
      id: serializer.fromJson<String>(json['id']),
      detergentId: serializer.fromJson<String>(json['detergentId']),
      label: serializer.fromJson<String>(json['label']),
      amountCanonical: serializer.fromJson<double>(json['amountCanonical']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'detergentId': serializer.toJson<String>(detergentId),
      'label': serializer.toJson<String>(label),
      'amountCanonical': serializer.toJson<double>(amountCanonical),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  MeasureMarker copyWith({
    String? id,
    String? detergentId,
    String? label,
    double? amountCanonical,
    int? sortOrder,
  }) => MeasureMarker(
    id: id ?? this.id,
    detergentId: detergentId ?? this.detergentId,
    label: label ?? this.label,
    amountCanonical: amountCanonical ?? this.amountCanonical,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  MeasureMarker copyWithCompanion(MeasureMarkersCompanion data) {
    return MeasureMarker(
      id: data.id.present ? data.id.value : this.id,
      detergentId: data.detergentId.present
          ? data.detergentId.value
          : this.detergentId,
      label: data.label.present ? data.label.value : this.label,
      amountCanonical: data.amountCanonical.present
          ? data.amountCanonical.value
          : this.amountCanonical,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeasureMarker(')
          ..write('id: $id, ')
          ..write('detergentId: $detergentId, ')
          ..write('label: $label, ')
          ..write('amountCanonical: $amountCanonical, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, detergentId, label, amountCanonical, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeasureMarker &&
          other.id == this.id &&
          other.detergentId == this.detergentId &&
          other.label == this.label &&
          other.amountCanonical == this.amountCanonical &&
          other.sortOrder == this.sortOrder);
}

class MeasureMarkersCompanion extends UpdateCompanion<MeasureMarker> {
  final Value<String> id;
  final Value<String> detergentId;
  final Value<String> label;
  final Value<double> amountCanonical;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const MeasureMarkersCompanion({
    this.id = const Value.absent(),
    this.detergentId = const Value.absent(),
    this.label = const Value.absent(),
    this.amountCanonical = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeasureMarkersCompanion.insert({
    required String id,
    required String detergentId,
    required String label,
    required double amountCanonical,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       detergentId = Value(detergentId),
       label = Value(label),
       amountCanonical = Value(amountCanonical);
  static Insertable<MeasureMarker> custom({
    Expression<String>? id,
    Expression<String>? detergentId,
    Expression<String>? label,
    Expression<double>? amountCanonical,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (detergentId != null) 'detergent_id': detergentId,
      if (label != null) 'label': label,
      if (amountCanonical != null) 'amount_canonical': amountCanonical,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeasureMarkersCompanion copyWith({
    Value<String>? id,
    Value<String>? detergentId,
    Value<String>? label,
    Value<double>? amountCanonical,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return MeasureMarkersCompanion(
      id: id ?? this.id,
      detergentId: detergentId ?? this.detergentId,
      label: label ?? this.label,
      amountCanonical: amountCanonical ?? this.amountCanonical,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (detergentId.present) {
      map['detergent_id'] = Variable<String>(detergentId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (amountCanonical.present) {
      map['amount_canonical'] = Variable<double>(amountCanonical.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasureMarkersCompanion(')
          ..write('id: $id, ')
          ..write('detergentId: $detergentId, ')
          ..write('label: $label, ')
          ..write('amountCanonical: $amountCanonical, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WashLogsTable extends WashLogs with TableInfo<$WashLogsTable, WashLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WashLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detergentIdMeta = const VerificationMeta(
    'detergentId',
  );
  @override
  late final GeneratedColumn<String> detergentId = GeneratedColumn<String>(
    'detergent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES detergent_profiles (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _detergentNameSnapshotMeta =
      const VerificationMeta('detergentNameSnapshot');
  @override
  late final GeneratedColumn<String> detergentNameSnapshot =
      GeneratedColumn<String>(
        'detergent_name_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _detergentTypeSnapshotMeta =
      const VerificationMeta('detergentTypeSnapshot');
  @override
  late final GeneratedColumn<String> detergentTypeSnapshot =
      GeneratedColumn<String>(
        'detergent_type_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _amountCanonicalMeta = const VerificationMeta(
    'amountCanonical',
  );
  @override
  late final GeneratedColumn<double> amountCanonical = GeneratedColumn<double>(
    'amount_canonical',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _canonicalUnitMeta = const VerificationMeta(
    'canonicalUnit',
  );
  @override
  late final GeneratedColumn<String> canonicalUnit = GeneratedColumn<String>(
    'canonical_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayAmountSnapshotMeta =
      const VerificationMeta('displayAmountSnapshot');
  @override
  late final GeneratedColumn<String> displayAmountSnapshot =
      GeneratedColumn<String>(
        'display_amount_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _displayUnitSnapshotMeta =
      const VerificationMeta('displayUnitSnapshot');
  @override
  late final GeneratedColumn<String> displayUnitSnapshot =
      GeneratedColumn<String>(
        'display_unit_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _loadLevelMeta = const VerificationMeta(
    'loadLevel',
  );
  @override
  late final GeneratedColumn<String> loadLevel = GeneratedColumn<String>(
    'load_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _soilLevelMeta = const VerificationMeta(
    'soilLevel',
  );
  @override
  late final GeneratedColumn<String> soilLevel = GeneratedColumn<String>(
    'soil_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterLevelMeta = const VerificationMeta(
    'waterLevel',
  );
  @override
  late final GeneratedColumn<String> waterLevel = GeneratedColumn<String>(
    'water_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costMinorUnitsMeta = const VerificationMeta(
    'costMinorUnits',
  );
  @override
  late final GeneratedColumn<int> costMinorUnits = GeneratedColumn<int>(
    'cost_minor_units',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loggedAtUtcMeta = const VerificationMeta(
    'loggedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAtUtc = GeneratedColumn<DateTime>(
    'logged_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    detergentId,
    detergentNameSnapshot,
    detergentTypeSnapshot,
    amountCanonical,
    canonicalUnit,
    displayAmountSnapshot,
    displayUnitSnapshot,
    loadLevel,
    soilLevel,
    waterLevel,
    costMinorUnits,
    currencyCode,
    loggedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wash_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WashLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('detergent_id')) {
      context.handle(
        _detergentIdMeta,
        detergentId.isAcceptableOrUnknown(
          data['detergent_id']!,
          _detergentIdMeta,
        ),
      );
    }
    if (data.containsKey('detergent_name_snapshot')) {
      context.handle(
        _detergentNameSnapshotMeta,
        detergentNameSnapshot.isAcceptableOrUnknown(
          data['detergent_name_snapshot']!,
          _detergentNameSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detergentNameSnapshotMeta);
    }
    if (data.containsKey('detergent_type_snapshot')) {
      context.handle(
        _detergentTypeSnapshotMeta,
        detergentTypeSnapshot.isAcceptableOrUnknown(
          data['detergent_type_snapshot']!,
          _detergentTypeSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detergentTypeSnapshotMeta);
    }
    if (data.containsKey('amount_canonical')) {
      context.handle(
        _amountCanonicalMeta,
        amountCanonical.isAcceptableOrUnknown(
          data['amount_canonical']!,
          _amountCanonicalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCanonicalMeta);
    }
    if (data.containsKey('canonical_unit')) {
      context.handle(
        _canonicalUnitMeta,
        canonicalUnit.isAcceptableOrUnknown(
          data['canonical_unit']!,
          _canonicalUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_canonicalUnitMeta);
    }
    if (data.containsKey('display_amount_snapshot')) {
      context.handle(
        _displayAmountSnapshotMeta,
        displayAmountSnapshot.isAcceptableOrUnknown(
          data['display_amount_snapshot']!,
          _displayAmountSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayAmountSnapshotMeta);
    }
    if (data.containsKey('display_unit_snapshot')) {
      context.handle(
        _displayUnitSnapshotMeta,
        displayUnitSnapshot.isAcceptableOrUnknown(
          data['display_unit_snapshot']!,
          _displayUnitSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayUnitSnapshotMeta);
    }
    if (data.containsKey('load_level')) {
      context.handle(
        _loadLevelMeta,
        loadLevel.isAcceptableOrUnknown(data['load_level']!, _loadLevelMeta),
      );
    }
    if (data.containsKey('soil_level')) {
      context.handle(
        _soilLevelMeta,
        soilLevel.isAcceptableOrUnknown(data['soil_level']!, _soilLevelMeta),
      );
    }
    if (data.containsKey('water_level')) {
      context.handle(
        _waterLevelMeta,
        waterLevel.isAcceptableOrUnknown(data['water_level']!, _waterLevelMeta),
      );
    }
    if (data.containsKey('cost_minor_units')) {
      context.handle(
        _costMinorUnitsMeta,
        costMinorUnits.isAcceptableOrUnknown(
          data['cost_minor_units']!,
          _costMinorUnitsMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('logged_at_utc')) {
      context.handle(
        _loggedAtUtcMeta,
        loggedAtUtc.isAcceptableOrUnknown(
          data['logged_at_utc']!,
          _loggedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_loggedAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WashLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WashLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      detergentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detergent_id'],
      ),
      detergentNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detergent_name_snapshot'],
      )!,
      detergentTypeSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detergent_type_snapshot'],
      )!,
      amountCanonical: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_canonical'],
      )!,
      canonicalUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_unit'],
      )!,
      displayAmountSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_amount_snapshot'],
      )!,
      displayUnitSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_unit_snapshot'],
      )!,
      loadLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}load_level'],
      ),
      soilLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}soil_level'],
      ),
      waterLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}water_level'],
      ),
      costMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_minor_units'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      ),
      loggedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at_utc'],
      )!,
    );
  }

  @override
  $WashLogsTable createAlias(String alias) {
    return $WashLogsTable(attachedDatabase, alias);
  }
}

class WashLog extends DataClass implements Insertable<WashLog> {
  final String id;
  final String? detergentId;
  final String detergentNameSnapshot;
  final String detergentTypeSnapshot;
  final double amountCanonical;
  final String canonicalUnit;
  final String displayAmountSnapshot;
  final String displayUnitSnapshot;
  final String? loadLevel;
  final String? soilLevel;
  final String? waterLevel;
  final int? costMinorUnits;
  final String? currencyCode;
  final DateTime loggedAtUtc;
  const WashLog({
    required this.id,
    this.detergentId,
    required this.detergentNameSnapshot,
    required this.detergentTypeSnapshot,
    required this.amountCanonical,
    required this.canonicalUnit,
    required this.displayAmountSnapshot,
    required this.displayUnitSnapshot,
    this.loadLevel,
    this.soilLevel,
    this.waterLevel,
    this.costMinorUnits,
    this.currencyCode,
    required this.loggedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || detergentId != null) {
      map['detergent_id'] = Variable<String>(detergentId);
    }
    map['detergent_name_snapshot'] = Variable<String>(detergentNameSnapshot);
    map['detergent_type_snapshot'] = Variable<String>(detergentTypeSnapshot);
    map['amount_canonical'] = Variable<double>(amountCanonical);
    map['canonical_unit'] = Variable<String>(canonicalUnit);
    map['display_amount_snapshot'] = Variable<String>(displayAmountSnapshot);
    map['display_unit_snapshot'] = Variable<String>(displayUnitSnapshot);
    if (!nullToAbsent || loadLevel != null) {
      map['load_level'] = Variable<String>(loadLevel);
    }
    if (!nullToAbsent || soilLevel != null) {
      map['soil_level'] = Variable<String>(soilLevel);
    }
    if (!nullToAbsent || waterLevel != null) {
      map['water_level'] = Variable<String>(waterLevel);
    }
    if (!nullToAbsent || costMinorUnits != null) {
      map['cost_minor_units'] = Variable<int>(costMinorUnits);
    }
    if (!nullToAbsent || currencyCode != null) {
      map['currency_code'] = Variable<String>(currencyCode);
    }
    map['logged_at_utc'] = Variable<DateTime>(loggedAtUtc);
    return map;
  }

  WashLogsCompanion toCompanion(bool nullToAbsent) {
    return WashLogsCompanion(
      id: Value(id),
      detergentId: detergentId == null && nullToAbsent
          ? const Value.absent()
          : Value(detergentId),
      detergentNameSnapshot: Value(detergentNameSnapshot),
      detergentTypeSnapshot: Value(detergentTypeSnapshot),
      amountCanonical: Value(amountCanonical),
      canonicalUnit: Value(canonicalUnit),
      displayAmountSnapshot: Value(displayAmountSnapshot),
      displayUnitSnapshot: Value(displayUnitSnapshot),
      loadLevel: loadLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(loadLevel),
      soilLevel: soilLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(soilLevel),
      waterLevel: waterLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(waterLevel),
      costMinorUnits: costMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(costMinorUnits),
      currencyCode: currencyCode == null && nullToAbsent
          ? const Value.absent()
          : Value(currencyCode),
      loggedAtUtc: Value(loggedAtUtc),
    );
  }

  factory WashLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WashLog(
      id: serializer.fromJson<String>(json['id']),
      detergentId: serializer.fromJson<String?>(json['detergentId']),
      detergentNameSnapshot: serializer.fromJson<String>(
        json['detergentNameSnapshot'],
      ),
      detergentTypeSnapshot: serializer.fromJson<String>(
        json['detergentTypeSnapshot'],
      ),
      amountCanonical: serializer.fromJson<double>(json['amountCanonical']),
      canonicalUnit: serializer.fromJson<String>(json['canonicalUnit']),
      displayAmountSnapshot: serializer.fromJson<String>(
        json['displayAmountSnapshot'],
      ),
      displayUnitSnapshot: serializer.fromJson<String>(
        json['displayUnitSnapshot'],
      ),
      loadLevel: serializer.fromJson<String?>(json['loadLevel']),
      soilLevel: serializer.fromJson<String?>(json['soilLevel']),
      waterLevel: serializer.fromJson<String?>(json['waterLevel']),
      costMinorUnits: serializer.fromJson<int?>(json['costMinorUnits']),
      currencyCode: serializer.fromJson<String?>(json['currencyCode']),
      loggedAtUtc: serializer.fromJson<DateTime>(json['loggedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'detergentId': serializer.toJson<String?>(detergentId),
      'detergentNameSnapshot': serializer.toJson<String>(detergentNameSnapshot),
      'detergentTypeSnapshot': serializer.toJson<String>(detergentTypeSnapshot),
      'amountCanonical': serializer.toJson<double>(amountCanonical),
      'canonicalUnit': serializer.toJson<String>(canonicalUnit),
      'displayAmountSnapshot': serializer.toJson<String>(displayAmountSnapshot),
      'displayUnitSnapshot': serializer.toJson<String>(displayUnitSnapshot),
      'loadLevel': serializer.toJson<String?>(loadLevel),
      'soilLevel': serializer.toJson<String?>(soilLevel),
      'waterLevel': serializer.toJson<String?>(waterLevel),
      'costMinorUnits': serializer.toJson<int?>(costMinorUnits),
      'currencyCode': serializer.toJson<String?>(currencyCode),
      'loggedAtUtc': serializer.toJson<DateTime>(loggedAtUtc),
    };
  }

  WashLog copyWith({
    String? id,
    Value<String?> detergentId = const Value.absent(),
    String? detergentNameSnapshot,
    String? detergentTypeSnapshot,
    double? amountCanonical,
    String? canonicalUnit,
    String? displayAmountSnapshot,
    String? displayUnitSnapshot,
    Value<String?> loadLevel = const Value.absent(),
    Value<String?> soilLevel = const Value.absent(),
    Value<String?> waterLevel = const Value.absent(),
    Value<int?> costMinorUnits = const Value.absent(),
    Value<String?> currencyCode = const Value.absent(),
    DateTime? loggedAtUtc,
  }) => WashLog(
    id: id ?? this.id,
    detergentId: detergentId.present ? detergentId.value : this.detergentId,
    detergentNameSnapshot: detergentNameSnapshot ?? this.detergentNameSnapshot,
    detergentTypeSnapshot: detergentTypeSnapshot ?? this.detergentTypeSnapshot,
    amountCanonical: amountCanonical ?? this.amountCanonical,
    canonicalUnit: canonicalUnit ?? this.canonicalUnit,
    displayAmountSnapshot: displayAmountSnapshot ?? this.displayAmountSnapshot,
    displayUnitSnapshot: displayUnitSnapshot ?? this.displayUnitSnapshot,
    loadLevel: loadLevel.present ? loadLevel.value : this.loadLevel,
    soilLevel: soilLevel.present ? soilLevel.value : this.soilLevel,
    waterLevel: waterLevel.present ? waterLevel.value : this.waterLevel,
    costMinorUnits: costMinorUnits.present
        ? costMinorUnits.value
        : this.costMinorUnits,
    currencyCode: currencyCode.present ? currencyCode.value : this.currencyCode,
    loggedAtUtc: loggedAtUtc ?? this.loggedAtUtc,
  );
  WashLog copyWithCompanion(WashLogsCompanion data) {
    return WashLog(
      id: data.id.present ? data.id.value : this.id,
      detergentId: data.detergentId.present
          ? data.detergentId.value
          : this.detergentId,
      detergentNameSnapshot: data.detergentNameSnapshot.present
          ? data.detergentNameSnapshot.value
          : this.detergentNameSnapshot,
      detergentTypeSnapshot: data.detergentTypeSnapshot.present
          ? data.detergentTypeSnapshot.value
          : this.detergentTypeSnapshot,
      amountCanonical: data.amountCanonical.present
          ? data.amountCanonical.value
          : this.amountCanonical,
      canonicalUnit: data.canonicalUnit.present
          ? data.canonicalUnit.value
          : this.canonicalUnit,
      displayAmountSnapshot: data.displayAmountSnapshot.present
          ? data.displayAmountSnapshot.value
          : this.displayAmountSnapshot,
      displayUnitSnapshot: data.displayUnitSnapshot.present
          ? data.displayUnitSnapshot.value
          : this.displayUnitSnapshot,
      loadLevel: data.loadLevel.present ? data.loadLevel.value : this.loadLevel,
      soilLevel: data.soilLevel.present ? data.soilLevel.value : this.soilLevel,
      waterLevel: data.waterLevel.present
          ? data.waterLevel.value
          : this.waterLevel,
      costMinorUnits: data.costMinorUnits.present
          ? data.costMinorUnits.value
          : this.costMinorUnits,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      loggedAtUtc: data.loggedAtUtc.present
          ? data.loggedAtUtc.value
          : this.loggedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WashLog(')
          ..write('id: $id, ')
          ..write('detergentId: $detergentId, ')
          ..write('detergentNameSnapshot: $detergentNameSnapshot, ')
          ..write('detergentTypeSnapshot: $detergentTypeSnapshot, ')
          ..write('amountCanonical: $amountCanonical, ')
          ..write('canonicalUnit: $canonicalUnit, ')
          ..write('displayAmountSnapshot: $displayAmountSnapshot, ')
          ..write('displayUnitSnapshot: $displayUnitSnapshot, ')
          ..write('loadLevel: $loadLevel, ')
          ..write('soilLevel: $soilLevel, ')
          ..write('waterLevel: $waterLevel, ')
          ..write('costMinorUnits: $costMinorUnits, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('loggedAtUtc: $loggedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    detergentId,
    detergentNameSnapshot,
    detergentTypeSnapshot,
    amountCanonical,
    canonicalUnit,
    displayAmountSnapshot,
    displayUnitSnapshot,
    loadLevel,
    soilLevel,
    waterLevel,
    costMinorUnits,
    currencyCode,
    loggedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WashLog &&
          other.id == this.id &&
          other.detergentId == this.detergentId &&
          other.detergentNameSnapshot == this.detergentNameSnapshot &&
          other.detergentTypeSnapshot == this.detergentTypeSnapshot &&
          other.amountCanonical == this.amountCanonical &&
          other.canonicalUnit == this.canonicalUnit &&
          other.displayAmountSnapshot == this.displayAmountSnapshot &&
          other.displayUnitSnapshot == this.displayUnitSnapshot &&
          other.loadLevel == this.loadLevel &&
          other.soilLevel == this.soilLevel &&
          other.waterLevel == this.waterLevel &&
          other.costMinorUnits == this.costMinorUnits &&
          other.currencyCode == this.currencyCode &&
          other.loggedAtUtc == this.loggedAtUtc);
}

class WashLogsCompanion extends UpdateCompanion<WashLog> {
  final Value<String> id;
  final Value<String?> detergentId;
  final Value<String> detergentNameSnapshot;
  final Value<String> detergentTypeSnapshot;
  final Value<double> amountCanonical;
  final Value<String> canonicalUnit;
  final Value<String> displayAmountSnapshot;
  final Value<String> displayUnitSnapshot;
  final Value<String?> loadLevel;
  final Value<String?> soilLevel;
  final Value<String?> waterLevel;
  final Value<int?> costMinorUnits;
  final Value<String?> currencyCode;
  final Value<DateTime> loggedAtUtc;
  final Value<int> rowid;
  const WashLogsCompanion({
    this.id = const Value.absent(),
    this.detergentId = const Value.absent(),
    this.detergentNameSnapshot = const Value.absent(),
    this.detergentTypeSnapshot = const Value.absent(),
    this.amountCanonical = const Value.absent(),
    this.canonicalUnit = const Value.absent(),
    this.displayAmountSnapshot = const Value.absent(),
    this.displayUnitSnapshot = const Value.absent(),
    this.loadLevel = const Value.absent(),
    this.soilLevel = const Value.absent(),
    this.waterLevel = const Value.absent(),
    this.costMinorUnits = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.loggedAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WashLogsCompanion.insert({
    required String id,
    this.detergentId = const Value.absent(),
    required String detergentNameSnapshot,
    required String detergentTypeSnapshot,
    required double amountCanonical,
    required String canonicalUnit,
    required String displayAmountSnapshot,
    required String displayUnitSnapshot,
    this.loadLevel = const Value.absent(),
    this.soilLevel = const Value.absent(),
    this.waterLevel = const Value.absent(),
    this.costMinorUnits = const Value.absent(),
    this.currencyCode = const Value.absent(),
    required DateTime loggedAtUtc,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       detergentNameSnapshot = Value(detergentNameSnapshot),
       detergentTypeSnapshot = Value(detergentTypeSnapshot),
       amountCanonical = Value(amountCanonical),
       canonicalUnit = Value(canonicalUnit),
       displayAmountSnapshot = Value(displayAmountSnapshot),
       displayUnitSnapshot = Value(displayUnitSnapshot),
       loggedAtUtc = Value(loggedAtUtc);
  static Insertable<WashLog> custom({
    Expression<String>? id,
    Expression<String>? detergentId,
    Expression<String>? detergentNameSnapshot,
    Expression<String>? detergentTypeSnapshot,
    Expression<double>? amountCanonical,
    Expression<String>? canonicalUnit,
    Expression<String>? displayAmountSnapshot,
    Expression<String>? displayUnitSnapshot,
    Expression<String>? loadLevel,
    Expression<String>? soilLevel,
    Expression<String>? waterLevel,
    Expression<int>? costMinorUnits,
    Expression<String>? currencyCode,
    Expression<DateTime>? loggedAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (detergentId != null) 'detergent_id': detergentId,
      if (detergentNameSnapshot != null)
        'detergent_name_snapshot': detergentNameSnapshot,
      if (detergentTypeSnapshot != null)
        'detergent_type_snapshot': detergentTypeSnapshot,
      if (amountCanonical != null) 'amount_canonical': amountCanonical,
      if (canonicalUnit != null) 'canonical_unit': canonicalUnit,
      if (displayAmountSnapshot != null)
        'display_amount_snapshot': displayAmountSnapshot,
      if (displayUnitSnapshot != null)
        'display_unit_snapshot': displayUnitSnapshot,
      if (loadLevel != null) 'load_level': loadLevel,
      if (soilLevel != null) 'soil_level': soilLevel,
      if (waterLevel != null) 'water_level': waterLevel,
      if (costMinorUnits != null) 'cost_minor_units': costMinorUnits,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (loggedAtUtc != null) 'logged_at_utc': loggedAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WashLogsCompanion copyWith({
    Value<String>? id,
    Value<String?>? detergentId,
    Value<String>? detergentNameSnapshot,
    Value<String>? detergentTypeSnapshot,
    Value<double>? amountCanonical,
    Value<String>? canonicalUnit,
    Value<String>? displayAmountSnapshot,
    Value<String>? displayUnitSnapshot,
    Value<String?>? loadLevel,
    Value<String?>? soilLevel,
    Value<String?>? waterLevel,
    Value<int?>? costMinorUnits,
    Value<String?>? currencyCode,
    Value<DateTime>? loggedAtUtc,
    Value<int>? rowid,
  }) {
    return WashLogsCompanion(
      id: id ?? this.id,
      detergentId: detergentId ?? this.detergentId,
      detergentNameSnapshot:
          detergentNameSnapshot ?? this.detergentNameSnapshot,
      detergentTypeSnapshot:
          detergentTypeSnapshot ?? this.detergentTypeSnapshot,
      amountCanonical: amountCanonical ?? this.amountCanonical,
      canonicalUnit: canonicalUnit ?? this.canonicalUnit,
      displayAmountSnapshot:
          displayAmountSnapshot ?? this.displayAmountSnapshot,
      displayUnitSnapshot: displayUnitSnapshot ?? this.displayUnitSnapshot,
      loadLevel: loadLevel ?? this.loadLevel,
      soilLevel: soilLevel ?? this.soilLevel,
      waterLevel: waterLevel ?? this.waterLevel,
      costMinorUnits: costMinorUnits ?? this.costMinorUnits,
      currencyCode: currencyCode ?? this.currencyCode,
      loggedAtUtc: loggedAtUtc ?? this.loggedAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (detergentId.present) {
      map['detergent_id'] = Variable<String>(detergentId.value);
    }
    if (detergentNameSnapshot.present) {
      map['detergent_name_snapshot'] = Variable<String>(
        detergentNameSnapshot.value,
      );
    }
    if (detergentTypeSnapshot.present) {
      map['detergent_type_snapshot'] = Variable<String>(
        detergentTypeSnapshot.value,
      );
    }
    if (amountCanonical.present) {
      map['amount_canonical'] = Variable<double>(amountCanonical.value);
    }
    if (canonicalUnit.present) {
      map['canonical_unit'] = Variable<String>(canonicalUnit.value);
    }
    if (displayAmountSnapshot.present) {
      map['display_amount_snapshot'] = Variable<String>(
        displayAmountSnapshot.value,
      );
    }
    if (displayUnitSnapshot.present) {
      map['display_unit_snapshot'] = Variable<String>(
        displayUnitSnapshot.value,
      );
    }
    if (loadLevel.present) {
      map['load_level'] = Variable<String>(loadLevel.value);
    }
    if (soilLevel.present) {
      map['soil_level'] = Variable<String>(soilLevel.value);
    }
    if (waterLevel.present) {
      map['water_level'] = Variable<String>(waterLevel.value);
    }
    if (costMinorUnits.present) {
      map['cost_minor_units'] = Variable<int>(costMinorUnits.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (loggedAtUtc.present) {
      map['logged_at_utc'] = Variable<DateTime>(loggedAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WashLogsCompanion(')
          ..write('id: $id, ')
          ..write('detergentId: $detergentId, ')
          ..write('detergentNameSnapshot: $detergentNameSnapshot, ')
          ..write('detergentTypeSnapshot: $detergentTypeSnapshot, ')
          ..write('amountCanonical: $amountCanonical, ')
          ..write('canonicalUnit: $canonicalUnit, ')
          ..write('displayAmountSnapshot: $displayAmountSnapshot, ')
          ..write('displayUnitSnapshot: $displayUnitSnapshot, ')
          ..write('loadLevel: $loadLevel, ')
          ..write('soilLevel: $soilLevel, ')
          ..write('waterLevel: $waterLevel, ')
          ..write('costMinorUnits: $costMinorUnits, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('loggedAtUtc: $loggedAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _localeOverrideMeta = const VerificationMeta(
    'localeOverride',
  );
  @override
  late final GeneratedColumn<String> localeOverride = GeneratedColumn<String>(
    'locale_override',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitSystemMeta = const VerificationMeta(
    'unitSystem',
  );
  @override
  late final GeneratedColumn<String> unitSystem = GeneratedColumn<String>(
    'unit_system',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('auto'),
  );
  static const VerificationMeta _defaultLoadLevelMeta = const VerificationMeta(
    'defaultLoadLevel',
  );
  @override
  late final GeneratedColumn<String> defaultLoadLevel = GeneratedColumn<String>(
    'default_load_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('medium'),
  );
  static const VerificationMeta _defaultSoilLevelMeta = const VerificationMeta(
    'defaultSoilLevel',
  );
  @override
  late final GeneratedColumn<String> defaultSoilLevel = GeneratedColumn<String>(
    'default_soil_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('normal'),
  );
  static const VerificationMeta _defaultWaterLevelMeta = const VerificationMeta(
    'defaultWaterLevel',
  );
  @override
  late final GeneratedColumn<String> defaultWaterLevel =
      GeneratedColumn<String>(
        'default_water_level',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('unknown'),
      );
  static const VerificationMeta _selectedDetergentIdMeta =
      const VerificationMeta('selectedDetergentId');
  @override
  late final GeneratedColumn<String> selectedDetergentId =
      GeneratedColumn<String>(
        'selected_detergent_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES detergent_profiles (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _reducedMotionOverrideMeta =
      const VerificationMeta('reducedMotionOverride');
  @override
  late final GeneratedColumn<String> reducedMotionOverride =
      GeneratedColumn<String>(
        'reduced_motion_override',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('system'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    onboardingCompleted,
    themeMode,
    localeOverride,
    unitSystem,
    defaultLoadLevel,
    defaultSoilLevel,
    defaultWaterLevel,
    selectedDetergentId,
    reducedMotionOverride,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('locale_override')) {
      context.handle(
        _localeOverrideMeta,
        localeOverride.isAcceptableOrUnknown(
          data['locale_override']!,
          _localeOverrideMeta,
        ),
      );
    }
    if (data.containsKey('unit_system')) {
      context.handle(
        _unitSystemMeta,
        unitSystem.isAcceptableOrUnknown(data['unit_system']!, _unitSystemMeta),
      );
    }
    if (data.containsKey('default_load_level')) {
      context.handle(
        _defaultLoadLevelMeta,
        defaultLoadLevel.isAcceptableOrUnknown(
          data['default_load_level']!,
          _defaultLoadLevelMeta,
        ),
      );
    }
    if (data.containsKey('default_soil_level')) {
      context.handle(
        _defaultSoilLevelMeta,
        defaultSoilLevel.isAcceptableOrUnknown(
          data['default_soil_level']!,
          _defaultSoilLevelMeta,
        ),
      );
    }
    if (data.containsKey('default_water_level')) {
      context.handle(
        _defaultWaterLevelMeta,
        defaultWaterLevel.isAcceptableOrUnknown(
          data['default_water_level']!,
          _defaultWaterLevelMeta,
        ),
      );
    }
    if (data.containsKey('selected_detergent_id')) {
      context.handle(
        _selectedDetergentIdMeta,
        selectedDetergentId.isAcceptableOrUnknown(
          data['selected_detergent_id']!,
          _selectedDetergentIdMeta,
        ),
      );
    }
    if (data.containsKey('reduced_motion_override')) {
      context.handle(
        _reducedMotionOverrideMeta,
        reducedMotionOverride.isAcceptableOrUnknown(
          data['reduced_motion_override']!,
          _reducedMotionOverrideMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      localeOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_override'],
      ),
      unitSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_system'],
      )!,
      defaultLoadLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_load_level'],
      )!,
      defaultSoilLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_soil_level'],
      )!,
      defaultWaterLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_water_level'],
      )!,
      selectedDetergentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_detergent_id'],
      ),
      reducedMotionOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reduced_motion_override'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final bool onboardingCompleted;
  final String themeMode;
  final String? localeOverride;
  final String unitSystem;
  final String defaultLoadLevel;
  final String defaultSoilLevel;
  final String defaultWaterLevel;
  final String? selectedDetergentId;
  final String reducedMotionOverride;
  const AppSetting({
    required this.id,
    required this.onboardingCompleted,
    required this.themeMode,
    this.localeOverride,
    required this.unitSystem,
    required this.defaultLoadLevel,
    required this.defaultSoilLevel,
    required this.defaultWaterLevel,
    this.selectedDetergentId,
    required this.reducedMotionOverride,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['theme_mode'] = Variable<String>(themeMode);
    if (!nullToAbsent || localeOverride != null) {
      map['locale_override'] = Variable<String>(localeOverride);
    }
    map['unit_system'] = Variable<String>(unitSystem);
    map['default_load_level'] = Variable<String>(defaultLoadLevel);
    map['default_soil_level'] = Variable<String>(defaultSoilLevel);
    map['default_water_level'] = Variable<String>(defaultWaterLevel);
    if (!nullToAbsent || selectedDetergentId != null) {
      map['selected_detergent_id'] = Variable<String>(selectedDetergentId);
    }
    map['reduced_motion_override'] = Variable<String>(reducedMotionOverride);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      onboardingCompleted: Value(onboardingCompleted),
      themeMode: Value(themeMode),
      localeOverride: localeOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(localeOverride),
      unitSystem: Value(unitSystem),
      defaultLoadLevel: Value(defaultLoadLevel),
      defaultSoilLevel: Value(defaultSoilLevel),
      defaultWaterLevel: Value(defaultWaterLevel),
      selectedDetergentId: selectedDetergentId == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedDetergentId),
      reducedMotionOverride: Value(reducedMotionOverride),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      localeOverride: serializer.fromJson<String?>(json['localeOverride']),
      unitSystem: serializer.fromJson<String>(json['unitSystem']),
      defaultLoadLevel: serializer.fromJson<String>(json['defaultLoadLevel']),
      defaultSoilLevel: serializer.fromJson<String>(json['defaultSoilLevel']),
      defaultWaterLevel: serializer.fromJson<String>(json['defaultWaterLevel']),
      selectedDetergentId: serializer.fromJson<String?>(
        json['selectedDetergentId'],
      ),
      reducedMotionOverride: serializer.fromJson<String>(
        json['reducedMotionOverride'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'themeMode': serializer.toJson<String>(themeMode),
      'localeOverride': serializer.toJson<String?>(localeOverride),
      'unitSystem': serializer.toJson<String>(unitSystem),
      'defaultLoadLevel': serializer.toJson<String>(defaultLoadLevel),
      'defaultSoilLevel': serializer.toJson<String>(defaultSoilLevel),
      'defaultWaterLevel': serializer.toJson<String>(defaultWaterLevel),
      'selectedDetergentId': serializer.toJson<String?>(selectedDetergentId),
      'reducedMotionOverride': serializer.toJson<String>(reducedMotionOverride),
    };
  }

  AppSetting copyWith({
    int? id,
    bool? onboardingCompleted,
    String? themeMode,
    Value<String?> localeOverride = const Value.absent(),
    String? unitSystem,
    String? defaultLoadLevel,
    String? defaultSoilLevel,
    String? defaultWaterLevel,
    Value<String?> selectedDetergentId = const Value.absent(),
    String? reducedMotionOverride,
  }) => AppSetting(
    id: id ?? this.id,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    themeMode: themeMode ?? this.themeMode,
    localeOverride: localeOverride.present
        ? localeOverride.value
        : this.localeOverride,
    unitSystem: unitSystem ?? this.unitSystem,
    defaultLoadLevel: defaultLoadLevel ?? this.defaultLoadLevel,
    defaultSoilLevel: defaultSoilLevel ?? this.defaultSoilLevel,
    defaultWaterLevel: defaultWaterLevel ?? this.defaultWaterLevel,
    selectedDetergentId: selectedDetergentId.present
        ? selectedDetergentId.value
        : this.selectedDetergentId,
    reducedMotionOverride: reducedMotionOverride ?? this.reducedMotionOverride,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      localeOverride: data.localeOverride.present
          ? data.localeOverride.value
          : this.localeOverride,
      unitSystem: data.unitSystem.present
          ? data.unitSystem.value
          : this.unitSystem,
      defaultLoadLevel: data.defaultLoadLevel.present
          ? data.defaultLoadLevel.value
          : this.defaultLoadLevel,
      defaultSoilLevel: data.defaultSoilLevel.present
          ? data.defaultSoilLevel.value
          : this.defaultSoilLevel,
      defaultWaterLevel: data.defaultWaterLevel.present
          ? data.defaultWaterLevel.value
          : this.defaultWaterLevel,
      selectedDetergentId: data.selectedDetergentId.present
          ? data.selectedDetergentId.value
          : this.selectedDetergentId,
      reducedMotionOverride: data.reducedMotionOverride.present
          ? data.reducedMotionOverride.value
          : this.reducedMotionOverride,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('themeMode: $themeMode, ')
          ..write('localeOverride: $localeOverride, ')
          ..write('unitSystem: $unitSystem, ')
          ..write('defaultLoadLevel: $defaultLoadLevel, ')
          ..write('defaultSoilLevel: $defaultSoilLevel, ')
          ..write('defaultWaterLevel: $defaultWaterLevel, ')
          ..write('selectedDetergentId: $selectedDetergentId, ')
          ..write('reducedMotionOverride: $reducedMotionOverride')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    onboardingCompleted,
    themeMode,
    localeOverride,
    unitSystem,
    defaultLoadLevel,
    defaultSoilLevel,
    defaultWaterLevel,
    selectedDetergentId,
    reducedMotionOverride,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.themeMode == this.themeMode &&
          other.localeOverride == this.localeOverride &&
          other.unitSystem == this.unitSystem &&
          other.defaultLoadLevel == this.defaultLoadLevel &&
          other.defaultSoilLevel == this.defaultSoilLevel &&
          other.defaultWaterLevel == this.defaultWaterLevel &&
          other.selectedDetergentId == this.selectedDetergentId &&
          other.reducedMotionOverride == this.reducedMotionOverride);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<bool> onboardingCompleted;
  final Value<String> themeMode;
  final Value<String?> localeOverride;
  final Value<String> unitSystem;
  final Value<String> defaultLoadLevel;
  final Value<String> defaultSoilLevel;
  final Value<String> defaultWaterLevel;
  final Value<String?> selectedDetergentId;
  final Value<String> reducedMotionOverride;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.localeOverride = const Value.absent(),
    this.unitSystem = const Value.absent(),
    this.defaultLoadLevel = const Value.absent(),
    this.defaultSoilLevel = const Value.absent(),
    this.defaultWaterLevel = const Value.absent(),
    this.selectedDetergentId = const Value.absent(),
    this.reducedMotionOverride = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.localeOverride = const Value.absent(),
    this.unitSystem = const Value.absent(),
    this.defaultLoadLevel = const Value.absent(),
    this.defaultSoilLevel = const Value.absent(),
    this.defaultWaterLevel = const Value.absent(),
    this.selectedDetergentId = const Value.absent(),
    this.reducedMotionOverride = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<bool>? onboardingCompleted,
    Expression<String>? themeMode,
    Expression<String>? localeOverride,
    Expression<String>? unitSystem,
    Expression<String>? defaultLoadLevel,
    Expression<String>? defaultSoilLevel,
    Expression<String>? defaultWaterLevel,
    Expression<String>? selectedDetergentId,
    Expression<String>? reducedMotionOverride,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (themeMode != null) 'theme_mode': themeMode,
      if (localeOverride != null) 'locale_override': localeOverride,
      if (unitSystem != null) 'unit_system': unitSystem,
      if (defaultLoadLevel != null) 'default_load_level': defaultLoadLevel,
      if (defaultSoilLevel != null) 'default_soil_level': defaultSoilLevel,
      if (defaultWaterLevel != null) 'default_water_level': defaultWaterLevel,
      if (selectedDetergentId != null)
        'selected_detergent_id': selectedDetergentId,
      if (reducedMotionOverride != null)
        'reduced_motion_override': reducedMotionOverride,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? onboardingCompleted,
    Value<String>? themeMode,
    Value<String?>? localeOverride,
    Value<String>? unitSystem,
    Value<String>? defaultLoadLevel,
    Value<String>? defaultSoilLevel,
    Value<String>? defaultWaterLevel,
    Value<String?>? selectedDetergentId,
    Value<String>? reducedMotionOverride,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      themeMode: themeMode ?? this.themeMode,
      localeOverride: localeOverride ?? this.localeOverride,
      unitSystem: unitSystem ?? this.unitSystem,
      defaultLoadLevel: defaultLoadLevel ?? this.defaultLoadLevel,
      defaultSoilLevel: defaultSoilLevel ?? this.defaultSoilLevel,
      defaultWaterLevel: defaultWaterLevel ?? this.defaultWaterLevel,
      selectedDetergentId: selectedDetergentId ?? this.selectedDetergentId,
      reducedMotionOverride:
          reducedMotionOverride ?? this.reducedMotionOverride,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (localeOverride.present) {
      map['locale_override'] = Variable<String>(localeOverride.value);
    }
    if (unitSystem.present) {
      map['unit_system'] = Variable<String>(unitSystem.value);
    }
    if (defaultLoadLevel.present) {
      map['default_load_level'] = Variable<String>(defaultLoadLevel.value);
    }
    if (defaultSoilLevel.present) {
      map['default_soil_level'] = Variable<String>(defaultSoilLevel.value);
    }
    if (defaultWaterLevel.present) {
      map['default_water_level'] = Variable<String>(defaultWaterLevel.value);
    }
    if (selectedDetergentId.present) {
      map['selected_detergent_id'] = Variable<String>(
        selectedDetergentId.value,
      );
    }
    if (reducedMotionOverride.present) {
      map['reduced_motion_override'] = Variable<String>(
        reducedMotionOverride.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('themeMode: $themeMode, ')
          ..write('localeOverride: $localeOverride, ')
          ..write('unitSystem: $unitSystem, ')
          ..write('defaultLoadLevel: $defaultLoadLevel, ')
          ..write('defaultSoilLevel: $defaultSoilLevel, ')
          ..write('defaultWaterLevel: $defaultWaterLevel, ')
          ..write('selectedDetergentId: $selectedDetergentId, ')
          ..write('reducedMotionOverride: $reducedMotionOverride')
          ..write(')'))
        .toString();
  }
}

class $AdStatesTable extends AdStates with TableInfo<$AdStatesTable, AdState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lifetimeSuccessfulLogsMeta =
      const VerificationMeta('lifetimeSuccessfulLogs');
  @override
  late final GeneratedColumn<int> lifetimeSuccessfulLogs = GeneratedColumn<int>(
    'lifetime_successful_logs',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastInterstitialAtUtcMeta =
      const VerificationMeta('lastInterstitialAtUtc');
  @override
  late final GeneratedColumn<DateTime> lastInterstitialAtUtc =
      GeneratedColumn<DateTime>(
        'last_interstitial_at_utc',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _adsShownTodayMeta = const VerificationMeta(
    'adsShownToday',
  );
  @override
  late final GeneratedColumn<int> adsShownToday = GeneratedColumn<int>(
    'ads_shown_today',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _adsShownDateLocalMeta = const VerificationMeta(
    'adsShownDateLocal',
  );
  @override
  late final GeneratedColumn<String> adsShownDateLocal =
      GeneratedColumn<String>(
        'ads_shown_date_local',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _firstSessionCompletedMeta =
      const VerificationMeta('firstSessionCompleted');
  @override
  late final GeneratedColumn<bool> firstSessionCompleted =
      GeneratedColumn<bool>(
        'first_session_completed',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("first_session_completed" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _lastEligibilityConsumedLogIdMeta =
      const VerificationMeta('lastEligibilityConsumedLogId');
  @override
  late final GeneratedColumn<String> lastEligibilityConsumedLogId =
      GeneratedColumn<String>(
        'last_eligibility_consumed_log_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lifetimeSuccessfulLogs,
    lastInterstitialAtUtc,
    adsShownToday,
    adsShownDateLocal,
    firstSessionCompleted,
    lastEligibilityConsumedLogId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ad_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lifetime_successful_logs')) {
      context.handle(
        _lifetimeSuccessfulLogsMeta,
        lifetimeSuccessfulLogs.isAcceptableOrUnknown(
          data['lifetime_successful_logs']!,
          _lifetimeSuccessfulLogsMeta,
        ),
      );
    }
    if (data.containsKey('last_interstitial_at_utc')) {
      context.handle(
        _lastInterstitialAtUtcMeta,
        lastInterstitialAtUtc.isAcceptableOrUnknown(
          data['last_interstitial_at_utc']!,
          _lastInterstitialAtUtcMeta,
        ),
      );
    }
    if (data.containsKey('ads_shown_today')) {
      context.handle(
        _adsShownTodayMeta,
        adsShownToday.isAcceptableOrUnknown(
          data['ads_shown_today']!,
          _adsShownTodayMeta,
        ),
      );
    }
    if (data.containsKey('ads_shown_date_local')) {
      context.handle(
        _adsShownDateLocalMeta,
        adsShownDateLocal.isAcceptableOrUnknown(
          data['ads_shown_date_local']!,
          _adsShownDateLocalMeta,
        ),
      );
    }
    if (data.containsKey('first_session_completed')) {
      context.handle(
        _firstSessionCompletedMeta,
        firstSessionCompleted.isAcceptableOrUnknown(
          data['first_session_completed']!,
          _firstSessionCompletedMeta,
        ),
      );
    }
    if (data.containsKey('last_eligibility_consumed_log_id')) {
      context.handle(
        _lastEligibilityConsumedLogIdMeta,
        lastEligibilityConsumedLogId.isAcceptableOrUnknown(
          data['last_eligibility_consumed_log_id']!,
          _lastEligibilityConsumedLogIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AdState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lifetimeSuccessfulLogs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifetime_successful_logs'],
      )!,
      lastInterstitialAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_interstitial_at_utc'],
      ),
      adsShownToday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ads_shown_today'],
      )!,
      adsShownDateLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ads_shown_date_local'],
      ),
      firstSessionCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}first_session_completed'],
      )!,
      lastEligibilityConsumedLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_eligibility_consumed_log_id'],
      ),
    );
  }

  @override
  $AdStatesTable createAlias(String alias) {
    return $AdStatesTable(attachedDatabase, alias);
  }
}

class AdState extends DataClass implements Insertable<AdState> {
  final int id;
  final int lifetimeSuccessfulLogs;
  final DateTime? lastInterstitialAtUtc;
  final int adsShownToday;
  final String? adsShownDateLocal;
  final bool firstSessionCompleted;
  final String? lastEligibilityConsumedLogId;
  const AdState({
    required this.id,
    required this.lifetimeSuccessfulLogs,
    this.lastInterstitialAtUtc,
    required this.adsShownToday,
    this.adsShownDateLocal,
    required this.firstSessionCompleted,
    this.lastEligibilityConsumedLogId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lifetime_successful_logs'] = Variable<int>(lifetimeSuccessfulLogs);
    if (!nullToAbsent || lastInterstitialAtUtc != null) {
      map['last_interstitial_at_utc'] = Variable<DateTime>(
        lastInterstitialAtUtc,
      );
    }
    map['ads_shown_today'] = Variable<int>(adsShownToday);
    if (!nullToAbsent || adsShownDateLocal != null) {
      map['ads_shown_date_local'] = Variable<String>(adsShownDateLocal);
    }
    map['first_session_completed'] = Variable<bool>(firstSessionCompleted);
    if (!nullToAbsent || lastEligibilityConsumedLogId != null) {
      map['last_eligibility_consumed_log_id'] = Variable<String>(
        lastEligibilityConsumedLogId,
      );
    }
    return map;
  }

  AdStatesCompanion toCompanion(bool nullToAbsent) {
    return AdStatesCompanion(
      id: Value(id),
      lifetimeSuccessfulLogs: Value(lifetimeSuccessfulLogs),
      lastInterstitialAtUtc: lastInterstitialAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(lastInterstitialAtUtc),
      adsShownToday: Value(adsShownToday),
      adsShownDateLocal: adsShownDateLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(adsShownDateLocal),
      firstSessionCompleted: Value(firstSessionCompleted),
      lastEligibilityConsumedLogId:
          lastEligibilityConsumedLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastEligibilityConsumedLogId),
    );
  }

  factory AdState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdState(
      id: serializer.fromJson<int>(json['id']),
      lifetimeSuccessfulLogs: serializer.fromJson<int>(
        json['lifetimeSuccessfulLogs'],
      ),
      lastInterstitialAtUtc: serializer.fromJson<DateTime?>(
        json['lastInterstitialAtUtc'],
      ),
      adsShownToday: serializer.fromJson<int>(json['adsShownToday']),
      adsShownDateLocal: serializer.fromJson<String?>(
        json['adsShownDateLocal'],
      ),
      firstSessionCompleted: serializer.fromJson<bool>(
        json['firstSessionCompleted'],
      ),
      lastEligibilityConsumedLogId: serializer.fromJson<String?>(
        json['lastEligibilityConsumedLogId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lifetimeSuccessfulLogs': serializer.toJson<int>(lifetimeSuccessfulLogs),
      'lastInterstitialAtUtc': serializer.toJson<DateTime?>(
        lastInterstitialAtUtc,
      ),
      'adsShownToday': serializer.toJson<int>(adsShownToday),
      'adsShownDateLocal': serializer.toJson<String?>(adsShownDateLocal),
      'firstSessionCompleted': serializer.toJson<bool>(firstSessionCompleted),
      'lastEligibilityConsumedLogId': serializer.toJson<String?>(
        lastEligibilityConsumedLogId,
      ),
    };
  }

  AdState copyWith({
    int? id,
    int? lifetimeSuccessfulLogs,
    Value<DateTime?> lastInterstitialAtUtc = const Value.absent(),
    int? adsShownToday,
    Value<String?> adsShownDateLocal = const Value.absent(),
    bool? firstSessionCompleted,
    Value<String?> lastEligibilityConsumedLogId = const Value.absent(),
  }) => AdState(
    id: id ?? this.id,
    lifetimeSuccessfulLogs:
        lifetimeSuccessfulLogs ?? this.lifetimeSuccessfulLogs,
    lastInterstitialAtUtc: lastInterstitialAtUtc.present
        ? lastInterstitialAtUtc.value
        : this.lastInterstitialAtUtc,
    adsShownToday: adsShownToday ?? this.adsShownToday,
    adsShownDateLocal: adsShownDateLocal.present
        ? adsShownDateLocal.value
        : this.adsShownDateLocal,
    firstSessionCompleted: firstSessionCompleted ?? this.firstSessionCompleted,
    lastEligibilityConsumedLogId: lastEligibilityConsumedLogId.present
        ? lastEligibilityConsumedLogId.value
        : this.lastEligibilityConsumedLogId,
  );
  AdState copyWithCompanion(AdStatesCompanion data) {
    return AdState(
      id: data.id.present ? data.id.value : this.id,
      lifetimeSuccessfulLogs: data.lifetimeSuccessfulLogs.present
          ? data.lifetimeSuccessfulLogs.value
          : this.lifetimeSuccessfulLogs,
      lastInterstitialAtUtc: data.lastInterstitialAtUtc.present
          ? data.lastInterstitialAtUtc.value
          : this.lastInterstitialAtUtc,
      adsShownToday: data.adsShownToday.present
          ? data.adsShownToday.value
          : this.adsShownToday,
      adsShownDateLocal: data.adsShownDateLocal.present
          ? data.adsShownDateLocal.value
          : this.adsShownDateLocal,
      firstSessionCompleted: data.firstSessionCompleted.present
          ? data.firstSessionCompleted.value
          : this.firstSessionCompleted,
      lastEligibilityConsumedLogId: data.lastEligibilityConsumedLogId.present
          ? data.lastEligibilityConsumedLogId.value
          : this.lastEligibilityConsumedLogId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdState(')
          ..write('id: $id, ')
          ..write('lifetimeSuccessfulLogs: $lifetimeSuccessfulLogs, ')
          ..write('lastInterstitialAtUtc: $lastInterstitialAtUtc, ')
          ..write('adsShownToday: $adsShownToday, ')
          ..write('adsShownDateLocal: $adsShownDateLocal, ')
          ..write('firstSessionCompleted: $firstSessionCompleted, ')
          ..write('lastEligibilityConsumedLogId: $lastEligibilityConsumedLogId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lifetimeSuccessfulLogs,
    lastInterstitialAtUtc,
    adsShownToday,
    adsShownDateLocal,
    firstSessionCompleted,
    lastEligibilityConsumedLogId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdState &&
          other.id == this.id &&
          other.lifetimeSuccessfulLogs == this.lifetimeSuccessfulLogs &&
          other.lastInterstitialAtUtc == this.lastInterstitialAtUtc &&
          other.adsShownToday == this.adsShownToday &&
          other.adsShownDateLocal == this.adsShownDateLocal &&
          other.firstSessionCompleted == this.firstSessionCompleted &&
          other.lastEligibilityConsumedLogId ==
              this.lastEligibilityConsumedLogId);
}

class AdStatesCompanion extends UpdateCompanion<AdState> {
  final Value<int> id;
  final Value<int> lifetimeSuccessfulLogs;
  final Value<DateTime?> lastInterstitialAtUtc;
  final Value<int> adsShownToday;
  final Value<String?> adsShownDateLocal;
  final Value<bool> firstSessionCompleted;
  final Value<String?> lastEligibilityConsumedLogId;
  const AdStatesCompanion({
    this.id = const Value.absent(),
    this.lifetimeSuccessfulLogs = const Value.absent(),
    this.lastInterstitialAtUtc = const Value.absent(),
    this.adsShownToday = const Value.absent(),
    this.adsShownDateLocal = const Value.absent(),
    this.firstSessionCompleted = const Value.absent(),
    this.lastEligibilityConsumedLogId = const Value.absent(),
  });
  AdStatesCompanion.insert({
    this.id = const Value.absent(),
    this.lifetimeSuccessfulLogs = const Value.absent(),
    this.lastInterstitialAtUtc = const Value.absent(),
    this.adsShownToday = const Value.absent(),
    this.adsShownDateLocal = const Value.absent(),
    this.firstSessionCompleted = const Value.absent(),
    this.lastEligibilityConsumedLogId = const Value.absent(),
  });
  static Insertable<AdState> custom({
    Expression<int>? id,
    Expression<int>? lifetimeSuccessfulLogs,
    Expression<DateTime>? lastInterstitialAtUtc,
    Expression<int>? adsShownToday,
    Expression<String>? adsShownDateLocal,
    Expression<bool>? firstSessionCompleted,
    Expression<String>? lastEligibilityConsumedLogId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lifetimeSuccessfulLogs != null)
        'lifetime_successful_logs': lifetimeSuccessfulLogs,
      if (lastInterstitialAtUtc != null)
        'last_interstitial_at_utc': lastInterstitialAtUtc,
      if (adsShownToday != null) 'ads_shown_today': adsShownToday,
      if (adsShownDateLocal != null) 'ads_shown_date_local': adsShownDateLocal,
      if (firstSessionCompleted != null)
        'first_session_completed': firstSessionCompleted,
      if (lastEligibilityConsumedLogId != null)
        'last_eligibility_consumed_log_id': lastEligibilityConsumedLogId,
    });
  }

  AdStatesCompanion copyWith({
    Value<int>? id,
    Value<int>? lifetimeSuccessfulLogs,
    Value<DateTime?>? lastInterstitialAtUtc,
    Value<int>? adsShownToday,
    Value<String?>? adsShownDateLocal,
    Value<bool>? firstSessionCompleted,
    Value<String?>? lastEligibilityConsumedLogId,
  }) {
    return AdStatesCompanion(
      id: id ?? this.id,
      lifetimeSuccessfulLogs:
          lifetimeSuccessfulLogs ?? this.lifetimeSuccessfulLogs,
      lastInterstitialAtUtc:
          lastInterstitialAtUtc ?? this.lastInterstitialAtUtc,
      adsShownToday: adsShownToday ?? this.adsShownToday,
      adsShownDateLocal: adsShownDateLocal ?? this.adsShownDateLocal,
      firstSessionCompleted:
          firstSessionCompleted ?? this.firstSessionCompleted,
      lastEligibilityConsumedLogId:
          lastEligibilityConsumedLogId ?? this.lastEligibilityConsumedLogId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lifetimeSuccessfulLogs.present) {
      map['lifetime_successful_logs'] = Variable<int>(
        lifetimeSuccessfulLogs.value,
      );
    }
    if (lastInterstitialAtUtc.present) {
      map['last_interstitial_at_utc'] = Variable<DateTime>(
        lastInterstitialAtUtc.value,
      );
    }
    if (adsShownToday.present) {
      map['ads_shown_today'] = Variable<int>(adsShownToday.value);
    }
    if (adsShownDateLocal.present) {
      map['ads_shown_date_local'] = Variable<String>(adsShownDateLocal.value);
    }
    if (firstSessionCompleted.present) {
      map['first_session_completed'] = Variable<bool>(
        firstSessionCompleted.value,
      );
    }
    if (lastEligibilityConsumedLogId.present) {
      map['last_eligibility_consumed_log_id'] = Variable<String>(
        lastEligibilityConsumedLogId.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdStatesCompanion(')
          ..write('id: $id, ')
          ..write('lifetimeSuccessfulLogs: $lifetimeSuccessfulLogs, ')
          ..write('lastInterstitialAtUtc: $lastInterstitialAtUtc, ')
          ..write('adsShownToday: $adsShownToday, ')
          ..write('adsShownDateLocal: $adsShownDateLocal, ')
          ..write('firstSessionCompleted: $firstSessionCompleted, ')
          ..write('lastEligibilityConsumedLogId: $lastEligibilityConsumedLogId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DetergentProfilesTable detergentProfiles =
      $DetergentProfilesTable(this);
  late final $DoseRulesTable doseRules = $DoseRulesTable(this);
  late final $DoseAdjustmentsTable doseAdjustments = $DoseAdjustmentsTable(
    this,
  );
  late final $MeasureMarkersTable measureMarkers = $MeasureMarkersTable(this);
  late final $WashLogsTable washLogs = $WashLogsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $AdStatesTable adStates = $AdStatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    detergentProfiles,
    doseRules,
    doseAdjustments,
    measureMarkers,
    washLogs,
    appSettings,
    adStates,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'detergent_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('dose_rules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'detergent_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('dose_adjustments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'detergent_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('measure_markers', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'detergent_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('wash_logs', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'detergent_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('app_settings', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$DetergentProfilesTableCreateCompanionBuilder =
    DetergentProfilesCompanion Function({
      required String id,
      required String name,
      Value<String?> brand,
      required String detergentType,
      Value<String> ruleStrategy,
      Value<String> doseBasis,
      required String canonicalUnit,
      required String preferredDisplayUnit,
      Value<bool> soilEnabled,
      Value<bool> waterEnabled,
      Value<String> machineVariant,
      Value<String?> unknownWaterFallback,
      Value<double?> packageQuantityCanonical,
      Value<double?> packagePrice,
      Value<String?> currencyCode,
      Value<String?> photoRelativePath,
      Value<bool> isDefault,
      required DateTime createdAtUtc,
      required DateTime updatedAtUtc,
      Value<int> rowid,
    });
typedef $$DetergentProfilesTableUpdateCompanionBuilder =
    DetergentProfilesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> brand,
      Value<String> detergentType,
      Value<String> ruleStrategy,
      Value<String> doseBasis,
      Value<String> canonicalUnit,
      Value<String> preferredDisplayUnit,
      Value<bool> soilEnabled,
      Value<bool> waterEnabled,
      Value<String> machineVariant,
      Value<String?> unknownWaterFallback,
      Value<double?> packageQuantityCanonical,
      Value<double?> packagePrice,
      Value<String?> currencyCode,
      Value<String?> photoRelativePath,
      Value<bool> isDefault,
      Value<DateTime> createdAtUtc,
      Value<DateTime> updatedAtUtc,
      Value<int> rowid,
    });

final class $$DetergentProfilesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DetergentProfilesTable,
          DetergentProfile
        > {
  $$DetergentProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DoseRulesTable, List<DoseRule>>
  _doseRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.doseRules,
    aliasName: 'detergent_profiles__id__dose_rules__detergent_id',
  );

  $$DoseRulesTableProcessedTableManager get doseRulesRefs {
    final manager = $$DoseRulesTableTableManager(
      $_db,
      $_db.doseRules,
    ).filter((f) => f.detergentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_doseRulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DoseAdjustmentsTable, List<DoseAdjustment>>
  _doseAdjustmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.doseAdjustments,
    aliasName: 'detergent_profiles__id__dose_adjustments__detergent_id',
  );

  $$DoseAdjustmentsTableProcessedTableManager get doseAdjustmentsRefs {
    final manager = $$DoseAdjustmentsTableTableManager(
      $_db,
      $_db.doseAdjustments,
    ).filter((f) => f.detergentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _doseAdjustmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MeasureMarkersTable, List<MeasureMarker>>
  _measureMarkersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.measureMarkers,
    aliasName: 'detergent_profiles__id__measure_markers__detergent_id',
  );

  $$MeasureMarkersTableProcessedTableManager get measureMarkersRefs {
    final manager = $$MeasureMarkersTableTableManager(
      $_db,
      $_db.measureMarkers,
    ).filter((f) => f.detergentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_measureMarkersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WashLogsTable, List<WashLog>> _washLogsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.washLogs,
    aliasName: 'detergent_profiles__id__wash_logs__detergent_id',
  );

  $$WashLogsTableProcessedTableManager get washLogsRefs {
    final manager = $$WashLogsTableTableManager(
      $_db,
      $_db.washLogs,
    ).filter((f) => f.detergentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_washLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AppSettingsTable, List<AppSetting>>
  _appSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appSettings,
    aliasName: 'detergent_profiles__id__app_settings__selected_detergent_id',
  );

  $$AppSettingsTableProcessedTableManager get appSettingsRefs {
    final manager = $$AppSettingsTableTableManager($_db, $_db.appSettings)
        .filter(
          (f) =>
              f.selectedDetergentId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_appSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DetergentProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $DetergentProfilesTable> {
  $$DetergentProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detergentType => $composableBuilder(
    column: $table.detergentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleStrategy => $composableBuilder(
    column: $table.ruleStrategy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doseBasis => $composableBuilder(
    column: $table.doseBasis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalUnit => $composableBuilder(
    column: $table.canonicalUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredDisplayUnit => $composableBuilder(
    column: $table.preferredDisplayUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soilEnabled => $composableBuilder(
    column: $table.soilEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get waterEnabled => $composableBuilder(
    column: $table.waterEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get machineVariant => $composableBuilder(
    column: $table.machineVariant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unknownWaterFallback => $composableBuilder(
    column: $table.unknownWaterFallback,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packageQuantityCanonical => $composableBuilder(
    column: $table.packageQuantityCanonical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get packagePrice => $composableBuilder(
    column: $table.packagePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoRelativePath => $composableBuilder(
    column: $table.photoRelativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> doseRulesRefs(
    Expression<bool> Function($$DoseRulesTableFilterComposer f) f,
  ) {
    final $$DoseRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.doseRules,
      getReferencedColumn: (t) => t.detergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoseRulesTableFilterComposer(
            $db: $db,
            $table: $db.doseRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> doseAdjustmentsRefs(
    Expression<bool> Function($$DoseAdjustmentsTableFilterComposer f) f,
  ) {
    final $$DoseAdjustmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.doseAdjustments,
      getReferencedColumn: (t) => t.detergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoseAdjustmentsTableFilterComposer(
            $db: $db,
            $table: $db.doseAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> measureMarkersRefs(
    Expression<bool> Function($$MeasureMarkersTableFilterComposer f) f,
  ) {
    final $$MeasureMarkersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.measureMarkers,
      getReferencedColumn: (t) => t.detergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasureMarkersTableFilterComposer(
            $db: $db,
            $table: $db.measureMarkers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> washLogsRefs(
    Expression<bool> Function($$WashLogsTableFilterComposer f) f,
  ) {
    final $$WashLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.washLogs,
      getReferencedColumn: (t) => t.detergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WashLogsTableFilterComposer(
            $db: $db,
            $table: $db.washLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> appSettingsRefs(
    Expression<bool> Function($$AppSettingsTableFilterComposer f) f,
  ) {
    final $$AppSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appSettings,
      getReferencedColumn: (t) => t.selectedDetergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppSettingsTableFilterComposer(
            $db: $db,
            $table: $db.appSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DetergentProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $DetergentProfilesTable> {
  $$DetergentProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detergentType => $composableBuilder(
    column: $table.detergentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleStrategy => $composableBuilder(
    column: $table.ruleStrategy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doseBasis => $composableBuilder(
    column: $table.doseBasis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalUnit => $composableBuilder(
    column: $table.canonicalUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredDisplayUnit => $composableBuilder(
    column: $table.preferredDisplayUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soilEnabled => $composableBuilder(
    column: $table.soilEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get waterEnabled => $composableBuilder(
    column: $table.waterEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get machineVariant => $composableBuilder(
    column: $table.machineVariant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unknownWaterFallback => $composableBuilder(
    column: $table.unknownWaterFallback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packageQuantityCanonical => $composableBuilder(
    column: $table.packageQuantityCanonical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get packagePrice => $composableBuilder(
    column: $table.packagePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoRelativePath => $composableBuilder(
    column: $table.photoRelativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DetergentProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DetergentProfilesTable> {
  $$DetergentProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get detergentType => $composableBuilder(
    column: $table.detergentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleStrategy => $composableBuilder(
    column: $table.ruleStrategy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get doseBasis =>
      $composableBuilder(column: $table.doseBasis, builder: (column) => column);

  GeneratedColumn<String> get canonicalUnit => $composableBuilder(
    column: $table.canonicalUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredDisplayUnit => $composableBuilder(
    column: $table.preferredDisplayUnit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get soilEnabled => $composableBuilder(
    column: $table.soilEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get waterEnabled => $composableBuilder(
    column: $table.waterEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get machineVariant => $composableBuilder(
    column: $table.machineVariant,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unknownWaterFallback => $composableBuilder(
    column: $table.unknownWaterFallback,
    builder: (column) => column,
  );

  GeneratedColumn<double> get packageQuantityCanonical => $composableBuilder(
    column: $table.packageQuantityCanonical,
    builder: (column) => column,
  );

  GeneratedColumn<double> get packagePrice => $composableBuilder(
    column: $table.packagePrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoRelativePath => $composableBuilder(
    column: $table.photoRelativePath,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => column,
  );

  Expression<T> doseRulesRefs<T extends Object>(
    Expression<T> Function($$DoseRulesTableAnnotationComposer a) f,
  ) {
    final $$DoseRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.doseRules,
      getReferencedColumn: (t) => t.detergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoseRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.doseRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> doseAdjustmentsRefs<T extends Object>(
    Expression<T> Function($$DoseAdjustmentsTableAnnotationComposer a) f,
  ) {
    final $$DoseAdjustmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.doseAdjustments,
      getReferencedColumn: (t) => t.detergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoseAdjustmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.doseAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> measureMarkersRefs<T extends Object>(
    Expression<T> Function($$MeasureMarkersTableAnnotationComposer a) f,
  ) {
    final $$MeasureMarkersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.measureMarkers,
      getReferencedColumn: (t) => t.detergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasureMarkersTableAnnotationComposer(
            $db: $db,
            $table: $db.measureMarkers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> washLogsRefs<T extends Object>(
    Expression<T> Function($$WashLogsTableAnnotationComposer a) f,
  ) {
    final $$WashLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.washLogs,
      getReferencedColumn: (t) => t.detergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WashLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.washLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> appSettingsRefs<T extends Object>(
    Expression<T> Function($$AppSettingsTableAnnotationComposer a) f,
  ) {
    final $$AppSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appSettings,
      getReferencedColumn: (t) => t.selectedDetergentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.appSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DetergentProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DetergentProfilesTable,
          DetergentProfile,
          $$DetergentProfilesTableFilterComposer,
          $$DetergentProfilesTableOrderingComposer,
          $$DetergentProfilesTableAnnotationComposer,
          $$DetergentProfilesTableCreateCompanionBuilder,
          $$DetergentProfilesTableUpdateCompanionBuilder,
          (DetergentProfile, $$DetergentProfilesTableReferences),
          DetergentProfile,
          PrefetchHooks Function({
            bool doseRulesRefs,
            bool doseAdjustmentsRefs,
            bool measureMarkersRefs,
            bool washLogsRefs,
            bool appSettingsRefs,
          })
        > {
  $$DetergentProfilesTableTableManager(
    _$AppDatabase db,
    $DetergentProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DetergentProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DetergentProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DetergentProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String> detergentType = const Value.absent(),
                Value<String> ruleStrategy = const Value.absent(),
                Value<String> doseBasis = const Value.absent(),
                Value<String> canonicalUnit = const Value.absent(),
                Value<String> preferredDisplayUnit = const Value.absent(),
                Value<bool> soilEnabled = const Value.absent(),
                Value<bool> waterEnabled = const Value.absent(),
                Value<String> machineVariant = const Value.absent(),
                Value<String?> unknownWaterFallback = const Value.absent(),
                Value<double?> packageQuantityCanonical = const Value.absent(),
                Value<double?> packagePrice = const Value.absent(),
                Value<String?> currencyCode = const Value.absent(),
                Value<String?> photoRelativePath = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<DateTime> updatedAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DetergentProfilesCompanion(
                id: id,
                name: name,
                brand: brand,
                detergentType: detergentType,
                ruleStrategy: ruleStrategy,
                doseBasis: doseBasis,
                canonicalUnit: canonicalUnit,
                preferredDisplayUnit: preferredDisplayUnit,
                soilEnabled: soilEnabled,
                waterEnabled: waterEnabled,
                machineVariant: machineVariant,
                unknownWaterFallback: unknownWaterFallback,
                packageQuantityCanonical: packageQuantityCanonical,
                packagePrice: packagePrice,
                currencyCode: currencyCode,
                photoRelativePath: photoRelativePath,
                isDefault: isDefault,
                createdAtUtc: createdAtUtc,
                updatedAtUtc: updatedAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> brand = const Value.absent(),
                required String detergentType,
                Value<String> ruleStrategy = const Value.absent(),
                Value<String> doseBasis = const Value.absent(),
                required String canonicalUnit,
                required String preferredDisplayUnit,
                Value<bool> soilEnabled = const Value.absent(),
                Value<bool> waterEnabled = const Value.absent(),
                Value<String> machineVariant = const Value.absent(),
                Value<String?> unknownWaterFallback = const Value.absent(),
                Value<double?> packageQuantityCanonical = const Value.absent(),
                Value<double?> packagePrice = const Value.absent(),
                Value<String?> currencyCode = const Value.absent(),
                Value<String?> photoRelativePath = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                required DateTime createdAtUtc,
                required DateTime updatedAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => DetergentProfilesCompanion.insert(
                id: id,
                name: name,
                brand: brand,
                detergentType: detergentType,
                ruleStrategy: ruleStrategy,
                doseBasis: doseBasis,
                canonicalUnit: canonicalUnit,
                preferredDisplayUnit: preferredDisplayUnit,
                soilEnabled: soilEnabled,
                waterEnabled: waterEnabled,
                machineVariant: machineVariant,
                unknownWaterFallback: unknownWaterFallback,
                packageQuantityCanonical: packageQuantityCanonical,
                packagePrice: packagePrice,
                currencyCode: currencyCode,
                photoRelativePath: photoRelativePath,
                isDefault: isDefault,
                createdAtUtc: createdAtUtc,
                updatedAtUtc: updatedAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DetergentProfilesTable, DetergentProfile>(table),
                  $$DetergentProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                doseRulesRefs = false,
                doseAdjustmentsRefs = false,
                measureMarkersRefs = false,
                washLogsRefs = false,
                appSettingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (doseRulesRefs) db.doseRules,
                    if (doseAdjustmentsRefs) db.doseAdjustments,
                    if (measureMarkersRefs) db.measureMarkers,
                    if (washLogsRefs) db.washLogs,
                    if (appSettingsRefs) db.appSettings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (doseRulesRefs)
                        await $_getPrefetchedData<
                          DetergentProfile,
                          $DetergentProfilesTable,
                          DoseRule
                        >(
                          currentTable: table,
                          referencedTable: $$DetergentProfilesTableReferences
                              ._doseRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DetergentProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).doseRulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.detergentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (doseAdjustmentsRefs)
                        await $_getPrefetchedData<
                          DetergentProfile,
                          $DetergentProfilesTable,
                          DoseAdjustment
                        >(
                          currentTable: table,
                          referencedTable: $$DetergentProfilesTableReferences
                              ._doseAdjustmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DetergentProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).doseAdjustmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.detergentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (measureMarkersRefs)
                        await $_getPrefetchedData<
                          DetergentProfile,
                          $DetergentProfilesTable,
                          MeasureMarker
                        >(
                          currentTable: table,
                          referencedTable: $$DetergentProfilesTableReferences
                              ._measureMarkersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DetergentProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).measureMarkersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.detergentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (washLogsRefs)
                        await $_getPrefetchedData<
                          DetergentProfile,
                          $DetergentProfilesTable,
                          WashLog
                        >(
                          currentTable: table,
                          referencedTable: $$DetergentProfilesTableReferences
                              ._washLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DetergentProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).washLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.detergentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (appSettingsRefs)
                        await $_getPrefetchedData<
                          DetergentProfile,
                          $DetergentProfilesTable,
                          AppSetting
                        >(
                          currentTable: table,
                          referencedTable: $$DetergentProfilesTableReferences
                              ._appSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DetergentProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).appSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.selectedDetergentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DetergentProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DetergentProfilesTable,
      DetergentProfile,
      $$DetergentProfilesTableFilterComposer,
      $$DetergentProfilesTableOrderingComposer,
      $$DetergentProfilesTableAnnotationComposer,
      $$DetergentProfilesTableCreateCompanionBuilder,
      $$DetergentProfilesTableUpdateCompanionBuilder,
      (DetergentProfile, $$DetergentProfilesTableReferences),
      DetergentProfile,
      PrefetchHooks Function({
        bool doseRulesRefs,
        bool doseAdjustmentsRefs,
        bool measureMarkersRefs,
        bool washLogsRefs,
        bool appSettingsRefs,
      })
    >;
typedef $$DoseRulesTableCreateCompanionBuilder =
    DoseRulesCompanion Function({
      required String id,
      required String detergentId,
      Value<String?> loadLevel,
      Value<String?> soilLevel,
      Value<String?> waterLevel,
      required double amountCanonical,
      required DateTime createdAtUtc,
      Value<int> rowid,
    });
typedef $$DoseRulesTableUpdateCompanionBuilder =
    DoseRulesCompanion Function({
      Value<String> id,
      Value<String> detergentId,
      Value<String?> loadLevel,
      Value<String?> soilLevel,
      Value<String?> waterLevel,
      Value<double> amountCanonical,
      Value<DateTime> createdAtUtc,
      Value<int> rowid,
    });

final class $$DoseRulesTableReferences
    extends BaseReferences<_$AppDatabase, $DoseRulesTable, DoseRule> {
  $$DoseRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DetergentProfilesTable _detergentIdTable(_$AppDatabase db) => db
      .detergentProfiles
      .createAlias('dose_rules__detergent_id__detergent_profiles__id');

  $$DetergentProfilesTableProcessedTableManager get detergentId {
    final $_column = $_itemColumn<String>('detergent_id')!;

    final manager = $$DetergentProfilesTableTableManager(
      $_db,
      $_db.detergentProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_detergentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DoseRulesTableFilterComposer
    extends Composer<_$AppDatabase, $DoseRulesTable> {
  $$DoseRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loadLevel => $composableBuilder(
    column: $table.loadLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soilLevel => $composableBuilder(
    column: $table.soilLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get waterLevel => $composableBuilder(
    column: $table.waterLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  $$DetergentProfilesTableFilterComposer get detergentId {
    final $$DetergentProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableFilterComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DoseRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $DoseRulesTable> {
  $$DoseRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loadLevel => $composableBuilder(
    column: $table.loadLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soilLevel => $composableBuilder(
    column: $table.soilLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get waterLevel => $composableBuilder(
    column: $table.waterLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  $$DetergentProfilesTableOrderingComposer get detergentId {
    final $$DetergentProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DoseRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoseRulesTable> {
  $$DoseRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get loadLevel =>
      $composableBuilder(column: $table.loadLevel, builder: (column) => column);

  GeneratedColumn<String> get soilLevel =>
      $composableBuilder(column: $table.soilLevel, builder: (column) => column);

  GeneratedColumn<String> get waterLevel => $composableBuilder(
    column: $table.waterLevel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  $$DetergentProfilesTableAnnotationComposer get detergentId {
    final $$DetergentProfilesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.detergentId,
          referencedTable: $db.detergentProfiles,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DetergentProfilesTableAnnotationComposer(
                $db: $db,
                $table: $db.detergentProfiles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$DoseRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoseRulesTable,
          DoseRule,
          $$DoseRulesTableFilterComposer,
          $$DoseRulesTableOrderingComposer,
          $$DoseRulesTableAnnotationComposer,
          $$DoseRulesTableCreateCompanionBuilder,
          $$DoseRulesTableUpdateCompanionBuilder,
          (DoseRule, $$DoseRulesTableReferences),
          DoseRule,
          PrefetchHooks Function({bool detergentId})
        > {
  $$DoseRulesTableTableManager(_$AppDatabase db, $DoseRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoseRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoseRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoseRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> detergentId = const Value.absent(),
                Value<String?> loadLevel = const Value.absent(),
                Value<String?> soilLevel = const Value.absent(),
                Value<String?> waterLevel = const Value.absent(),
                Value<double> amountCanonical = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseRulesCompanion(
                id: id,
                detergentId: detergentId,
                loadLevel: loadLevel,
                soilLevel: soilLevel,
                waterLevel: waterLevel,
                amountCanonical: amountCanonical,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String detergentId,
                Value<String?> loadLevel = const Value.absent(),
                Value<String?> soilLevel = const Value.absent(),
                Value<String?> waterLevel = const Value.absent(),
                required double amountCanonical,
                required DateTime createdAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => DoseRulesCompanion.insert(
                id: id,
                detergentId: detergentId,
                loadLevel: loadLevel,
                soilLevel: soilLevel,
                waterLevel: waterLevel,
                amountCanonical: amountCanonical,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DoseRulesTable, DoseRule>(table),
                  $$DoseRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({detergentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (detergentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.detergentId,
                                referencedTable: $$DoseRulesTableReferences
                                    ._detergentIdTable(db),
                                referencedColumn: $$DoseRulesTableReferences
                                    ._detergentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DoseRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoseRulesTable,
      DoseRule,
      $$DoseRulesTableFilterComposer,
      $$DoseRulesTableOrderingComposer,
      $$DoseRulesTableAnnotationComposer,
      $$DoseRulesTableCreateCompanionBuilder,
      $$DoseRulesTableUpdateCompanionBuilder,
      (DoseRule, $$DoseRulesTableReferences),
      DoseRule,
      PrefetchHooks Function({bool detergentId})
    >;
typedef $$DoseAdjustmentsTableCreateCompanionBuilder =
    DoseAdjustmentsCompanion Function({
      required String id,
      required String detergentId,
      required String dimension,
      required String optionKey,
      Value<double> deltaCanonical,
      Value<int> rowid,
    });
typedef $$DoseAdjustmentsTableUpdateCompanionBuilder =
    DoseAdjustmentsCompanion Function({
      Value<String> id,
      Value<String> detergentId,
      Value<String> dimension,
      Value<String> optionKey,
      Value<double> deltaCanonical,
      Value<int> rowid,
    });

final class $$DoseAdjustmentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $DoseAdjustmentsTable, DoseAdjustment> {
  $$DoseAdjustmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DetergentProfilesTable _detergentIdTable(_$AppDatabase db) => db
      .detergentProfiles
      .createAlias('dose_adjustments__detergent_id__detergent_profiles__id');

  $$DetergentProfilesTableProcessedTableManager get detergentId {
    final $_column = $_itemColumn<String>('detergent_id')!;

    final manager = $$DetergentProfilesTableTableManager(
      $_db,
      $_db.detergentProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_detergentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DoseAdjustmentsTableFilterComposer
    extends Composer<_$AppDatabase, $DoseAdjustmentsTable> {
  $$DoseAdjustmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dimension => $composableBuilder(
    column: $table.dimension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionKey => $composableBuilder(
    column: $table.optionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deltaCanonical => $composableBuilder(
    column: $table.deltaCanonical,
    builder: (column) => ColumnFilters(column),
  );

  $$DetergentProfilesTableFilterComposer get detergentId {
    final $$DetergentProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableFilterComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DoseAdjustmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DoseAdjustmentsTable> {
  $$DoseAdjustmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dimension => $composableBuilder(
    column: $table.dimension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionKey => $composableBuilder(
    column: $table.optionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deltaCanonical => $composableBuilder(
    column: $table.deltaCanonical,
    builder: (column) => ColumnOrderings(column),
  );

  $$DetergentProfilesTableOrderingComposer get detergentId {
    final $$DetergentProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DoseAdjustmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoseAdjustmentsTable> {
  $$DoseAdjustmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dimension =>
      $composableBuilder(column: $table.dimension, builder: (column) => column);

  GeneratedColumn<String> get optionKey =>
      $composableBuilder(column: $table.optionKey, builder: (column) => column);

  GeneratedColumn<double> get deltaCanonical => $composableBuilder(
    column: $table.deltaCanonical,
    builder: (column) => column,
  );

  $$DetergentProfilesTableAnnotationComposer get detergentId {
    final $$DetergentProfilesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.detergentId,
          referencedTable: $db.detergentProfiles,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DetergentProfilesTableAnnotationComposer(
                $db: $db,
                $table: $db.detergentProfiles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$DoseAdjustmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoseAdjustmentsTable,
          DoseAdjustment,
          $$DoseAdjustmentsTableFilterComposer,
          $$DoseAdjustmentsTableOrderingComposer,
          $$DoseAdjustmentsTableAnnotationComposer,
          $$DoseAdjustmentsTableCreateCompanionBuilder,
          $$DoseAdjustmentsTableUpdateCompanionBuilder,
          (DoseAdjustment, $$DoseAdjustmentsTableReferences),
          DoseAdjustment,
          PrefetchHooks Function({bool detergentId})
        > {
  $$DoseAdjustmentsTableTableManager(
    _$AppDatabase db,
    $DoseAdjustmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoseAdjustmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoseAdjustmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoseAdjustmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> detergentId = const Value.absent(),
                Value<String> dimension = const Value.absent(),
                Value<String> optionKey = const Value.absent(),
                Value<double> deltaCanonical = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseAdjustmentsCompanion(
                id: id,
                detergentId: detergentId,
                dimension: dimension,
                optionKey: optionKey,
                deltaCanonical: deltaCanonical,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String detergentId,
                required String dimension,
                required String optionKey,
                Value<double> deltaCanonical = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseAdjustmentsCompanion.insert(
                id: id,
                detergentId: detergentId,
                dimension: dimension,
                optionKey: optionKey,
                deltaCanonical: deltaCanonical,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DoseAdjustmentsTable, DoseAdjustment>(table),
                  $$DoseAdjustmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({detergentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (detergentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.detergentId,
                                referencedTable:
                                    $$DoseAdjustmentsTableReferences
                                        ._detergentIdTable(db),
                                referencedColumn:
                                    $$DoseAdjustmentsTableReferences
                                        ._detergentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DoseAdjustmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoseAdjustmentsTable,
      DoseAdjustment,
      $$DoseAdjustmentsTableFilterComposer,
      $$DoseAdjustmentsTableOrderingComposer,
      $$DoseAdjustmentsTableAnnotationComposer,
      $$DoseAdjustmentsTableCreateCompanionBuilder,
      $$DoseAdjustmentsTableUpdateCompanionBuilder,
      (DoseAdjustment, $$DoseAdjustmentsTableReferences),
      DoseAdjustment,
      PrefetchHooks Function({bool detergentId})
    >;
typedef $$MeasureMarkersTableCreateCompanionBuilder =
    MeasureMarkersCompanion Function({
      required String id,
      required String detergentId,
      required String label,
      required double amountCanonical,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$MeasureMarkersTableUpdateCompanionBuilder =
    MeasureMarkersCompanion Function({
      Value<String> id,
      Value<String> detergentId,
      Value<String> label,
      Value<double> amountCanonical,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$MeasureMarkersTableReferences
    extends BaseReferences<_$AppDatabase, $MeasureMarkersTable, MeasureMarker> {
  $$MeasureMarkersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DetergentProfilesTable _detergentIdTable(_$AppDatabase db) => db
      .detergentProfiles
      .createAlias('measure_markers__detergent_id__detergent_profiles__id');

  $$DetergentProfilesTableProcessedTableManager get detergentId {
    final $_column = $_itemColumn<String>('detergent_id')!;

    final manager = $$DetergentProfilesTableTableManager(
      $_db,
      $_db.detergentProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_detergentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MeasureMarkersTableFilterComposer
    extends Composer<_$AppDatabase, $MeasureMarkersTable> {
  $$MeasureMarkersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$DetergentProfilesTableFilterComposer get detergentId {
    final $$DetergentProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableFilterComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasureMarkersTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasureMarkersTable> {
  $$MeasureMarkersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$DetergentProfilesTableOrderingComposer get detergentId {
    final $$DetergentProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeasureMarkersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasureMarkersTable> {
  $$MeasureMarkersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$DetergentProfilesTableAnnotationComposer get detergentId {
    final $$DetergentProfilesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.detergentId,
          referencedTable: $db.detergentProfiles,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DetergentProfilesTableAnnotationComposer(
                $db: $db,
                $table: $db.detergentProfiles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MeasureMarkersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeasureMarkersTable,
          MeasureMarker,
          $$MeasureMarkersTableFilterComposer,
          $$MeasureMarkersTableOrderingComposer,
          $$MeasureMarkersTableAnnotationComposer,
          $$MeasureMarkersTableCreateCompanionBuilder,
          $$MeasureMarkersTableUpdateCompanionBuilder,
          (MeasureMarker, $$MeasureMarkersTableReferences),
          MeasureMarker,
          PrefetchHooks Function({bool detergentId})
        > {
  $$MeasureMarkersTableTableManager(
    _$AppDatabase db,
    $MeasureMarkersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasureMarkersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasureMarkersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasureMarkersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> detergentId = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<double> amountCanonical = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeasureMarkersCompanion(
                id: id,
                detergentId: detergentId,
                label: label,
                amountCanonical: amountCanonical,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String detergentId,
                required String label,
                required double amountCanonical,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeasureMarkersCompanion.insert(
                id: id,
                detergentId: detergentId,
                label: label,
                amountCanonical: amountCanonical,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MeasureMarkersTable, MeasureMarker>(table),
                  $$MeasureMarkersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({detergentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (detergentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.detergentId,
                                referencedTable: $$MeasureMarkersTableReferences
                                    ._detergentIdTable(db),
                                referencedColumn:
                                    $$MeasureMarkersTableReferences
                                        ._detergentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MeasureMarkersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeasureMarkersTable,
      MeasureMarker,
      $$MeasureMarkersTableFilterComposer,
      $$MeasureMarkersTableOrderingComposer,
      $$MeasureMarkersTableAnnotationComposer,
      $$MeasureMarkersTableCreateCompanionBuilder,
      $$MeasureMarkersTableUpdateCompanionBuilder,
      (MeasureMarker, $$MeasureMarkersTableReferences),
      MeasureMarker,
      PrefetchHooks Function({bool detergentId})
    >;
typedef $$WashLogsTableCreateCompanionBuilder =
    WashLogsCompanion Function({
      required String id,
      Value<String?> detergentId,
      required String detergentNameSnapshot,
      required String detergentTypeSnapshot,
      required double amountCanonical,
      required String canonicalUnit,
      required String displayAmountSnapshot,
      required String displayUnitSnapshot,
      Value<String?> loadLevel,
      Value<String?> soilLevel,
      Value<String?> waterLevel,
      Value<int?> costMinorUnits,
      Value<String?> currencyCode,
      required DateTime loggedAtUtc,
      Value<int> rowid,
    });
typedef $$WashLogsTableUpdateCompanionBuilder =
    WashLogsCompanion Function({
      Value<String> id,
      Value<String?> detergentId,
      Value<String> detergentNameSnapshot,
      Value<String> detergentTypeSnapshot,
      Value<double> amountCanonical,
      Value<String> canonicalUnit,
      Value<String> displayAmountSnapshot,
      Value<String> displayUnitSnapshot,
      Value<String?> loadLevel,
      Value<String?> soilLevel,
      Value<String?> waterLevel,
      Value<int?> costMinorUnits,
      Value<String?> currencyCode,
      Value<DateTime> loggedAtUtc,
      Value<int> rowid,
    });

final class $$WashLogsTableReferences
    extends BaseReferences<_$AppDatabase, $WashLogsTable, WashLog> {
  $$WashLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DetergentProfilesTable _detergentIdTable(_$AppDatabase db) => db
      .detergentProfiles
      .createAlias('wash_logs__detergent_id__detergent_profiles__id');

  $$DetergentProfilesTableProcessedTableManager? get detergentId {
    final $_column = $_itemColumn<String>('detergent_id');
    if ($_column == null) return null;
    final manager = $$DetergentProfilesTableTableManager(
      $_db,
      $_db.detergentProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_detergentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WashLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WashLogsTable> {
  $$WashLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detergentNameSnapshot => $composableBuilder(
    column: $table.detergentNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detergentTypeSnapshot => $composableBuilder(
    column: $table.detergentTypeSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalUnit => $composableBuilder(
    column: $table.canonicalUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayAmountSnapshot => $composableBuilder(
    column: $table.displayAmountSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayUnitSnapshot => $composableBuilder(
    column: $table.displayUnitSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loadLevel => $composableBuilder(
    column: $table.loadLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soilLevel => $composableBuilder(
    column: $table.soilLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get waterLevel => $composableBuilder(
    column: $table.waterLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costMinorUnits => $composableBuilder(
    column: $table.costMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAtUtc => $composableBuilder(
    column: $table.loggedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  $$DetergentProfilesTableFilterComposer get detergentId {
    final $$DetergentProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableFilterComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WashLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WashLogsTable> {
  $$WashLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detergentNameSnapshot => $composableBuilder(
    column: $table.detergentNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detergentTypeSnapshot => $composableBuilder(
    column: $table.detergentTypeSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalUnit => $composableBuilder(
    column: $table.canonicalUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayAmountSnapshot => $composableBuilder(
    column: $table.displayAmountSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayUnitSnapshot => $composableBuilder(
    column: $table.displayUnitSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loadLevel => $composableBuilder(
    column: $table.loadLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soilLevel => $composableBuilder(
    column: $table.soilLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get waterLevel => $composableBuilder(
    column: $table.waterLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costMinorUnits => $composableBuilder(
    column: $table.costMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAtUtc => $composableBuilder(
    column: $table.loggedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  $$DetergentProfilesTableOrderingComposer get detergentId {
    final $$DetergentProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.detergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WashLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WashLogsTable> {
  $$WashLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get detergentNameSnapshot => $composableBuilder(
    column: $table.detergentNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get detergentTypeSnapshot => $composableBuilder(
    column: $table.detergentTypeSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountCanonical => $composableBuilder(
    column: $table.amountCanonical,
    builder: (column) => column,
  );

  GeneratedColumn<String> get canonicalUnit => $composableBuilder(
    column: $table.canonicalUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayAmountSnapshot => $composableBuilder(
    column: $table.displayAmountSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayUnitSnapshot => $composableBuilder(
    column: $table.displayUnitSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get loadLevel =>
      $composableBuilder(column: $table.loadLevel, builder: (column) => column);

  GeneratedColumn<String> get soilLevel =>
      $composableBuilder(column: $table.soilLevel, builder: (column) => column);

  GeneratedColumn<String> get waterLevel => $composableBuilder(
    column: $table.waterLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costMinorUnits => $composableBuilder(
    column: $table.costMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get loggedAtUtc => $composableBuilder(
    column: $table.loggedAtUtc,
    builder: (column) => column,
  );

  $$DetergentProfilesTableAnnotationComposer get detergentId {
    final $$DetergentProfilesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.detergentId,
          referencedTable: $db.detergentProfiles,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DetergentProfilesTableAnnotationComposer(
                $db: $db,
                $table: $db.detergentProfiles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$WashLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WashLogsTable,
          WashLog,
          $$WashLogsTableFilterComposer,
          $$WashLogsTableOrderingComposer,
          $$WashLogsTableAnnotationComposer,
          $$WashLogsTableCreateCompanionBuilder,
          $$WashLogsTableUpdateCompanionBuilder,
          (WashLog, $$WashLogsTableReferences),
          WashLog,
          PrefetchHooks Function({bool detergentId})
        > {
  $$WashLogsTableTableManager(_$AppDatabase db, $WashLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WashLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WashLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WashLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> detergentId = const Value.absent(),
                Value<String> detergentNameSnapshot = const Value.absent(),
                Value<String> detergentTypeSnapshot = const Value.absent(),
                Value<double> amountCanonical = const Value.absent(),
                Value<String> canonicalUnit = const Value.absent(),
                Value<String> displayAmountSnapshot = const Value.absent(),
                Value<String> displayUnitSnapshot = const Value.absent(),
                Value<String?> loadLevel = const Value.absent(),
                Value<String?> soilLevel = const Value.absent(),
                Value<String?> waterLevel = const Value.absent(),
                Value<int?> costMinorUnits = const Value.absent(),
                Value<String?> currencyCode = const Value.absent(),
                Value<DateTime> loggedAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WashLogsCompanion(
                id: id,
                detergentId: detergentId,
                detergentNameSnapshot: detergentNameSnapshot,
                detergentTypeSnapshot: detergentTypeSnapshot,
                amountCanonical: amountCanonical,
                canonicalUnit: canonicalUnit,
                displayAmountSnapshot: displayAmountSnapshot,
                displayUnitSnapshot: displayUnitSnapshot,
                loadLevel: loadLevel,
                soilLevel: soilLevel,
                waterLevel: waterLevel,
                costMinorUnits: costMinorUnits,
                currencyCode: currencyCode,
                loggedAtUtc: loggedAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> detergentId = const Value.absent(),
                required String detergentNameSnapshot,
                required String detergentTypeSnapshot,
                required double amountCanonical,
                required String canonicalUnit,
                required String displayAmountSnapshot,
                required String displayUnitSnapshot,
                Value<String?> loadLevel = const Value.absent(),
                Value<String?> soilLevel = const Value.absent(),
                Value<String?> waterLevel = const Value.absent(),
                Value<int?> costMinorUnits = const Value.absent(),
                Value<String?> currencyCode = const Value.absent(),
                required DateTime loggedAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => WashLogsCompanion.insert(
                id: id,
                detergentId: detergentId,
                detergentNameSnapshot: detergentNameSnapshot,
                detergentTypeSnapshot: detergentTypeSnapshot,
                amountCanonical: amountCanonical,
                canonicalUnit: canonicalUnit,
                displayAmountSnapshot: displayAmountSnapshot,
                displayUnitSnapshot: displayUnitSnapshot,
                loadLevel: loadLevel,
                soilLevel: soilLevel,
                waterLevel: waterLevel,
                costMinorUnits: costMinorUnits,
                currencyCode: currencyCode,
                loggedAtUtc: loggedAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WashLogsTable, WashLog>(table),
                  $$WashLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({detergentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (detergentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.detergentId,
                                referencedTable: $$WashLogsTableReferences
                                    ._detergentIdTable(db),
                                referencedColumn: $$WashLogsTableReferences
                                    ._detergentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WashLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WashLogsTable,
      WashLog,
      $$WashLogsTableFilterComposer,
      $$WashLogsTableOrderingComposer,
      $$WashLogsTableAnnotationComposer,
      $$WashLogsTableCreateCompanionBuilder,
      $$WashLogsTableUpdateCompanionBuilder,
      (WashLog, $$WashLogsTableReferences),
      WashLog,
      PrefetchHooks Function({bool detergentId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingCompleted,
      Value<String> themeMode,
      Value<String?> localeOverride,
      Value<String> unitSystem,
      Value<String> defaultLoadLevel,
      Value<String> defaultSoilLevel,
      Value<String> defaultWaterLevel,
      Value<String?> selectedDetergentId,
      Value<String> reducedMotionOverride,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingCompleted,
      Value<String> themeMode,
      Value<String?> localeOverride,
      Value<String> unitSystem,
      Value<String> defaultLoadLevel,
      Value<String> defaultSoilLevel,
      Value<String> defaultWaterLevel,
      Value<String?> selectedDetergentId,
      Value<String> reducedMotionOverride,
    });

final class $$AppSettingsTableReferences
    extends BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting> {
  $$AppSettingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DetergentProfilesTable _selectedDetergentIdTable(_$AppDatabase db) =>
      db.detergentProfiles.createAlias(
        'app_settings__selected_detergent_id__detergent_profiles__id',
      );

  $$DetergentProfilesTableProcessedTableManager? get selectedDetergentId {
    final $_column = $_itemColumn<String>('selected_detergent_id');
    if ($_column == null) return null;
    final manager = $$DetergentProfilesTableTableManager(
      $_db,
      $_db.detergentProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_selectedDetergentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultLoadLevel => $composableBuilder(
    column: $table.defaultLoadLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultSoilLevel => $composableBuilder(
    column: $table.defaultSoilLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultWaterLevel => $composableBuilder(
    column: $table.defaultWaterLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reducedMotionOverride => $composableBuilder(
    column: $table.reducedMotionOverride,
    builder: (column) => ColumnFilters(column),
  );

  $$DetergentProfilesTableFilterComposer get selectedDetergentId {
    final $$DetergentProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.selectedDetergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableFilterComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultLoadLevel => $composableBuilder(
    column: $table.defaultLoadLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultSoilLevel => $composableBuilder(
    column: $table.defaultSoilLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultWaterLevel => $composableBuilder(
    column: $table.defaultWaterLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reducedMotionOverride => $composableBuilder(
    column: $table.reducedMotionOverride,
    builder: (column) => ColumnOrderings(column),
  );

  $$DetergentProfilesTableOrderingComposer get selectedDetergentId {
    final $$DetergentProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.selectedDetergentId,
      referencedTable: $db.detergentProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetergentProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.detergentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get localeOverride => $composableBuilder(
    column: $table.localeOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultLoadLevel => $composableBuilder(
    column: $table.defaultLoadLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultSoilLevel => $composableBuilder(
    column: $table.defaultSoilLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultWaterLevel => $composableBuilder(
    column: $table.defaultWaterLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reducedMotionOverride => $composableBuilder(
    column: $table.reducedMotionOverride,
    builder: (column) => column,
  );

  $$DetergentProfilesTableAnnotationComposer get selectedDetergentId {
    final $$DetergentProfilesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.selectedDetergentId,
          referencedTable: $db.detergentProfiles,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DetergentProfilesTableAnnotationComposer(
                $db: $db,
                $table: $db.detergentProfiles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (AppSetting, $$AppSettingsTableReferences),
          AppSetting,
          PrefetchHooks Function({bool selectedDetergentId})
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String?> localeOverride = const Value.absent(),
                Value<String> unitSystem = const Value.absent(),
                Value<String> defaultLoadLevel = const Value.absent(),
                Value<String> defaultSoilLevel = const Value.absent(),
                Value<String> defaultWaterLevel = const Value.absent(),
                Value<String?> selectedDetergentId = const Value.absent(),
                Value<String> reducedMotionOverride = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                onboardingCompleted: onboardingCompleted,
                themeMode: themeMode,
                localeOverride: localeOverride,
                unitSystem: unitSystem,
                defaultLoadLevel: defaultLoadLevel,
                defaultSoilLevel: defaultSoilLevel,
                defaultWaterLevel: defaultWaterLevel,
                selectedDetergentId: selectedDetergentId,
                reducedMotionOverride: reducedMotionOverride,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String?> localeOverride = const Value.absent(),
                Value<String> unitSystem = const Value.absent(),
                Value<String> defaultLoadLevel = const Value.absent(),
                Value<String> defaultSoilLevel = const Value.absent(),
                Value<String> defaultWaterLevel = const Value.absent(),
                Value<String?> selectedDetergentId = const Value.absent(),
                Value<String> reducedMotionOverride = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                onboardingCompleted: onboardingCompleted,
                themeMode: themeMode,
                localeOverride: localeOverride,
                unitSystem: unitSystem,
                defaultLoadLevel: defaultLoadLevel,
                defaultSoilLevel: defaultSoilLevel,
                defaultWaterLevel: defaultWaterLevel,
                selectedDetergentId: selectedDetergentId,
                reducedMotionOverride: reducedMotionOverride,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  $$AppSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({selectedDetergentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (selectedDetergentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.selectedDetergentId,
                                referencedTable: $$AppSettingsTableReferences
                                    ._selectedDetergentIdTable(db),
                                referencedColumn: $$AppSettingsTableReferences
                                    ._selectedDetergentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (AppSetting, $$AppSettingsTableReferences),
      AppSetting,
      PrefetchHooks Function({bool selectedDetergentId})
    >;
typedef $$AdStatesTableCreateCompanionBuilder =
    AdStatesCompanion Function({
      Value<int> id,
      Value<int> lifetimeSuccessfulLogs,
      Value<DateTime?> lastInterstitialAtUtc,
      Value<int> adsShownToday,
      Value<String?> adsShownDateLocal,
      Value<bool> firstSessionCompleted,
      Value<String?> lastEligibilityConsumedLogId,
    });
typedef $$AdStatesTableUpdateCompanionBuilder =
    AdStatesCompanion Function({
      Value<int> id,
      Value<int> lifetimeSuccessfulLogs,
      Value<DateTime?> lastInterstitialAtUtc,
      Value<int> adsShownToday,
      Value<String?> adsShownDateLocal,
      Value<bool> firstSessionCompleted,
      Value<String?> lastEligibilityConsumedLogId,
    });

class $$AdStatesTableFilterComposer
    extends Composer<_$AppDatabase, $AdStatesTable> {
  $$AdStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lifetimeSuccessfulLogs => $composableBuilder(
    column: $table.lifetimeSuccessfulLogs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastInterstitialAtUtc => $composableBuilder(
    column: $table.lastInterstitialAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get adsShownToday => $composableBuilder(
    column: $table.adsShownToday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adsShownDateLocal => $composableBuilder(
    column: $table.adsShownDateLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get firstSessionCompleted => $composableBuilder(
    column: $table.firstSessionCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastEligibilityConsumedLogId => $composableBuilder(
    column: $table.lastEligibilityConsumedLogId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AdStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $AdStatesTable> {
  $$AdStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lifetimeSuccessfulLogs => $composableBuilder(
    column: $table.lifetimeSuccessfulLogs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastInterstitialAtUtc => $composableBuilder(
    column: $table.lastInterstitialAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get adsShownToday => $composableBuilder(
    column: $table.adsShownToday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adsShownDateLocal => $composableBuilder(
    column: $table.adsShownDateLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get firstSessionCompleted => $composableBuilder(
    column: $table.firstSessionCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastEligibilityConsumedLogId =>
      $composableBuilder(
        column: $table.lastEligibilityConsumedLogId,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$AdStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdStatesTable> {
  $$AdStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get lifetimeSuccessfulLogs => $composableBuilder(
    column: $table.lifetimeSuccessfulLogs,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastInterstitialAtUtc => $composableBuilder(
    column: $table.lastInterstitialAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get adsShownToday => $composableBuilder(
    column: $table.adsShownToday,
    builder: (column) => column,
  );

  GeneratedColumn<String> get adsShownDateLocal => $composableBuilder(
    column: $table.adsShownDateLocal,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get firstSessionCompleted => $composableBuilder(
    column: $table.firstSessionCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastEligibilityConsumedLogId =>
      $composableBuilder(
        column: $table.lastEligibilityConsumedLogId,
        builder: (column) => column,
      );
}

class $$AdStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AdStatesTable,
          AdState,
          $$AdStatesTableFilterComposer,
          $$AdStatesTableOrderingComposer,
          $$AdStatesTableAnnotationComposer,
          $$AdStatesTableCreateCompanionBuilder,
          $$AdStatesTableUpdateCompanionBuilder,
          (AdState, BaseReferences<_$AppDatabase, $AdStatesTable, AdState>),
          AdState,
          PrefetchHooks Function()
        > {
  $$AdStatesTableTableManager(_$AppDatabase db, $AdStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AdStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AdStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lifetimeSuccessfulLogs = const Value.absent(),
                Value<DateTime?> lastInterstitialAtUtc = const Value.absent(),
                Value<int> adsShownToday = const Value.absent(),
                Value<String?> adsShownDateLocal = const Value.absent(),
                Value<bool> firstSessionCompleted = const Value.absent(),
                Value<String?> lastEligibilityConsumedLogId =
                    const Value.absent(),
              }) => AdStatesCompanion(
                id: id,
                lifetimeSuccessfulLogs: lifetimeSuccessfulLogs,
                lastInterstitialAtUtc: lastInterstitialAtUtc,
                adsShownToday: adsShownToday,
                adsShownDateLocal: adsShownDateLocal,
                firstSessionCompleted: firstSessionCompleted,
                lastEligibilityConsumedLogId: lastEligibilityConsumedLogId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> lifetimeSuccessfulLogs = const Value.absent(),
                Value<DateTime?> lastInterstitialAtUtc = const Value.absent(),
                Value<int> adsShownToday = const Value.absent(),
                Value<String?> adsShownDateLocal = const Value.absent(),
                Value<bool> firstSessionCompleted = const Value.absent(),
                Value<String?> lastEligibilityConsumedLogId =
                    const Value.absent(),
              }) => AdStatesCompanion.insert(
                id: id,
                lifetimeSuccessfulLogs: lifetimeSuccessfulLogs,
                lastInterstitialAtUtc: lastInterstitialAtUtc,
                adsShownToday: adsShownToday,
                adsShownDateLocal: adsShownDateLocal,
                firstSessionCompleted: firstSessionCompleted,
                lastEligibilityConsumedLogId: lastEligibilityConsumedLogId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AdStatesTable, AdState>(table),
                  BaseReferences<_$AppDatabase, $AdStatesTable, AdState>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AdStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AdStatesTable,
      AdState,
      $$AdStatesTableFilterComposer,
      $$AdStatesTableOrderingComposer,
      $$AdStatesTableAnnotationComposer,
      $$AdStatesTableCreateCompanionBuilder,
      $$AdStatesTableUpdateCompanionBuilder,
      (AdState, BaseReferences<_$AppDatabase, $AdStatesTable, AdState>),
      AdState,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DetergentProfilesTableTableManager get detergentProfiles =>
      $$DetergentProfilesTableTableManager(_db, _db.detergentProfiles);
  $$DoseRulesTableTableManager get doseRules =>
      $$DoseRulesTableTableManager(_db, _db.doseRules);
  $$DoseAdjustmentsTableTableManager get doseAdjustments =>
      $$DoseAdjustmentsTableTableManager(_db, _db.doseAdjustments);
  $$MeasureMarkersTableTableManager get measureMarkers =>
      $$MeasureMarkersTableTableManager(_db, _db.measureMarkers);
  $$WashLogsTableTableManager get washLogs =>
      $$WashLogsTableTableManager(_db, _db.washLogs);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$AdStatesTableTableManager get adStates =>
      $$AdStatesTableTableManager(_db, _db.adStates);
}
