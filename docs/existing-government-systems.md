# PRAVAAH-AI — Existing Government Systems and Infrastructure

## 1. Purpose

PRAVAAH-AI should not unnecessarily recreate operational capabilities that are already provided by Government of India agencies.

This document identifies relevant existing government systems, datasets and operational products that may be used as:

- direct data inputs;
- reference/baseline products;
- validation sources;
- geographic and hazard information;
- supporting decision-support information.

The actual accessibility, API availability, licensing, update frequency and technical integration method of each source must be verified before implementation.

---

# 2. India Meteorological Department (IMD)

## 2.1 National Flash Flood Guidance System

### Agency

India Meteorological Department (IMD)

### Official System

National Flash Flood Guidance Bulletin / Flash Flood Guidance System (FFGS)

### Official Portal

https://hydro.imd.gov.in/national/

### Role

The IMD system is the most important existing government benchmark for PRAVAAH-AI.

It already provides operational flash-flood guidance based on observed and forecast meteorological/land-surface information.

### Information currently represented by the system

The National Flash Flood Guidance Bulletin includes:

- merged mean areal precipitation;
- rainfall accumulated over recent periods;
- land-surface model soil saturation;
- numerical weather prediction forecasts;
- observed flash-flood threat;
- persistent flash-flood threat;
- flash-flood risk.

The current national bulletin explicitly reports rainfall over the previous 6 and 24 hours and land-surface model saturation information. Its prognostic section references forecasts from GFS, WRF and NCUM. 

### Existing threat/risk products

The system includes:

- Observed Flash Flood Threat (IFFT)
- Persistent Flash Flood Threat (PFFT)
- Flash Flood Risk (FFR)

IMD's operational material also describes flash-flood guidance at short time scales and risk guidance over longer forecast horizons.

### Relevance to PRAVAAH-AI

PRAVAAH-AI should investigate whether the existing IMD products can be consumed or incorporated directly instead of rebuilding equivalent national-scale rainfall and flash-flood guidance functionality.

The IMD system should be treated as:

1. an operational benchmark;
2. a potential input;
3. a reference for forecast timing;
4. a source against which PRAVAAH-AI predictions can be compared.

### Important limitation

PRAVAAH-AI must not claim that it is the first Indian system to combine rainfall, soil moisture and forecast information for flash-flood guidance.

That capability already exists operationally through IMD.

The project's differentiation therefore needs to be established through additional localization, data fusion, modelling and decision-support capabilities.

---

# 3. IMD Meteorological Data

In addition to the Flash Flood Guidance System, IMD provides a wider set of meteorological observations and forecast products.

Potentially relevant information includes:

- rainfall observations;
- AWS/ARG observations;
- district rainfall;
- rainfall forecasts;
- nowcasts;
- quantitative precipitation forecasts;
- other meteorological observations.

The exact APIs, access permissions, update frequency and historical availability must be verified during the data-source implementation phase.

### Potential PRAVAAH-AI use

Meteorological data can be used for:

- real-time feature generation;
- antecedent rainfall calculation;
- forecast rainfall;
- event reconstruction;
- model training;
- validation;
- live risk assessment.

---

# 4. Geological Survey of India (GSI)

## 4.1 National Landslide Forecasting Centre / Bhusanket

### Agency

Geological Survey of India (GSI)

### Official Portal

https://bhusanket.gsi.gov.in/

### Role

GSI provides the country's official landslide-related information infrastructure.

The Bhusanket portal currently includes:

- landslide forecast information;
- landslide inventory;
- landslide susceptibility information;
- landslide reports;
- state-wise landslide information;
- landslide forecasting material.

The portal currently reports a field-validated landslide inventory and provides access to downloadable information.

### Relevance

Historical landslide information can provide static or historical hazard features for PRAVAAH-AI.

Examples include:

- historical landslide density;
- distance to known landslides;
- landslide occurrence by location;
- landslide-prone terrain;
- susceptibility information.

These variables may help characterize terrain vulnerability when combined with rainfall and soil conditions.

### Important distinction

Historical landslide occurrence is not equivalent to historical flash-flood occurrence.

Therefore GSI landslide information should not automatically be treated as the target label for a flash-flood prediction model.

It should instead be evaluated as:

- a susceptibility variable;
- an environmental risk factor;
- a source of historical hazard context;
- a potential component of compound flood/landslide risk.

---

# 5. GSI Landslide Susceptibility Information

GSI maintains landslide susceptibility mapping at different scales.

The Bhusanket portal provides information associated with macro-scale, meso-scale and other landslide susceptibility studies.

The portal also provides a field-validated landslide inventory.

GSI's published material states that baseline landslide susceptibility mapping has been prepared for landslide-prone areas and that inventory and susceptibility information is available through GSI's geospatial infrastructure.

### Potential PRAVAAH-AI use

Possible derived features include:

- landslide susceptibility class;
- historical landslide density;
- distance from known landslides;
- susceptibility of surrounding terrain.

These features can be integrated with rainfall and terrain variables.

---

# 6. ISRO / National Remote Sensing Centre

## 6.1 Bhoonidhi

### Agency

Indian Space Research Organisation (ISRO)

### Relevant organization

National Remote Sensing Centre (NRSC)

### Platform

Bhoonidhi

### Relevance

Bhoonidhi provides access to Earth-observation datasets and analysis-ready products.

This is potentially important for PRAVAAH-AI because satellite-derived information can complement ground observations and meteorological datasets.

---

# 7. ISRO Operational Soil Moisture Product

ISRO has introduced an operational soil-moisture product based on EOS-04 (RISAT-1A) C-band SAR observations.

The published product has approximately 500 m spatial resolution and is available as Analysis Ready Data through Bhoonidhi under the Department of Space open-data policy.

### Potential PRAVAAH-AI use

Soil moisture can be used as an indicator of antecedent wetness and catchment saturation.

Potential model variables include:

- current soil moisture;
- change in soil moisture;
- antecedent soil wetness;
- spatial soil-moisture patterns.

### Important limitation

Satellite-derived soil moisture and an in-situ IoT soil-moisture sensor are not equivalent measurements.

The system must preserve the distinction between:

- satellite observations;
- modelled soil moisture;
- ground sensor measurements.

These sources may eventually be fused but should not be treated as identical without validation.

---

# 8. Survey of India

## 8.1 Digital Elevation / Terrain Data

### Agency

Survey of India (SOI)

### Relevance

Terrain information is necessary for modelling flash-flood susceptibility in hilly regions.

Survey of India's online mapping infrastructure provides Digital Terrain Model information at 10 m resolution generated from 1:50,000 scale topographic data.

### Potential terrain variables

From DEM/DTM data, PRAVAAH-AI can derive:

- elevation;
- slope;
- aspect;
- curvature;
- flow direction;
- flow accumulation;
- drainage-related characteristics;
- watershed boundaries;
- topographic indices.

### Important distinction

The SIH problem refers to "slope stability models."

A DEM does not directly provide slope stability.

Instead, terrain data can be used to calculate slope and other topographic variables, which can then contribute to a terrain/susceptibility model.

Additional geological and landslide information may be required to model true slope stability.

---

# 9. Central Water Commission (CWC)

## 9.1 Hydrological Observation Network

### Agency

Central Water Commission (CWC)

### Relevance

CWC operates a national hydrological observation network.

The current CWC website states that its network contains hundreds of hydrological observation sites on major rivers and tributaries along with meteorological stations.

Non-classified hydrological observation information is disseminated through the Water Resources Information System (WRIS).

### Potential PRAVAAH-AI variables

Where available and suitable:

- river water level;
- discharge;
- hydrological observations;
- river response;
- catchment information.

### Potential role

Hydrological measurements could provide an additional dynamic signal between rainfall and actual water-system response.

This may be particularly valuable where sensor coverage is available near vulnerable catchments.

---

# 10. Water Resources Information System (WRIS)

WRIS is a government water-resources information infrastructure that may provide access to hydrological and water-resources information.

PRAVAAH-AI should investigate:

- available datasets;
- spatial coverage;
- temporal coverage;
- data access mechanisms;
- update frequency;
- data policy.

WRIS should be considered a potential source rather than assumed to provide every required variable at every location.

---

# 11. Relationship Between Existing Systems

The government ecosystem can conceptually be viewed as:

                    IMD
        ┌──────────────────────────┐
        │ Rainfall / Forecasts     │
        │ Flash Flood Guidance     │
        └────────────┬─────────────┘
                     │
          ┌──────────┼──────────┐
          │          │          │
          ▼          ▼          ▼
        ISRO        GSI        CWC
     Soil Moisture Landslide   Hydrology
          │        Inventory       │
          │    Susceptibility      │
          │          │              │
          └──────────┼──────────────┘
                     │
                     ▼
               Survey of India
                  Terrain
                     │
                     ▼
              PRAVAAH-AI
       Multi-source integration
                     │
                     ▼
       Hyper-local decision support

---

# 12. What PRAVAAH-AI Should Reuse

PRAVAAH-AI should investigate direct reuse of:

- IMD rainfall information;
- IMD forecast products;
- IMD flash-flood guidance outputs where accessible;
- ISRO/Bhoonidhi soil-moisture products;
- GSI landslide inventories;
- GSI susceptibility information;
- Survey of India terrain information;
- CWC/WRIS hydrological observations.

The project should prioritize reuse of authoritative government infrastructure over independently recreating equivalent datasets.

---

# 13. What PRAVAAH-AI May Need to Build

Existing systems do not automatically provide one unified hyper-local dataset containing every variable required by the SIH problem.

PRAVAAH-AI may therefore need to build:

- a unified data-ingestion layer;
- spatial and temporal data alignment;
- feature engineering;
- local sensor integration;
- model-ready datasets;
- prediction/calibration models;
- hyper-local risk mapping;
- alert orchestration;
- explainability;
- decision-support interfaces.

These should be treated as integration/enhancement capabilities rather than replacements for national operational systems.

---

# 14. Existing Capability vs PRAVAAH-AI

| Capability | Existing Government Capability | PRAVAAH-AI Opportunity |
|---|---|---|
| Rainfall observation | IMD | Reuse |
| Rainfall forecasting | IMD | Reuse |
| Soil saturation / soil information | IMD / ISRO | Fuse |
| Flash-flood guidance | IMD FFGS | Baseline / integrate |
| Landslide inventory | GSI | Integrate |
| Landslide susceptibility | GSI | Integrate |
| Terrain / DEM | Survey of India | Derive terrain variables |
| River observations | CWC / WRIS | Integrate where available |
| Local IoT observations | Not assumed nationwide | Add local layer |
| Multi-source fusion | Fragmented across systems | Core project function |
| Hyper-local risk assessment | Requires investigation | Core project function |
| Probability calibration | Requires investigation | Potential ML research area |
| Explainable risk factors | Requires investigation | Core project function |
| Village/ward decision support | Requires investigation | Core project function |
| Last-mile alerting | Existing government alert mechanisms exist | Integrate carefully; do not claim replacement |

---

# 15. Key Architectural Principle

PRAVAAH-AI should follow the principle:

> "Reuse authoritative government information wherever possible; add value through integration, localization, analytics and decision support."

The system should therefore be designed as a complementary layer rather than as an independent replacement for IMD, GSI, CWC, ISRO or other government operational systems.

---

# 16. Verification Required Before Implementation

Before coding any production data connector, each source must be verified for:

1. Official ownership.
2. Current operational status.
3. Data accessibility.
4. API or download mechanism.
5. Authentication requirements.
6. Spatial resolution.
7. Temporal resolution.
8. Historical coverage.
9. Update latency.
10. Data quality.
11. Usage/licensing conditions.
12. Reliability and availability.
13. Whether automated access is permitted.

No undocumented or assumed API should be incorporated into the production architecture.

---

# 17. Current Strategic Conclusion

India already possesses substantial flash-flood, meteorological, hydrological, terrain and landslide information infrastructure.

The purpose of PRAVAAH-AI should therefore not be to recreate this infrastructure.

The technical challenge is to determine whether these heterogeneous authoritative datasets can be combined with local observations and advanced modelling to generate a useful hyper-local decision-support product for vulnerable hilly communities.

The next research task is to create a detailed data-source inventory and determine exactly which datasets can actually be acquired and integrated.