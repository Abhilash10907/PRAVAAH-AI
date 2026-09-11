# PRAVAAH-AI — Mandakini Catchment Boundary Verification Report

**Research date:** 2026-09-10
**Status:** PROVISIONALLY VERIFIED

---

## Verification Status

### PROVISIONALLY VERIFIED

The authoritative Indian government GIS service and boundary layer for the Mandakini River catchment upstream of Rudraprayag have been **identified and confirmed through live queries**. However, the complete assembled GIS polygon has **not yet been validated** (area computation, geometry validity, overlay verification).

---

## What Was Successfully Verified

### 1. Authoritative GIS Service Identified

| Field | Value |
|---|---|
| **Provider** | ISRO / National Remote Sensing Centre (NRSC) |
| **Platform** | Bhuvan GeoServer |
| **Service URL** | `https://bhuvan-vec1.nrsc.gov.in/bhuvan/wms` |
| **Service type** | OGC WMS 1.1.1 |
| **Layer name** | `cite:bhuvan_watershed` |
| **Feature type** | `UK_WS` (Uttarakhand Watersheds) |
| **CRS** | EPSG:4326 (WGS84) |
| **Geometry type** | MultiPolygon |
| **Access constraints** | NONE (declared in WMS GetCapabilities) |
| **Fees** | NONE (declared in WMS GetCapabilities) |
| **Contact** | bhuvan@nrsc.gov.in |

**Verification method:** WMS GetCapabilities request returned full XML capabilities document from GeoServer operated by NRSC, Hyderabad. The layer `cite:bhuvan_watershed` is listed as queryable with EPSG:4326 CRS and covers all of India (bbox: 68.14°E to 97.40°E, 8.08°N to 33.21°N).

### 2. Feature Schema Confirmed

Each watershed polygon has exactly two attributes:

| Attribute | Type | Example | Description |
|---|---|---|---|
| `NRISCODE` | String (16 digits) | `0202050601010102` | India-WRIS/SLUSI hierarchical watershed code |
| `WATERSHEDC` | String (8 alphanumeric) | `2B5F1A1B` | Alpha-numeric encoding of the same hierarchy |

**Verification method:** WMS GetFeatureInfo requests with `INFO_FORMAT=text/plain` and `INFO_FORMAT=application/json` returned consistent attribute names and values.

### 3. Mandakini Catchment Code Prefix Confirmed

**NRISCODE prefix for Mandakini catchment: `0202050601`**

| Level | Code | Meaning |
|---|---|---|
| Water Resources Region | `02` | Ganga system |
| Basin | `02` | Ganga basin |
| Catchment | `05` | Alaknanda catchment |
| Sub-catchment | `06` | Mandakini |
| Sub-level | `01` | Primary sub-division |

**Verification method:** Systematic grid-point GetFeatureInfo queries across 14 named locations along the Mandakini valley (Rudraprayag, Tilwara, Augustmuni, Chandrapuri, Ukhimath, Guptkashi, Phata, Sonprayag, Gaurikund, Kedarnath, and others). ALL points within the Mandakini valley returned NRISCODE values starting with `0202050601`.

**Critical cross-check:** The Rudraprayag confluence point on the Alaknanda side (78.98°E, 30.28°N) returned NRISCODE `0202050402...` — a completely different sub-catchment code (Alaknanda). This confirms that the `0202050601` prefix correctly identifies the Mandakini sub-catchment and terminates at the Rudraprayag confluence.

### 4. Watershed Count

**Fine-grid scan (2.5 km spacing) identified 100+ unique watershed polygons** with NRISCODE prefix `0202050601`. These span the full Mandakini catchment from the headwaters near Kedarnath (79.07°E, 30.73°N) to the outlet at Rudraprayag (78.98°E, 30.29°N).

### 5. WFS Status

The `cite:bhuvan_watershed` layer is **NOT exposed via WFS** (Web Feature Service). Bulk feature download with attribute filtering is therefore not possible through OGC standard endpoints.

Feature geometries are accessible through:
- **WMS GetFeatureInfo** (returns full GeoJSON geometry for point queries) — confirmed working
- **Bhuvan interactive portal** (requires registration) — not tested in this session

---

## What Could NOT Be Verified

| Item | Reason |
|---|---|
| **Total area of assembled catchment** | Requires merging all watershed polygons in GIS software and computing area |
| **Geometry validity** | Individual polygons returned valid GeoJSON; overall validity after merge not tested |
| **Exact match to CWC 1,644 km²** | Area not yet computed |
| **Exact match to NRSC 1,614 km²** | Area not yet computed |
| **Completeness of watershed collection** | Grid sampling may miss very small watersheds between sample points |
| **India-WRIS portal confirmation** | Portal was inaccessible during testing |
| **Bhuvan portal download** | Requires user registration; not performed |

---

## Discrepancy Analysis

### Published area values

| Source | Area (km²) |
|---|---|
| NRSC Mandakini hydrological study | ~1,614 |
| CWC Rudraprayag (M) station | ~1,644 |
| Bhuvan WMS boundary | Not yet computed |

The ~30 km² difference cannot be resolved without computing the area of the downloaded boundary and comparing outlet point locations. Possible explanations remain:

1. Different outlet points (CWC station vs. NRSC model domain boundary)
2. Different DEM sources for delineation
3. Different editions of the watershed atlas
4. Rounding/measurement precision

---

## Files Created

| File | Description |
|---|---|
| `docs/research-results/mandakini-boundary.json` | Machine-readable research result |
| `docs/research-results/BOUNDARY_VERIFICATION.md` | This verification report |
| `data/external/boundaries/collect_mandakini_watersheds.ps1` | Collection script |
| `data/external/boundaries/temp_ws_*.json` | Individual watershed GeoJSON files (if collection completed) |
| `data/external/boundaries/mandakini_watershed_collection_summary.json` | Collection summary metadata |

---

## Recommended Next Steps

### Immediate (required for VERIFIED status)

1. **Complete the watershed geometry collection** — Run the collection script or manually download from Bhuvan portal
2. **Merge/dissolve watershed polygons** — Use QGIS or Python (shapely/geopandas) to merge all `0202050601*` polygons into a single catchment boundary
3. **Compute area** — Calculate geodesic area of the merged polygon
4. **Validate geometry** — Check for self-intersections, holes, and slivers
5. **Verify CWC station location** — Confirm that the Rudraprayag (M) station coordinates fall on or very near the outlet of the merged polygon
6. **Compare area** — Document the relationship to the CWC (1,644 km²) and NRSC (1,614 km²) values

### Recommended (for production use)

7. **Register on Bhuvan** — Access the interactive portal for direct shapefile download of the watershed boundary
8. **Register on India-WRIS** — Verify the NRISCODE `0202050601` assignment and download official boundary
9. **Contact NWIC** — If portal access remains problematic, contact helpdesk-nwic@gov.in for official watershed atlas data
10. **Save canonical boundary** — Store the final validated boundary as `data/external/boundaries/mandakini_catchment_upstream_rudraprayag.geojson`
