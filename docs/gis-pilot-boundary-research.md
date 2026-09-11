# PRAVAAH-AI — GIS Pilot Boundary Research Report

**Research date:** 2026-09-10
**Researcher:** GIS/Data Engineering Agent
**Status:** Research complete — boundary acquisition requires manual portal access

---

## 1. Executive Conclusion

**No freely downloadable, machine-readable GIS boundary file for the Mandakini River catchment upstream of Rudraprayag was obtained during this research session.**

The primary reason is that the authoritative Indian government geospatial portals (Bhuvan, India-WRIS) either:

1. require user registration and interactive browser-based navigation to access downloadable boundary shapefiles; or
2. were inaccessible during the research session due to server connectivity issues (India-WRIS timed out); or
3. expose the data through OGC web services (WMS/WFS) that require GIS software interaction and are not available as direct file downloads via a stable URL.

**However, the research has successfully identified and documented:**

- The authoritative Indian government sources that maintain hydrological boundary data
- The CWC Rudraprayag (M) station code, coordinates, and river classification
- The India-WRIS Watershed Atlas codification system for the Mandakini sub-basin
- Multiple candidate boundary sources ranked by authoritativeness
- The discrepancies between published catchment area values and their likely explanations
- A reproducible fallback approach using HydroBASINS (global, free, peer-reviewed)

**Recommended next action:** A human operator should log into the Bhuvan portal and India-WRIS WebGIS to download the official hydrological boundary for the Mandakini catchment. If that proves infeasible, the HydroBASINS Level 12 dataset for Asia provides a scientifically defensible, freely downloadable alternative.

---

## 2. Exact Pilot-Region Definition

| Field | Value |
|---|---|
| **Region** | Mandakini River Catchment upstream of Rudraprayag |
| **State** | Uttarakhand, India |
| **River system** | Ganga → Alaknanda → Mandakini |
| **Outlet reference** | Rudraprayag (confluence of Mandakini and Alaknanda) |
| **Hydrological definition** | All land area draining into the Mandakini River at or upstream of Rudraprayag |
| **Approximate area (NRSC)** | ~1,614 km² |
| **Approximate area (CWC)** | ~1,644 km² |
| **Boundary status** | Not yet acquired as a GIS file — pending portal access |

---

## 3. Rudraprayag Outlet Reference

### CWC Station: Rudraprayag (M)

| Field | Value | Source |
|---|---|---|
| **Station name** | Rudraprayag (M) | CWC station directory |
| **Station code** | GG250A5 | CWC (cwc.gov.in) |
| **River** | Mandakini | CWC station metadata |
| **Category** | GD (Gauge and Discharge) | CWC station metadata |
| **Basin organization** | Upper Ganga Basin Organisation (UGBO) | CWC |
| **Approximate coordinates (DMS)** | 30°17'20" N, 78°59'00" E | CWC/Scribd station metadata |
| **Approximate coordinates (decimal)** | 30.2889° N, 78.9833° E | Converted from DMS above |
| **CWC water quality station coordinates (decimal)** | 30.2875° N, 78.9844° E | CWC water quality monitoring |
| **Catchment area** | ~1,644 km² (commonly cited) | CWC hydrological data tables |

**Coordinate conversion note:**
- 30°17'20" N = 30 + 17/60 + 20/3600 = 30.28889° N
- 78°59'00" E = 78 + 59/60 + 0/3600 = 78.98333° E

These differ slightly from the values previously documented in pilot-region.md (30°17'23" N, 78°58'49" E → 30.2897° N, 78.9803° E). Both sets originate from CWC/government sources but may reference slightly different measurement points.

**Other CWC stations at Rudraprayag:**
- Rudraprayag (A) — Before Confluence (on the Alaknanda)
- Rudraprayag (C) — After Confluence (downstream)
- Rudraprayag (M) — On the Mandakini (our reference station)

The "(M)" suffix designates the Mandakini-specific station, confirming it is the correct outlet reference for the Mandakini catchment.

---

## 4. Official Boundary Sources Investigated

### 4.1 ISRO / NRSC / Bhuvan

| Item | Finding |
|---|---|
| **Portal** | https://bhuvan.nrsc.gov.in/ |
| **Accessibility** | Portal accessible (HTTP 200); single-page JavaScript application |
| **Hydrological layers** | Documented to include: Basins, Sub-basins, Watersheds |
| **NHP portal** | https://bhuvan.nrsc.gov.in/nhp/ — National Hydrology Project products |
| **WMS service** | https://bhuvan-vec2.nrsc.gov.in/bhuvan/wms — OGC WMS documented |
| **WMS accessibility** | UNVERIFIED — connection timed out during this research session |
| **Download mechanism** | Bhuvan Open Data Archive — requires free user registration |
| **File format** | Shapefiles / GeoJSON reported for vector boundary downloads |
| **IWMP portal** | https://bhuvan-app1.nrsc.gov.in/iwmp/ — Watershed management; timed out |
| **HUMID** | Hydrologic Unit Model for InDia — interactive datasets for Indian river basins |
| **Direct boundary download** | **NOT OBTAINED** — requires interactive browser session with registration |

### 4.2 NRSC Mandakini Hydrological Modelling Study

| Item | Finding |
|---|---|
| **Study context** | NRSC has conducted post-disaster assessments (2013 Kedarnath floods) and hydrological modelling for the Mandakini/Alaknanda system |
| **1,614 km² figure** | Referenced in NRSC documentation; exact standalone report not located as a public download |
| **Modelling system** | NRSC typically uses VIC (Variable Infiltration Capacity) model under NHMS, or SWAT under HUMID |
| **DEM used** | Typically CartoDEM (NRSC product) |
| **Downloadable GIS boundaries** | **UNVERIFIED** — project-specific GIS boundaries are not typically provided as standalone downloads |

### 4.3 Central Water Commission (CWC)

| Item | Finding |
|---|---|
| **Portal** | https://cwc.gov.in/ |
| **Accessibility** | Accessible (HTTP 200) |
| **Station identified** | Rudraprayag (M) — Station code GG250A5 |
| **Station type** | GD (Gauge and Discharge) |
| **Catchment area** | ~1,644 km² |
| **Station directory** | Published as "Hydrological Observation Stations in India" (8th edition, 2025) |
| **Other Mandakini stations** | Gaurikund, Kedarnath, Augustmuni, Chandrapuri |
| **Telemetry** | Centralized through National Water Data Portal (nwic.gov.in) |
| **GIS boundary download** | **NOT AVAILABLE** directly from CWC website |

### 4.4 India-WRIS

| Item | Finding |
|---|---|
| **Portal** | https://indiawris.gov.in/wris/ |
| **Accessibility** | **INACCESSIBLE** — connection timed out during research |
| **Alternative URL** | https://india-wris.nrsc.gov.in/ — DNS lookup failed |
| **WebGIS** | Documented to include Watershed Atlas layer with interactive boundary selection |
| **Watershed Atlas codification** | Hierarchical alphanumeric system (Region → Basin → Catchment → Sub-catchment → Watershed) |
| **Mandakini sub-basin code** | 02L01R12 (referenced in cGanga documentation; UNVERIFIED against WRIS directly) |
| **Download capability** | Documented but UNVERIFIED — requires registration and interactive access |
| **NWIC helpdesk** | helpdesk-nwic@gov.in |

### 4.5 Survey of India

| Item | Finding |
|---|---|
| **Portal** | https://onlinemaps.surveyofindia.gov.in/ |
| **DEM/DTM** | 10m DTM from 1:50,000 scale topographic contours |
| **NHP terrain** | 0.5m, 5m, 10m DEMs for river basins under NHP-III |
| **Access** | Registration required; NHP data may require formal request through NGDC |
| **Watershed delineation** | Not available on the portal |
| **Administrative boundaries** | Village-level boundaries available as shapefiles (registration required) |
| **Format** | .img, .tiff (raster), .shp (vector) |

### 4.6 GSI Bhukosh / Bhusanket

| Item | Finding |
|---|---|
| **Bhusanket** | https://bhusanket.gsi.gov.in/ — viewing dashboard, no direct download |
| **Bhukosh / NGDR** | https://bhukosh.gsi.gov.in/Bhukosh/Public — data download portal |
| **WMS/WFS** | OGC-compliant services available for geological/landslide data |
| **Registration** | Required for shapefile download (GSI OCBIS portal) |
| **Landslide inventory** | National Landslide Susceptibility Mapping (NLSM) available |
| **Uttarakhand coverage** | Yes — Rudraprayag, Chamoli, Uttarkashi districts covered |

### 4.7 HydroBASINS (Global — Fallback Option)

| Item | Finding |
|---|---|
| **Provider** | WWF / McGill University (HydroSHEDS project) |
| **Portal** | https://www.hydrosheds.org/products/hydrobasins |
| **Accessibility** | Freely downloadable, no registration required |
| **Format** | Shapefile (vector) |
| **CRS** | WGS84 (EPSG:4326) |
| **Resolution** | Derived from ~450m SRTM DEM |
| **Levels** | Pfafstetter levels 1–12 |
| **Level 12** | Most detailed sub-basin breakdown |
| **Region file** | Asia — single shapefile covering India |
| **Method** | DEM-derived, globally consistent watershed delineation |
| **Status** | Peer-reviewed, widely used in hydrological research |
| **Limitation** | Not an Indian government source; derived from SRTM (90m effective), not CartoDEM |

---

## 5. Boundary Options Considered

| Option | Source | Authoritativeness | Downloadability | Machine-Readable | Reproducibility | Status |
|---|---|---|---|---|---|---|
| **A. India-WRIS Watershed Atlas** | CWC/NRSC | **Highest** — official Indian government watershed delineation | Requires registration + interactive access | Shapefile/GeoJSON if obtained | Stable; codified | **UNVERIFIED** — portal inaccessible |
| **B. Bhuvan hydrological boundary** | ISRO/NRSC | **High** — official government | Requires registration + interactive access | Shapefile/GeoJSON if obtained | Stable | **UNVERIFIED** — requires browser login |
| **C. DEM-derived from SOI DTM** | Survey of India | **High** — official DEM | Requires registration + GIS processing | Generated by user | Reproducible from source DEM | Requires manual work |
| **D. HydroBASINS Level 12** | WWF/McGill (global) | **Medium** — peer-reviewed global dataset | Freely downloadable | Shapefile | Highly reproducible | **AVAILABLE** |
| **E. DEM-derived from CartoDEM** | NRSC | **High** — official Indian DEM | Requires Bhuvan registration | Generated by user | Reproducible | Requires registration + processing |
| **F. SLUSI Micro-watershed Atlas** | Dept of Agriculture | **High** — official | Bharatlas.com hosts processed version | Parquet/Shapefile via third-party | Stable codification | Requires verification |

---

## 6. Dataset/Service URLs

| Source | URL | Status |
|---|---|---|
| Bhuvan main | https://bhuvan.nrsc.gov.in/ | Accessible |
| Bhuvan NHP | https://bhuvan.nrsc.gov.in/nhp/ | Accessible |
| Bhuvan WMS | https://bhuvan-vec2.nrsc.gov.in/bhuvan/wms | Timed out |
| Bhuvan IWMP | https://bhuvan-app1.nrsc.gov.in/iwmp/ | Timed out |
| India-WRIS | https://indiawris.gov.in/wris/ | Timed out |
| India-WRIS Atlas | https://indiawris.gov.in/wris/#/atlas | Timed out |
| CWC | https://cwc.gov.in/ | Accessible |
| CWC Hydro-met | https://cwc.gov.in/hydro-meteorological-observation | Accessible |
| FFS India Water | https://ffs.india-water.gov.in/ | Accessible (SPA, requires JS) |
| NWIC | https://nwic.gov.in/ | UNVERIFIED |
| NWDP | https://nwdp.nwic.gov.in/ | UNVERIFIED |
| SOI Online Maps | https://onlinemaps.surveyofindia.gov.in/ | Accessible |
| GSI Bhusanket | https://bhusanket.gsi.gov.in/ | Accessible (viewing only) |
| GSI Bhukosh/NGDR | https://bhukosh.gsi.gov.in/Bhukosh/Public | Accessible (registration required) |
| HydroBASINS | https://www.hydrosheds.org/products/hydrobasins | Accessible (free download) |
| SLUSI | http://slusi.dacnet.nic.in/ | UNVERIFIED |
| Bharatlas SLUSI | https://bharatlas.com/view/slusi_micro_watersheds | UNVERIFIED |

---

## 7. GIS Format Summary

| Source | Format | Notes |
|---|---|---|
| Bhuvan downloads | Shapefile, GeoJSON | After registration |
| India-WRIS | Shapefile, KML | After registration |
| SOI | Shapefile (.shp), raster (.img, .tiff) | After registration |
| GSI Bhukosh | Shapefile (via OCBIS) | Registration required |
| HydroBASINS | Shapefile (.shp) | Direct download |
| NWDP | KMZ, GeoJSON | UNVERIFIED |

---

## 8. CRS Information

| Source | CRS | Notes |
|---|---|---|
| Bhuvan | Typically WGS84 (EPSG:4326) | Standard for Indian geoportals |
| India-WRIS | Typically WGS84 (EPSG:4326) | Standard for CWC/NRSC products |
| SOI | WGS84 or Everest 1830 depending on product | SOI uses both; modern products typically WGS84 |
| HydroBASINS | WGS84 (EPSG:4326) | Confirmed in documentation |
| CartoDEM | WGS84 (EPSG:4326) | NRSC standard |

---

## 9. Spatial Scale / Resolution

| Source | Scale / Resolution | Notes |
|---|---|---|
| India-WRIS Watershed Atlas | 1:250,000 (basin) to 1:50,000 (micro-watershed) | Hierarchical levels |
| Bhuvan hydrological | Varies by layer | Basin/sub-basin/watershed |
| SOI DTM | 10m (from 1:50,000 contours) | Public DTM |
| SOI NHP DTM | 0.5m, 5m, 10m | Restricted access |
| CartoDEM | ~30m | NRSC product |
| HydroBASINS | Derived from ~450m SRTM | Global DEM |
| SLUSI micro-watersheds | ~1:50,000 | Micro-watershed level |

---

## 10. Metadata

| Field | Best Known Value |
|---|---|
| **River** | Mandakini |
| **CWC Station** | Rudraprayag (M) / GG250A5 |
| **Station type** | GD (Gauge and Discharge) |
| **Basin** | Ganga |
| **Sub-basin** | Alaknanda |
| **Catchment** | Mandakini (upstream of Rudraprayag) |
| **WRIS code** | 02L01R12 (UNVERIFIED — from cGanga) |
| **Approx. coordinates** | 30.289° N, 78.983° E |
| **NRSC area** | ~1,614 km² |
| **CWC area** | ~1,644 km² |

---

## 11. Access Method Summary

| Source | Access Method | Effort Required |
|---|---|---|
| India-WRIS | Registration → WebGIS → interactive selection → download | Medium (if portal is accessible) |
| Bhuvan | Registration → Open Data Archive → search → download | Medium |
| SOI | Registration → OMP → search → download | Medium |
| GSI Bhukosh | Registration → OCBIS → search → download | Medium |
| HydroBASINS | Direct HTTP download → GIS filter | Low |
| CWC station data | Portal browsing / PDF documents | Manual |

---

## 12. Data Reliability Assessment

| Source | Reliability | Notes |
|---|---|---|
| India-WRIS | **High** (if accessible) | Official government; intermittent availability |
| Bhuvan | **High** | Official ISRO/NRSC; requires registration |
| CWC | **High** (station data) | Station metadata well-documented |
| SOI | **High** | National mapping authority |
| GSI | **High** | National geological authority |
| HydroBASINS | **Medium-High** | Peer-reviewed global dataset; not Indian government |

---

## 13. Discrepancies Between Official Area Values

### Published values

| Source | Catchment area | Reference |
|---|---|---|
| NRSC | ~1,614 km² | "Hydrological Modelling Study of Mandakini and Alaknanda (Upstream)" |
| CWC | ~1,644 km² | Rudraprayag (M) station metadata |
| Academic literature | ~1,646 km² | Various hydrological papers |
| Some morphometric studies | ~1,982 km² | Extended physiographic definition (UNVERIFIED scope) |

### Possible explanations for the ~30 km² discrepancy between NRSC (1,614) and CWC (1,644)

The following are **possible** explanations. None can be confirmed without accessing both source datasets and comparing their boundaries:

1. **Different outlet points:** The CWC station GG250A5 and the NRSC hydrological model outlet may be at slightly different locations along the Mandakini near Rudraprayag. Even a few hundred meters difference in outlet location at a confluence can change the delineated catchment area.

2. **Different DEMs:** NRSC may have used CartoDEM (~30m), while the CWC/WRIS watershed atlas may have used SRTM or SOI contour-derived DEM. Different DEMs produce different flow-direction grids and therefore different watershed boundaries.

3. **Different hydrological boundary levels:** The NRSC value may correspond to a hydrological model domain (specific sub-catchment), while the CWC value may correspond to the station's official catchment area measured from a different watershed atlas edition.

4. **Rounding and measurement precision:** Both values are approximate. The difference is ~1.9%, which is within typical uncertainty bounds for watershed delineation from medium-resolution DEMs.

5. **The ~1,982 km² figure** (from some studies) likely uses a different — possibly extended — definition of the Mandakini basin boundary, possibly including areas that other definitions assign to adjacent catchments.

### Resolution

**This discrepancy should NOT be resolved by selecting an arbitrary number.** The correct approach is:

1. Obtain the actual GIS boundary polygon from India-WRIS or Bhuvan.
2. Calculate the area from the polygon itself.
3. Document which boundary was used and its provenance.
4. If the CWC station location falls within or on the boundary of the polygon, the polygon is consistent.

---

## 14. Recommended Canonical Boundary

### Primary recommendation: India-WRIS Watershed Atlas boundary

**Rationale:**
- Official Government of India watershed delineation
- Hierarchical codification (Region → Basin → Catchment → Sub-catchment → Watershed)
- Maintained by CWC/NRSC jointly
- Used by government agencies for hydrological planning
- Linked to CWC station infrastructure

**Action required:** Manual portal access to India-WRIS WebGIS to select and download the Mandakini sub-basin (candidate code: 02L01R12).

### Secondary recommendation: Bhuvan hydrological boundary

If India-WRIS is inaccessible, the Bhuvan portal should provide equivalent or similar hydrological boundaries.

### Fallback: HydroBASINS Level 12

If government portals remain inaccessible, the HydroBASINS Level 12 dataset for Asia provides a freely downloadable, peer-reviewed, scientifically defensible alternative. The catchment would be constructed by:

1. Downloading HydroBASINS Asia Level 12 shapefile
2. Identifying the outlet pour point near Rudraprayag (30.289° N, 78.983° E)
3. Selecting all upstream sub-basin polygons using the HYBAS_ID / NEXT_DOWN topology
4. Merging them into a single catchment polygon
5. Documenting the area and comparing with published values

**Limitation:** HydroBASINS is derived from SRTM (~90m), not the higher-resolution Indian DEMs. The boundary may differ slightly from Indian government delineations.

### Recommended boundary type

**Catchment polygon** (vector) is the most appropriate boundary representation because:
- It directly corresponds to the hydrological drainage area
- It is standard for hydrological modelling
- It can be intersected with administrative (village) boundaries
- It is machine-readable
- It supports spatial queries against other GIS layers

A sub-basin polygon or watershed polygon from the India-WRIS hierarchy would also be appropriate, provided it matches the Mandakini catchment at the appropriate scale.

---

## 15. Unresolved Issues

| # | Issue | Priority | Required action |
|---|---|---|---|
| 1 | **No boundary GIS file obtained** | **CRITICAL** | Manual portal access to Bhuvan/India-WRIS required |
| 2 | **India-WRIS portal inaccessible** | HIGH | Retry access; contact NWIC helpdesk if persistent |
| 3 | **Bhuvan WMS timed out** | HIGH | Retry WMS GetCapabilities; identify exact layer names |
| 4 | **NRSC 1,614 km² report not located** | MEDIUM | Search Bhuvan NHP document archive |
| 5 | **CWC coordinates have small discrepancies** | LOW | Verify exact coordinates from 8th edition station directory PDF |
| 6 | **India-WRIS sub-basin code 02L01R12** | MEDIUM | Verify against actual WRIS WebGIS portal |
| 7 | **Village boundary polygons not obtained** | MEDIUM | Access SOI OMP or Bhuvan Panchayat portal |
| 8 | **GSI landslide data access** | MEDIUM | Register on GSI OCBIS for Bhukosh downloads |

---

## 16. Exact Next Actions

1. **IMMEDIATE:** Register on Bhuvan (https://bhuvan.nrsc.gov.in/) if not already registered.

2. **IMMEDIATE:** Attempt to access India-WRIS (https://indiawris.gov.in/wris/) — register and navigate to the Watershed Atlas layer. Select the Mandakini sub-basin (search for code 02L01R12 or navigate to Ganga → Alaknanda → Mandakini). Download the boundary shapefile.

3. **IMMEDIATE:** If India-WRIS is down, access Bhuvan Open Data Archive and search for hydrological boundary layers covering the Mandakini/Alaknanda system. Download the relevant boundary.

4. **FALLBACK:** If government portal access is blocked, download HydroBASINS Asia Level 12 from https://www.hydrosheds.org/products/hydrobasins and extract the Mandakini catchment computationally.

5. **VALIDATION:** Once a boundary polygon is obtained, validate it:
   - Open in QGIS/GIS software
   - Verify CRS
   - Check geometry validity
   - Calculate area
   - Compare with published values (1,614 / 1,644 km²)
   - Verify CWC Rudraprayag (M) station falls on or near the outlet

6. **STORAGE:** Store the validated boundary as:
   - `data/external/boundaries/mandakini_catchment_upstream_rudraprayag.<ext>`
   - `data/external/boundaries/mandakini_catchment_upstream_rudraprayag.metadata.json`

7. **VILLAGE BOUNDARIES:** Register on SOI OMP (https://onlinemaps.surveyofindia.gov.in/) and download Rudraprayag district village boundary shapefiles.

8. **GSI REGISTRATION:** Register on GSI OCBIS portal for Bhukosh data access.
