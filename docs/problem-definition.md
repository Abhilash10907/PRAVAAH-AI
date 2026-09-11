# PRAVAAH-AI — Problem Definition

## 1. Project Identification

**Project Name:** PRAVAAH-AI

**SIH Problem Statement ID:** SIH26192

**SIH Problem Statement:** Flash Flood Prediction System for Hilly Regions using Multi-Source Data Theme

**Organization:** Ministry of Home Affairs

**Department:** National Disaster Response Force (NDRF), DM Division

**Category:** Software

**Theme:** Disaster Management

---

## 2. Official Problem Statement

### Background

Hilly states in India are highly vulnerable to landslides and flash floods, which often occur with very short warning times. These sudden events result in significant loss of lives and property, and current early warning mechanisms are inadequate for hyper-local prediction and timely evacuation.

### Description

The proposed initiative aims to develop a predictive system that integrates multiple data sources - rainfall data, soil moisture sensors, slope stability models, historical landslide inventories, and real-time IoT inputs. By combining these datasets, the system will generate hyper-local forecasts at the village or ward level, providing sufficient lead time for evacuation and risk mitigation.

### Expected Solution

A comprehensive flash flood prediction system that integrates rainfall, soil moisture, slope stability, and historical disaster data, utilizes IoT sensors for real-time monitoring, issues hyper-local early warnings at village/ward level, and provides actionable lead time for evacuation and disaster preparedness.

---

## 3. Problem Interpretation

The project is intended to address the difficulty of providing sufficiently localized and actionable flash-flood risk information in hilly regions.

The system should combine multiple categories of information rather than relying exclusively on rainfall. These categories include:

1. Rainfall and precipitation information.
2. Soil moisture and antecedent wetness conditions.
3. Terrain and slope-related characteristics.
4. Historical landslide and disaster information.
5. Real-time observations from IoT sensors where available.
6. Existing government hazard and forecasting information where technically and legally usable.

The resulting system should estimate the level of flash-flood risk for a defined geographic unit such as a watershed, village, ward or other operationally meaningful area and provide an understandable warning with an associated forecast time window.

---

## 4. Core Objective

Develop a multi-source, hyper-local flash-flood risk assessment and early-warning platform for hilly regions that:

- integrates heterogeneous environmental and geospatial data;
- makes use of existing government forecasting and observation infrastructure wherever possible;
- incorporates local observations when available;
- estimates short-term flash-flood risk for defined geographic areas;
- provides a clear forecast horizon and risk level;
- communicates the factors contributing to the predicted risk;
- supports timely disaster preparedness and evacuation decision-making.

---

## 5. Important Scope Clarification

PRAVAAH-AI is not intended to replace national meteorological or disaster-management forecasting systems.

The project will investigate how existing government information can be reused and enhanced through additional terrain, historical, hydrological and local IoT information to provide a more localized decision-support layer.

The existing India Meteorological Department (IMD) Flash Flood Guidance System will therefore be treated as an important government reference and potential baseline rather than duplicated unnecessarily.

---

## 6. Prediction Objective

The system's prediction target must be defined precisely before model development.

A prediction should specify:

- geographic location or spatial unit;
- forecast issue time;
- prediction horizon;
- event definition;
- risk/probability value;
- confidence or uncertainty where appropriate.

For example, a future implementation may estimate:

P(flash flood occurs within the next N hours | information available at time T)

The exact prediction horizons and event definition will be finalized during the data and validation design phase.

The system must not present an arbitrary probability value without a clearly defined event, forecast window, geographic area, and validation methodology.

---

## 7. Proposed High-Level Inputs

Potential input categories include:

### Meteorological

- observed rainfall;
- rainfall accumulation over multiple preceding time windows;
- rainfall intensity;
- forecast precipitation;
- weather-model outputs;
- other relevant meteorological observations.

### Soil and Land Surface

- soil moisture;
- antecedent wetness;
- soil saturation indicators;
- relevant land-surface variables.

### Terrain and Geospatial

- elevation;
- slope;
- aspect;
- curvature;
- drainage characteristics;
- flow accumulation;
- watershed characteristics;
- terrain susceptibility indicators.

### Historical Hazard Information

- historical flash-flood events;
- historical flood/inundation information where available;
- historical landslide inventories;
- landslide susceptibility information;
- other relevant historical disaster information.

### Hydrological

Where available and appropriate:

- river/stream water levels;
- discharge;
- runoff-related variables;
- catchment characteristics.

### Local IoT Observations

Potential sensor inputs include:

- local rainfall;
- soil moisture;
- water level;
- stream level;
- other validated environmental observations.

---

## 8. Proposed Outputs

The system should ultimately provide information such as:

- hyper-local risk level;
- estimated flash-flood probability where scientifically justified;
- expected threat time window;
- location affected;
- contributing factors;
- severity/risk category;
- lead time;
- map-based visualization;
- alerts for relevant users;
- supporting information for preparedness and evacuation decisions.

The final alerting mechanism and authority model must be designed carefully. The prototype should distinguish between a model-generated risk assessment and an officially authorized disaster warning.

---

## 9. Hyper-Local Requirement

The project specifically requires localization at the village or ward level.

However, the model should not assume that all source datasets naturally exist at village or ward resolution.

Where source data have coarser spatial resolution, appropriate spatial downscaling, interpolation, hydrological modelling, terrain-based transformation or sensor fusion methods must be investigated and documented.

The system must clearly distinguish:

- native data resolution;
- derived resolution;
- model prediction resolution.

A map displaying a village boundary does not by itself constitute a village-level prediction.

---

## 10. Real-Time Requirement

The eventual platform should support a near-real-time data flow where data availability permits.

A conceptual pipeline is:

Data ingestion
→ validation
→ temporal/spatial alignment
→ feature generation
→ risk estimation
→ validation/calibration
→ visualization
→ alert/decision-support layer.

The architecture should allow additional data sources and IoT sensors to be integrated without redesigning the entire system.

---

## 11. Existing Government Infrastructure

Existing government systems should be reused wherever possible instead of unnecessarily rebuilding equivalent functionality.

In particular, the India Meteorological Department's National Flash Flood Guidance system provides existing flash-flood guidance based on rainfall, land-surface/soil-saturation information and forecast meteorological inputs, with observed threat and future flash-flood risk products.

PRAVAAH-AI will therefore investigate how government information can be:

- consumed;
- referenced;
- fused with additional information;
- localized;
- visualized;
- and incorporated into a decision-support workflow.

The system's differentiation must be established through technical analysis rather than assumed in advance.

---

## 12. Non-Goals

At the current stage, PRAVAAH-AI will not assume:

- nationwide sensor coverage;
- availability of real-time IoT observations at every village;
- a single government dataset containing every required variable;
- a universally available village-level flash-flood ground-truth dataset;
- that an ML model automatically provides a trustworthy probability simply because it outputs a number;
- that existing government systems can be directly replicated without understanding their data, models and access mechanisms.

These assumptions must be verified during the research and implementation phases.

---

## 13. Primary Technical Challenges

The major technical challenges expected to require investigation are:

1. Obtaining reliable historical flash-flood/flood event labels.
2. Synchronizing data from different spatial and temporal resolutions.
3. Establishing a leakage-free historical training dataset.
4. Handling sparse and unevenly distributed IoT observations.
5. Integrating static terrain variables with time-varying environmental variables.
6. Producing calibrated risk probabilities rather than unsupported scores.
7. Validating predictions against historical events.
8. Measuring useful lead time and false-alarm behaviour.
9. Providing hyper-local outputs without overstating the resolution of the underlying evidence.
10. Integrating existing government information without unnecessarily duplicating operational systems.

---

## 14. Success Criteria

A successful prototype should demonstrate that it can:

- ingest and standardize multiple relevant data sources;
- reproduce or use appropriate existing government information where accessible;
- construct a defensible historical dataset;
- estimate flash-flood risk for defined geographic units;
- provide predictions for a clearly defined future time window;
- demonstrate performance against historical events;
- report relevant evaluation metrics;
- provide interpretable factors contributing to elevated risk;
- visualize risk geographically;
- demonstrate an end-to-end near-real-time workflow using live or realistically simulated inputs;
- generate actionable information suitable for disaster-management decision support.

---

## 15. Current Status

This document defines the initial project scope and technical interpretation.

The following items remain to be investigated before model development:

- authoritative data sources;
- data access mechanisms;
- data licensing and usage constraints;
- spatial and temporal resolutions;
- historical event inventories;
- ground-truth construction;
- baseline methodology;
- model architecture;
- validation methodology;
- IoT architecture;
- deployment architecture.

No final ML algorithm or probability threshold has been selected at this stage.