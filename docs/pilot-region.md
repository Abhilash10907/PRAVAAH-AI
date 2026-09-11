# PRAVAAH-AI — Pilot Region Specification

## 1. Purpose

PRAVAAH-AI will initially be developed and evaluated over a limited hilly-region pilot area.

A restricted pilot region is necessary to establish a reproducible end-to-end data pipeline, construct historical training/validation datasets, evaluate spatial resolution, and test the prediction system before considering expansion to additional regions.

---

## 2. Initial Pilot Region

Region:
Mandakini River Catchment, Uttarakhand, India

Primary Hydrological Reference:
Rudraprayag

Status:
Proposed pilot region — final computational boundary pending verification of
available datasets, historical event coverage, and spatial/temporal resolution.

# 3. Reason for Selection

The Mandakini catchment is a suitable first study area because multiple relevant government information sources already contain information for Uttarakhand and the Mandakini/Alaknanda system.

Relevant evidence includes:

- IMD flash-flood guidance explicitly covers Uttarakhand.
- NRSC/ISRO provides a hydrological modelling study of the Mandakini and Alaknanda systems.
- CWC has hydrological observation infrastructure associated with Rudraprayag and the Mandakini/Alaknanda system.
- NRSC has published satellite-derived flood information for historical Uttarakhand flood events.
- GSI provides Uttarakhand landslide susceptibility and landslide inventory information.
- Survey of India provides terrain/DEM infrastructure relevant to hydrological and terrain analysis.

---

# 4. Initial System Objective for the Pilot

The pilot system will investigate whether heterogeneous government and local observations can be combined to estimate short-term flash-flood risk for spatial units within the Mandakini catchment.

The prediction target must be defined before model training.

A future prediction record may take the form:

P(flash flood event occurs within a specified future time window | information available at forecast time T)

The forecast horizon may include multiple windows such as:

- 0–1 hour;
- 1–3 hours;
- 3–6 hours;
- longer horizons where data quality justifies their use.

The final horizons will be determined during the modelling and validation phase.

---

# 5. Data Sources to Investigate for the Pilot

## Meteorology

### IMD

Potential inputs:

- observed rainfall;
- rainfall accumulation;
- AWS/ARG observations;
- rainfall forecasts;
- nowcasts;
- quantitative precipitation forecasts;
- relevant Flash Flood Guidance products.

---

## Soil Moisture

### ISRO / NRSC / Bhoonidhi

Potential inputs:

- satellite-derived soil moisture;
- temporal soil-moisture variation;
- spatial soil-moisture condition.

These observations will be evaluated alongside other soil/land-surface information because satellite soil moisture does not have the temporal resolution of a continuous ground sensor.

---

## Terrain

### Survey of India

Potential inputs:

- digital elevation;
- slope;
- aspect;
- curvature;
- flow direction;
- flow accumulation;
- drainage characteristics;
- watershed boundaries where available.

---

## Landslide Information

### Geological Survey of India

Potential inputs:

- historical landslide inventory;
- Uttarakhand landslide susceptibility;
- landslide density;
- distance from historical landslides;
- other relevant geological information.

Landslide information will not automatically be treated as flash-flood ground truth.

---

## Hydrology

### Central Water Commission / WRIS

Potential inputs:

- river/stream water level;
- discharge;
- hydrological observations;
- catchment-related variables.

The coverage and temporal resolution available for the selected area must be verified before use.

---

## Historical Flood Information

### NRSC / ISRO / Bhuvan

Potential sources include:

- satellite-derived flood inundation;
- historical event maps;
- flood-affected-area atlases;
- event-specific Uttarakhand information;
- available flash-flood mapping products.

These products will be evaluated as possible sources for constructing historical event labels and independent validation datasets.

---

# 6. Pilot Spatial Unit

The final prediction unit must be determined after evaluating available data.

Candidates include:

1. watershed/sub-watershed;
2. hydrological unit;
3. grid cell;
4. village;
5. ward.

The project must distinguish between the native resolution of the source data and the resolution of the final prediction.

A village-level map does not automatically mean that the prediction itself has village-level observational accuracy.

---

# 7. Initial Historical Events for Investigation

Historical events to investigate include, but are not limited to:

- Uttarakhand flood and flash-flood events documented by NRSC;
- June 2013 Uttarakhand flash-flood/debris-flow disaster;
- August 2022 Maldevta flash-flood event;
- other events with usable rainfall, terrain, hydrological or inundation evidence.

The final event catalogue will be created only after verifying exact dates, spatial extent, event type and available observations.

---

# 8. Primary Ground-Truth Requirement

The most important unresolved question is the construction of reliable flash-flood event labels.

For each historical event, the team should attempt to establish:

- event start time;
- event end time;
- affected geographic area;
- evidence of flooding;
- source of evidence;
- spatial accuracy;
- temporal accuracy;
- event severity where available.

The event catalogue must distinguish flash flooding from:

- ordinary river flooding;
- waterlogging;
- dam releases;
- embankment failures;
- landslides without significant flooding.

---

# 9. Forecast Reconstruction Requirement

The historical training dataset must reproduce a realistic forecasting scenario.

For a forecast issued at time T, only information available by T may be used.

Allowed:

- observations available by T;
- forecasts issued by T;
- static terrain data;
- historical information known before T.

Not allowed:

- post-event observations;
- flood maps produced after the event;
- future rainfall observations;
- information derived from knowledge of the event outcome.

This is mandatory to prevent data leakage.

---

# 10. Pilot Architecture Objective

The pilot should eventually demonstrate:

Data acquisition
→ quality control
→ spatial/temporal alignment
→ feature generation
→ flash-flood prediction
→ probability calibration
→ geographic risk visualization
→ explanation of contributing factors
→ alert/decision-support output.

---

# 11. Relationship With Existing Government Systems

PRAVAAH-AI will not attempt to replace IMD's National Flash Flood Guidance System.

Instead, the pilot will investigate whether additional information such as:

- terrain;
- landslide susceptibility;
- historical hazard;
- local hydrology;
- local IoT observations;

can provide additional localization or decision-support value.

The existing government products will be used as important baselines or inputs where technically and legally feasible.

---

# 12. Pilot Success Criteria

The pilot region will be considered technically successful only if the team can demonstrate:

1. Reproducible acquisition of the selected datasets.
2. Correct spatial and temporal alignment.
3. A defensible historical event catalogue.
4. Leakage-free training and validation datasets.
5. A predictive model evaluated on historical events.
6. Proper probability calibration if probabilistic outputs are reported.
7. Measured lead time.
8. False-alarm and missed-event analysis.
9. Hyper-local visualization supported by the actual data resolution.
10. An end-to-end demonstration using live or realistically simulated data.

---

# 13. Expansion Strategy

The system should be designed so that the Mandakini pilot is not hard-coded into the architecture.

After successful validation, the same architecture should be capable of being configured for additional regions such as:

- other Uttarakhand catchments;
- Himachal Pradesh;
- Sikkim;
- Northeast India;
- Western Ghats;
- other disaster-prone hilly regions.

Expansion will occur only after validating whether the required datasets and event labels exist for the new region.

---

# 14. Current Status

**Pilot region proposed:** Mandakini River Catchment, Uttarakhand.

**Primary hydrological reference:** Rudraprayag.

**Pilot status:** Proposed — final computational boundary pending data verification.

The next phase is to verify the actual availability, format, temporal resolution, spatial resolution and automated-access method of each required dataset for this region.

---

# 15. Operational Pilot Boundary Definition

## Hydrological Definition

The pilot domain is defined as the **Mandakini River catchment upstream of Rudraprayag, before the Mandakini joins the Alaknanda River**.

This definition is preferred over using the administrative boundary of Rudraprayag district because the prediction problem is fundamentally hydrological.

## Reference Outlet

Primary outlet:

**Rudraprayag, Uttarakhand**

The CWC hydrological observation station Rudraprayag (M) is associated with the Ganga/Alaknanda/Mandakini system.

Approximate station coordinates:

Latitude: 30°17'23" N
Longitude: 78°58'49" E

Decimal approximation:

Latitude: 30.2897° N
Longitude: 78.9803° E

## Reference Catchment Area

NRSC's "Hydrological Modelling Study of Mandakini and Alaknanda (Upstream)" describes the Mandakini River catchment up to Rudraprayag, before joining the Alaknanda, as approximately 1,614 km².

CWC hydrological-station metadata reports approximately 1,644 km² for the Rudraprayag (M) observation station.

The difference between published catchment-area values will not be resolved by selecting an arbitrary number.

The final computational boundary will be obtained from an authoritative hydrological GIS boundary/delineation and stored as the project's spatial boundary dataset.

## Boundary Acquisition Method

The project will investigate the official Bhuvan/NRSC hydrological boundary and catchment-delineation functionality.

Preferred workflow:

Rudraprayag outlet
→ official hydrological/catchment delineation
→ downloaded GIS polygon
→ validation
→ stored project boundary.

## Boundary Validation

The final boundary should be checked against:

- official hydrological boundary information;
- CWC station catchment metadata;
- NRSC Mandakini hydrological modelling documentation;
- topographic drainage;
- river confluence at Rudraprayag.

## Computational Boundary vs Administrative Boundary

The hydrological model domain and the administrative alert domain are different concepts.

### Computational domain

Mandakini catchment upstream of Rudraprayag.

### Administrative/exposure domain

Villages and settlements located within or intersecting the computational domain.

The system will therefore calculate environmental/hydrological risk within the catchment and subsequently map the risk to relevant villages and settlements for decision support and alerting.