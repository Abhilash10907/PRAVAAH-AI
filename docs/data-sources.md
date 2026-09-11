# PRAVAAH-AI — Data Sources Specification

## 1. Purpose

This document defines the data sources that may be used by PRAVAAH-AI for flash-flood risk assessment.

The project will prioritize authoritative Government of India sources and will reuse existing operational infrastructure wherever technically and legally possible.

No data source will be treated as production-ready until its current availability, access mechanism, spatial resolution, temporal resolution, historical coverage, update frequency and usage conditions have been verified.

---

# 2. Data Architecture

PRAVAAH-AI will organize its data into five major categories:

1. Meteorological data
2. Soil and land-surface data
3. Terrain and geospatial data
4. Historical hazard and hydrological data
5. Real-time local sensor data

The conceptual flow is:

Government / Sensor Sources
        ↓
Data Ingestion
        ↓
Validation
        ↓
Spatial Alignment
        ↓
Temporal Alignment
        ↓
Feature Engineering
        ↓
Model / Risk Engine
        ↓
Hyper-local Prediction

---

# 3. Source Priority

The following priority will be used when selecting data:

### Tier 1 — Primary authoritative sources

- India Meteorological Department (IMD)
- Geological Survey of India (GSI)
- Indian Space Research Organisation (ISRO) / NRSC
- Central Water Commission (CWC)
- Survey of India (SOI)

### Tier 2 — Supporting official sources

Other Central Government, State Government or authorized institutional sources may be incorporated when they provide information that is unavailable from Tier 1 sources.

### Tier 3 — Research / auxiliary sources

Academic datasets, international datasets or other openly available datasets may be used for research, benchmarking or gap filling only after their provenance and licensing are documented.

---

# 4. IMD — Rainfall and Weather Data

## Provider

India Meteorological Department (IMD)

## Official API documentation

https://api.imd.gov.in/public/api_reference.html

## Relevant available APIs

IMD's current public API documentation lists APIs including:

- City Weather Forecast
- City Weather Forecast with Latitude and Longitude
- Subdivision Rainfall Forecast
- State/District Rainfall Forecast
- All India Weather Forecast Bulletin
- Current Weather
- District-wise Nowcast
- Station-wise Nowcast
- AWS/ARG Data
- District-wise Warnings
- Subdivision-wise Warnings
- District-wise Rainfall
- State-wise Rainfall
- River Basin Quantitative Precipitation Forecast (QPF)

## Potential PRAVAAH-AI use

- current rainfall observations;
- recent rainfall accumulation;
- district-level rainfall;
- AWS/ARG observations;
- forecast rainfall;
- nowcasts;
- warning information;
- quantitative precipitation forecast;
- feature generation for short-term prediction.

## Important verification requirements

Before production use, verify:

- API authentication;
- request limits;
- response formats;
- update intervals;
- historical-access availability;
- geographic coverage;
- automated-use permissions.

---

# 5. IMD — National Flash Flood Guidance System

## Provider

India Meteorological Department

## Official portal

https://hydro.imd.gov.in/national/

## Existing capabilities

The National Flash Flood Guidance Bulletin currently includes:

### Diagnostic information

- merged mean areal precipitation;
- rainfall over recent periods;
- 6-hour rainfall;
- 24-hour rainfall;
- land-surface model soil saturation;
- area-of-concern information.

### Prognostic information

Forecast rainfall from:

- GFS;
- WRF;
- NCUM.

### Flash-flood products

- Observed Flash Flood Threat (IFFT);
- Persistent Flash Flood Threat;
- Flash Flood Risk (FFR).

The national bulletin explicitly contains an assessment of whether surface runoff/inundation may occur under saturated conditions with expected rainfall.

## PRAVAAH-AI role

The IMD FFGS should initially be treated as:

- the primary existing operational benchmark;
- a potential input;
- a validation/reference product;
- an existing government capability that should not unnecessarily be recreated.

## Key research question

Determine exactly what FFGS information can legally and technically be consumed by an external application and at what spatial/temporal resolution.

---

# 6. IMD Historical Rainfall

## Potential dataset

IMD gridded rainfall products.

## Potential use

Historical rainfall can be synchronized with historical hazard events to create training samples.

Important derived variables may include:

- rainfall in previous 1 hour;
- rainfall in previous 3 hours;
- rainfall in previous 6 hours;
- rainfall in previous 12 hours;
- rainfall in previous 24 hours;
- multi-day antecedent rainfall;
- rainfall intensity;
- cumulative rainfall;
- rate of change of rainfall.

## Critical requirement

The historical dataset must reproduce the information that would realistically have been available at each forecast issue time.

Observations occurring after an event begins must not leak into earlier prediction records.

---

# 7. ISRO / NRSC — Soil Moisture

## Provider

Indian Space Research Organisation / National Remote Sensing Centre

## Platform

Bhoonidhi

https://bhoonidhi.nrsc.gov.in/

## Product

EOS-04 SAR-MRS Soil Moisture

## Official information

ISRO states that the operational EOS-04 soil-moisture product has approximately:

- 500 m spatial resolution;
- 17-day repeatability.

The product is provided through Bhoonidhi as an open data resource.

## Potential use

- surface soil moisture;
- antecedent wetness;
- spatial moisture distribution;
- moisture anomaly;
- catchment wetness characterization.

## Important limitation

A 17-day satellite-derived product cannot by itself provide high-frequency real-time soil moisture for a flash-flood warning system.

Therefore the project should investigate how satellite soil moisture can be combined with:

- IMD land-surface information;
- hydrological model information;
- local IoT soil-moisture sensors;
- other valid observations.

## API / machine access

The current Bhoonidhi platform provides a STAC-based API and collections including EOS-04 soil-moisture products.

The exact programmatic download workflow must be tested before implementation.

---

# 8. Geological Survey of India — Landslide Inventory

## Provider

Geological Survey of India (GSI)

## Platform

Bhusanket

https://bhusanket.gsi.gov.in/

## Current information

The Bhusanket portal provides:

- field-validated landslide inventory;
- state-wise landslide reports;
- landslide susceptibility maps;
- landslide reports;
- landslide forecast information where operationally available.

The portal currently reports a field-validated landslide inventory with more than 36,000 entries.

## Potential PRAVAAH-AI use

Possible features include:

- historical landslide density;
- distance to nearest recorded landslide;
- number of landslides within a defined catchment;
- landslide frequency;
- historical susceptibility;
- proximity to landslide-prone areas.

## Critical distinction

A landslide is not automatically a flash-flood event.

Therefore the GSI landslide inventory should normally be treated as:

- a terrain/hazard feature;
- susceptibility information;
- a compound-hazard indicator;

rather than directly serving as the flash-flood target label.

---

# 9. GSI — Landslide Susceptibility

## Provider

Geological Survey of India

## Potential data

- susceptibility maps;
- state-level susceptibility;
- macro/meso/micro-scale information where available;
- other geological and landslide information.

## Potential features

- susceptibility class;
- susceptibility score where supplied;
- surrounding susceptibility;
- historical landslide density.

## Important limitation

Spatial resolution differs between products and studies.

PRAVAAH-AI must preserve the native resolution and must not represent a coarse susceptibility map as a finer-resolution prediction without appropriate methodology.

---

# 10. Survey of India — Terrain / DEM

## Provider

Survey of India

## Official portal

https://onlinemaps.surveyofindia.gov.in/

## Digital Terrain Model

Survey of India's online mapping portal documents a 10 m Digital Terrain Model generated from 1:50,000-scale topographic contours.

The Survey of India National Hydrology Project also provides higher-resolution terrain datasets for specified project areas.

## Potential variables

From DEM/DTM data PRAVAAH-AI may derive:

- elevation;
- slope;
- aspect;
- curvature;
- flow direction;
- flow accumulation;
- drainage characteristics;
- watershed boundaries;
- topographic wetness indicators;
- relative relief.

## Importance

These variables represent static terrain characteristics that do not change at the same timescale as rainfall or soil moisture.

They can therefore act as static spatial features in the prediction model.

---

# 11. Slope Stability

## Important clarification

The SIH problem statement requires "slope stability models."

A DEM alone does not provide a complete slope-stability model.

PRAVAAH-AI may need to combine:

- slope;
- elevation;
- curvature;
- geology;
- land cover;
- landslide susceptibility;
- historical landslide inventory;
- soil properties;
- hydrological conditions.

A true physically based slope-stability calculation may additionally require geotechnical properties and parameters that are not necessarily available nationwide.

## Initial approach

The initial prototype should use available official terrain and susceptibility information to construct a documented terrain/hazard susceptibility layer rather than claim a full geotechnical slope-stability model.

---

# 12. Central Water Commission — Hydrological Data

## Provider

Central Water Commission (CWC)

## Official information

https://cwc.gov.in/hydro-meteorological-observation

## Current network

CWC currently reports a network of 878 observation sites on major rivers and tributaries and 76 exclusive meteorological stations.

Non-classified hydrological observation data are made available through the Water Resources Information System (WRIS).

## Potential variables

Where accessible and appropriate:

- water level;
- river level;
- discharge;
- hydrological observations;
- meteorological observations;
- river/catchment information.

## Potential PRAVAAH-AI use

Hydrological observations could provide direct information about the catchment response to rainfall.

This may be especially useful close to instrumented rivers and streams.

## Important limitation

CWC stations are not uniformly distributed across every village or watershed.

The system must represent sensor coverage explicitly.

---

# 13. Water Resources Information System (WRIS)

WRIS should be evaluated as a potential source for hydrological and water-resource information.

The actual implementation must verify:

- available datasets;
- geographic coverage;
- time resolution;
- historical coverage;
- access mechanism;
- data policy.

No assumptions should be made that every variable is available through WRIS for every location.

---

# 14. Real-Time IoT Data

## Purpose

IoT data provide local observations that can complement satellite and government datasets.

Potential sensors include:

### Rainfall

- tipping-bucket rain gauge;
- automated rainfall sensor.

### Soil

- soil-moisture probe.

### Hydrology

- stream/river water-level sensor;
- pressure-based water-level sensor;
- ultrasonic water-level sensor.

## Proposed architecture

Sensor
→ communication protocol
→ gateway
→ ingestion API/MQTT broker
→ validation
→ time-series database
→ feature service
→ risk engine.

## Important implementation principle

The project must not claim nationwide IoT coverage.

IoT should initially be treated as an optional local observation layer.

---

# 15. Required Data Characteristics

Every dataset entering the system should be accompanied by metadata:

| Field | Description |
|---|---|
| Source | Organization providing the data |
| Dataset | Exact product/dataset name |
| Variable | Measurement or derived quantity |
| Spatial resolution | Native spatial resolution |
| Temporal resolution | Observation/update interval |
| Historical coverage | Available period |
| Latency | Delay between observation and availability |
| Format | JSON, CSV, GeoTIFF, NetCDF, API, etc. |
| CRS | Coordinate reference system |
| Access | API/download/manual |
| Authentication | Required or not |
| License | Usage conditions |
| Reliability | Expected availability |
| Transformation | Processing required |
| Model role | Input / label / validation / reference |

---

# 16. Spatial Alignment Strategy

Data will originate at different spatial resolutions.

Examples:

- rainfall grids;
- satellite soil-moisture grids;
- DEM pixels;
- watershed polygons;
- district boundaries;
- village boundaries;
- individual IoT sensors.

All data must be transformed into a common spatial reference framework.

The system should preserve the original resolution in metadata and explicitly document any:

- aggregation;
- interpolation;
- resampling;
- downscaling;
- spatial averaging.

A high-resolution map interface must not be interpreted as proof that the underlying data have equivalent native resolution.

---

# 17. Temporal Alignment Strategy

Time-varying datasets will have different update frequencies.

Examples:

- rainfall observations;
- weather forecasts;
- satellite soil moisture;
- river observations;
- IoT sensors.

All records must be timestamped consistently.

The system must distinguish:

- observation time;
- forecast issue time;
- forecast valid time;
- ingestion time.

This is particularly important for avoiding data leakage.

---

# 18. Candidate Feature Groups

The eventual model may contain feature families such as:

## Rainfall

- Rain_1h
- Rain_3h
- Rain_6h
- Rain_12h
- Rain_24h
- Rain_72h
- rainfall intensity
- forecast rainfall

## Soil

- current soil moisture;
- soil saturation;
- antecedent moisture;
- moisture change.

## Terrain

- elevation;
- slope;
- aspect;
- curvature;
- flow accumulation;
- drainage density.

## Landslide

- susceptibility;
- historical landslide density;
- distance to historical landslide;
- recent landslide activity.

## Hydrology

- water level;
- discharge;
- rate of water-level change.

## Local Sensors

- sensor rainfall;
- sensor soil moisture;
- stream level;
- rate-of-change variables.

## Existing Government Guidance

Where technically accessible and appropriate:

- IMD flash-flood guidance/risk;
- relevant government warnings;
- other authoritative hazard products.

---

# 19. Flash-Flood Ground Truth

This is currently the highest-priority unresolved data problem.

The prediction model requires historical examples of:

> environmental conditions available at time T

paired with:

> whether a defined flash-flood event occurred within a specified future window.

The project therefore requires an event catalogue containing at minimum:

- event location;
- event start/end time where available;
- event type;
- source;
- geographic precision;
- confidence/quality;
- affected area;
- evidence of occurrence.

Possible sources must be investigated rather than assumed.

Potential sources include:

- official disaster records;
- government flood/inundation products;
- hydrological observations;
- satellite-observed inundation;
- documented historical events;
- authorized disaster-management records.

The final ground-truth methodology must be documented before model training.

---

# 20. Data Leakage Prevention

Historical training data must be constructed using only information that would have been available at the forecast issue time.

For a prediction issued at T:

Allowed:

- observations up to T;
- forecasts issued at or before T and valid after T;
- static geographic information.

Not allowed:

- observations occurring after T;
- post-event flood extent;
- rainfall measurements received after the prediction time;
- any information generated using knowledge of the future event.

This rule is mandatory for validation.

---

# 21. Data Quality Control

Incoming data should be checked for:

- missing values;
- duplicate timestamps;
- impossible measurements;
- sensor failures;
- spatial inconsistencies;
- timestamp errors;
- anomalous values;
- unit inconsistencies;
- coordinate errors.

Each observation should ideally carry:

- quality status;
- source;
- timestamp;
- processing version.

---

# 22. Initial Dataset Priority

The initial prototype should prioritize datasets that are:

1. authoritative;
2. technically accessible;
3. sufficiently documented;
4. spatially useful for the selected study region;
5. temporally useful for prediction;
6. reproducible.

The first prototype should not attempt to integrate every possible source simultaneously.

---

# 23. Initial Study Area Strategy

PRAVAAH-AI should initially select a limited hilly study area rather than attempting nationwide implementation immediately.

The study area should be selected based on:

- documented flash-flood exposure;
- availability of rainfall data;
- availability of terrain data;
- availability of landslide information;
- availability of hydrological information;
- availability of historical events;
- feasibility of obtaining local sensor data.

The initial system can subsequently be generalized.

---

# 24. Proposed Data Pipeline

The initial architecture is:

                    ┌──────────────┐
                    │ IMD          │
                    │ Rain + NWP   │
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │ ISRO         │
                    │ Soil Moisture│
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │ GSI          │
                    │ Landslides   │
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │ SOI          │
                    │ Terrain/DEM  │
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │ CWC / WRIS   │
                    │ Hydrology    │
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │ IoT Sensors  │
                    └──────┬───────┘
                           │
                           ▼
                 ┌────────────────────┐
                 │ Data Ingestion     │
                 └─────────┬──────────┘
                           ▼
                 ┌────────────────────┐
                 │ Quality Control    │
                 └─────────┬──────────┘
                           ▼
                 ┌────────────────────┐
                 │ Spatial/Temporal   │
                 │ Alignment          │
                 └─────────┬──────────┘
                           ▼
                 ┌────────────────────┐
                 │ Feature Engineering│
                 └─────────┬──────────┘
                           ▼
                 ┌────────────────────┐
                 │ Prediction Engine  │
                 └─────────┬──────────┘
                           ▼
                 ┌────────────────────┐
                 │ Hyper-local Risk   │
                 └────────────────────┘

---

# 25. Immediate Data Research Tasks

Before implementing the prediction model, the team must verify:

1. Exact IMD rainfall products and historical access.
2. Exact IMD FFGS information that can be consumed programmatically.
3. EOS-04 soil-moisture availability through Bhoonidhi.
4. GSI inventory download format and attributes.
5. GSI susceptibility data formats and spatial coverage.
6. Survey of India DEM availability for the selected study region.
7. CWC/WRIS hydrological data accessibility.
8. Historical flash-flood event sources.
9. Village/ward boundary data.
10. IoT sensor deployment requirements.

---

# 26. Current Status

No production dataset has yet been selected as the final model input.

The next phase is data-source verification and acquisition.

The goal is to produce a verified data catalogue before writing data-ingestion code or training an ML model.

---

# 27. Data Acquisition Matrix — Pilot Implementation

This table is the working acquisition register for the Mandakini River Catchment pilot.

A source is not considered implementation-ready until the actual access mechanism has been tested.

| ID | Source | Product / Dataset | Variables | Spatial Resolution | Temporal Resolution | Historical Coverage | Access Status | Intended Role |
|---|---|---|---|---|---|---|---|---|
| D01 | IMD | Rainfall observations | Rainfall, accumulation | To verify | To verify | To verify | Research required | Core dynamic input |
| D02 | IMD | AWS / ARG | Local rainfall and weather observations | Station | Near-real-time / to verify | To verify | Research required | High-value local observation |
| D03 | IMD | Forecast rainfall / QPF | Forecast precipitation | To verify | Forecast intervals | To verify | Research required | Future rainfall input |
| D04 | IMD | District / station nowcast | Short-term precipitation | To verify | Short-term | To verify | Research required | Short-term prediction |
| D05 | IMD | National Flash Flood Guidance | Flash-flood guidance / threat / risk | To verify | To verify | To verify | Research required | Operational baseline |
| D06 | ISRO / NRSC | EOS-04 soil moisture | Soil moisture | ~500 m | ~17-day repeat | To verify | Investigation required | Antecedent wetness |
| D07 | GSI | Landslide inventory | Landslide location/date/attributes | To verify | Event based | To verify | Investigation required | Historical hazard |
| D08 | GSI | Landslide susceptibility | Susceptibility | Product dependent | Static | To verify | Investigation required | Terrain/hazard prior |
| D09 | Survey of India | DEM / DTM | Elevation | Product dependent | Static | Static | Investigation required | Terrain derivation |
| D10 | CWC | Hydrological observations | Water level/discharge | Station | To verify | To verify | Investigation required | Catchment response |
| D11 | WRIS | Hydrological/water resources data | Product dependent | Product dependent | Product dependent | To verify | Investigation required | Supporting hydrology |
| D12 | NRSC / Bhuvan | Historical flood/inundation products | Flood extent / inundation | Product dependent | Event based | Historical events | Investigation required | Event labels / validation |
| D13 | Village boundary source | Administrative boundaries | Village/ward polygons | To verify | Static | Current/historical | Investigation required | Hyper-local output |
| D14 | Road / infrastructure data | Roads, bridges, settlements | Geographic features | Product dependent | Static / updated | To verify | Investigation required | Evacuation routing |
| D15 | IoT | Rain gauge | Local rainfall | Sensor | Minutes | New deployment | Future | Local real-time input |
| D16 | IoT | Soil moisture sensor | Soil moisture | Point | Minutes | New deployment | Future | Local real-time input |
| D17 | IoT | Water-level sensor | Stream/river level | Point | Minutes | New deployment | Future | Local hydrological input |
| D18 | IMD / Government | Official alerts/warnings | Hazard warnings | Geographic area | Near-real-time | To verify | Research required | Alert/reference layer |
| D19 | NDMA SACHET | CAP/alert ecosystem | Authorized disaster alerts | Geo-targeted | Near-real-time | To verify | Integration requires authorization | Alert delivery reference |
| D20 | Official shelter / local authority | Designated safe locations | Shelter coordinates/capacity | Point/polygon | Static/updated | To verify | Requires local data | Evacuation destination |

---

# 28. Data Status Definitions

The following status values will be used:

### CONFIRMED

The dataset and access mechanism have been verified from the authoritative source.

### ACCESSIBLE

The dataset appears available through an official interface, but automated acquisition still requires implementation/testing.

### INVESTIGATION REQUIRED

The source is confirmed to exist, but the exact product/access mechanism/resolution for the pilot has not yet been verified.

### FUTURE

The dataset depends on future deployment or external coordination, such as local IoT sensors.

### RESTRICTED / AUTHORIZATION REQUIRED

The source or integration mechanism may require institutional authorization.

### REJECTED

The source will not be used because it is unreliable, unsuitable, inaccessible, legally unusable, or redundant.

---

# 29. Data Selection Principles

A dataset will be prioritized when it provides:

1. authoritative provenance;
2. sufficient spatial relevance;
3. sufficient temporal resolution;
4. historical continuity;
5. reliable metadata;
6. reproducible access;
7. appropriate usage rights;
8. measurable value for prediction or validation.

A technically available dataset will not automatically be included in the final model.

---

# 30. Core vs Optional Inputs

## Core candidate inputs

The initial model should investigate:

- rainfall observations;
- forecast rainfall;
- antecedent rainfall;
- soil moisture/saturation;
- terrain;
- landslide susceptibility;
- historical hazard;
- hydrological observations where available;
- existing government flash-flood guidance.

## Optional enhancement inputs

- local IoT rainfall;
- IoT soil moisture;
- IoT water level;
- additional remote-sensing products;
- local infrastructure information.

The model should remain operational if optional sensor sources are temporarily unavailable.

---

# 31. Data Fusion Requirement

The system must support heterogeneous data sources with different:

- spatial resolutions;
- temporal resolutions;
- measurement units;
- coordinate systems;
- update frequencies;
- data quality.

The data ingestion layer should therefore normalize:

- timestamps;
- spatial reference systems;
- units;
- variable names;
- quality flags;
- missing-value representations.

---

# 32. Data Lineage

Every production feature should be traceable to its source.

A feature record should be capable of being associated with:

- source dataset;
- source timestamp;
- ingestion timestamp;
- processing version;
- transformation;
- spatial aggregation/resampling;
- quality status.

This is required for reproducibility and investigation of incorrect predictions.

---

# 33. Forecast-Time Data Rule

For every prediction generated at time T:

### Allowed

- observations available by T;
- official forecasts issued by T;
- static geographical information;
- historical information available before T.

### Prohibited

- future observations;
- post-event flood maps;
- measurements recorded after T;
- data generated from the event outcome;
- any information that would not have been available to the operational system at T.

This rule must be enforced during dataset construction and validation.

---

# 34. Preliminary Data-Fusion Timeline

An eventual prediction cycle may resemble:

T-24 h
     ↓
Antecedent rainfall / soil wetness
     ↓
T-6 h
     ↓
Recent rainfall + hydrology
     ↓
T-3 h
     ↓
Latest observations + forecast rainfall
     ↓
T
     ↓
PRAVAAH-AI prediction
     ↓
T+1 h / T+3 h / T+6 h
     ↓
Flash-flood risk outcome

The exact time windows will be finalized after data availability and model analysis.

---

# 35. Output Data Model

The eventual prediction service should generate records conceptually similar to:

{
    location_id: "...",
    issue_time: "...",
    forecast_start: "...",
    forecast_end: "...",
    risk_probability: 0.00,
    risk_category: "...",
    confidence: "...",
    major_contributing_factors: [],
    source_summary: [],
    model_version: "...",
    data_quality: "...",
    recommended_action: "..."
}

This is a conceptual schema only and must not be treated as the final API contract.

---

# 36. Alert Architecture Requirement

PRAVAAH-AI should distinguish between:

### Risk prediction

Generated by the analytical/modeling system.

### Advisory

Generated by the application based on defined thresholds and policy.

### Official warning

Issued by an authorized disaster-management authority.

PRAVAAH-AI must not represent an internally generated model result as an official government warning.

---

# 37. Village Alerting Concept

The intended long-term operational concept is:

PRAVAAH-AI detects elevated risk
        ↓
Determine affected villages
        ↓
Determine forecast lead time
        ↓
Generate localized risk/advisory
        ↓
Notify authorized village/local authority
        ↓
Local authority activates appropriate warning mechanism
        ↓
Public receives warning through authorized channels
        ↓
Evacuation / preparedness actions

Possible dissemination mechanisms include:

- authorized government alert systems;
- SMS;
- mobile application;
- local control room;
- village siren/public-address systems;
- other approved communication channels.

Any integration with national government alerting infrastructure requires appropriate authorization.

---

# 38. Evacuation-Support Data Requirements

The eventual evacuation module may require:

- verified shelters;
- safe assembly areas;
- elevation;
- predicted/observed flood extent;
- roads;
- bridges;
- terrain;
- landslide susceptibility;
- road closures;
- travel time;
- accessibility constraints.

The system should prioritize officially designated shelters or validated safe locations.

The highest geographic point must not automatically be considered a safe evacuation location.

---

# 39. Immediate Research Priority

The first data-acquisition investigation should focus on:

### Priority 1

IMD rainfall and forecast data.

### Priority 2

Historical flash-flood/flood event evidence.

### Priority 3

GSI landslide inventory and susceptibility.

### Priority 4

Terrain/DEM for the Mandakini pilot.

### Priority 5

CWC/WRIS hydrological observations.

### Priority 6

ISRO/Bhoonidhi soil moisture.

### Priority 7

Village boundaries and evacuation-support geography.

### Priority 8

IoT architecture.

---

# 40. Current Decision

The project will not yet select a final machine-learning algorithm.

The next technical objective is to acquire and inspect real sample datasets for the pilot region.

The first data engineering milestone is:

> **Successfully obtain and inspect at least one real dataset from the primary meteorological source and one historical hazard/event dataset for the Mandakini pilot.**

Only after this milestone should the data schema and ML dataset structure be finalized.