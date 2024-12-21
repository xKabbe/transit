  
## Architecture  
  
```mermaid  
flowchart TB  
    %% Data Sources
    subgraph Data_Sources [Data Sources]
    NASA_API([NASA API - Real-Time Data])
    Python_Libraries([Python Libraries - Astropy, Skyfield, etc.])
    end
    
    %% Data Preprocessing  
    subgraph Data_Preprocessing [Data Preprocessing]
    ETL(["ETL Pipeline (Extract, Transform, Load)"])
    end
    
    %% Backend System
    subgraph Backend [Backend System]
    API_FastAPI([FastAPI - API])
    API_Gateway([API Gateway])
    Business_Logic([Business Logic])
    Data_Access([Data Access Layer])
    end
    
    %% Data Storage
    subgraph Databases [Data Storage]
    InfluxDB[(InfluxDB - Time-Series Data)]
    PostgreSQL[(PostgreSQL - Relational Data)]
    MongoDB[(MongoDB - Hierarchical Data)]
    end
    
    %% Machine Learning
    subgraph ML_Pipeline [Machine Learning]
    ML_Preprocessing([Data Preprocessing])
    ML_Training([Model Training])
    ML_Evaluation([Model Evaluation])
    ML_Deployment([Model Deployment - FastAPI])
    ML_Tech([TensorFlow / PyTorch / scikit-learn])
    ML_Workflow([Prefect / Airflow - Workflow Orchestration])
    end
    
    %% Monitoring & Logging
    subgraph Monitoring [Monitoring & Logging]
    Prometheus([Prometheus - Metrics Collection])
    Loki([Grafana Loki - Log Management])
    end
    
    %% Visualisation  
    subgraph Visualisation [Visualisation]
    Grafana([Grafana - Dashboards])
    end
    
    %% Frontend System
    subgraph Frontend [Frontend System]
    User_Interface([User Interface])
    React_App([React + Next.js Frontend])
    D3js([D3.js Visualizations])
    Threejs([Three.js - 3D Animations])
    end
    
    %% Documentation & Testing  
    subgraph Docs_Testing [Documentation & Testing]
    T1([pytest - Unit Testing])
    T2([Playwright - E2E Testing])
    T3([Docusaurus - Documentation])
    T4([Locust - Load Testing])
    end
    
    %% Infrastructure  
    subgraph Infra [Infrastructure]
    I1([Docker/Docker-Compose])
    I2([Kubernetes])
    end
    
    %% Connections
    Data_Sources -->|Raw Data| Data_Preprocessing
    Data_Preprocessing --> Backend
    Backend --> Frontend
    Databases --> Visualisation  
    Monitoring --> Visualisation
    ML_Pipeline --> Backend
    
    %% Data Flow & Interaction
    Backend -->|Write Real-Time Data| InfluxDB
    Backend -->|Write Archived Data| PostgreSQL
    Backend -->|Store Hierarchical Data| MongoDB
    Backend -->|Metrics & Logs| Prometheus
    Backend -->|Metrics & Logs| Loki
    ML_Pipeline -->|Fetch Data for Training| PostgreSQL
    ML_Pipeline -->|Store Model Artifacts| MongoDB
    ML_Pipeline -->|Log Metrics & Errors| Loki
    
    %% Workflow Automation
    Docs_Testing -.-> Infra
    Backend -.-> Infra
    Frontend -.-> Infra
    Monitoring -.-> Infra
    Databases -.-> Infra
    Visualisation -.-> Infra
    ML_Pipeline -.-> Infra  
``` 
  
## Data Flow  
  
- Data Source (NASA API / Python Libraries) provides initially raw and untransformed data that probably needs to be transformed into a suitable format (could contain various inconsistencies, missing values, or unstructured formats)  
- Move this data into the `Data Preprocessing` module where it goes through the `ETL (Extract, Transform, Load) Pipeline`  
- In the ETL pipeline the data gets:  
  - `Extracted`: The raw data is retrieved from the data source  
  - `Transformed`: The data gets cleaned, normalized, or reshaped to fit the systems needs  
  - `Loaded`: The transformed data is being passed to the backend where it gets stored in the storage systems  
- If the data is being stored in the databases via the backend, it can be queried through FastAPI endpoints via the frontend






## Workflow  
  
```mermaid  
sequenceDiagram  
    participant Source    participant ETL    participant Kafka    participant Backend    participant ML    participant InfluxDB    participant PostgreSQL    participant MongoDB    participant Grafana    participant Prometheus    participant Admin  
    %% Data Collection    Source->>ETL: Provide NASA API - Real-Time Data    Source->>ETL: Provide Python Libraries - Astropy, Skyfield, etc.        %% ETL Processing  
    ETL->>Kafka: Stream Preprocessed Data (Avro)    ETL->>Backend: Send Summary & Archived Data  
    %% Backend Processing    Backend->>InfluxDB: Write Real-Time Sensor Data    Backend->>PostgreSQL: Archive Summarized Data    Backend->>MongoDB: Store Hierarchical Data    Backend->>ML: Trigger ML Model for Analysis  
    %% ML Workflow    ML-->>Backend: Return Analysis Results    ML->>Workflow_Automation: Notify Retraining Required (Data Drift)  
    %% Prometheus Metrics    Backend->>Prometheus: Push Service Metrics    Prometheus-->>Grafana: Provide System Metrics  
    %% Monitoring & Logging    Backend->>Loki: Push Logs    Loki-->>Grafana: Provide Logs for Monitoring  
    %% Frontend Visualization    Backend-->>Grafana: Provide Data for Dashboards    Grafana->>Admin: Render System Dashboards    Grafana->>Admin: Render Data Dashboards  
    %% User Interaction    Admin->>Grafana: Interact with Dashboards    Admin->>Frontend: Access Reports and Visualizations  
```