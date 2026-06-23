CREATE DATABASE IF NOT EXISTS fermest;
USE fermest;

CREATE TABLE experiments (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(100),
    ph FLOAT NOT NULL,
    initial_temperature FLOAT NOT NULL,
    sugar_concentration FLOAT NOT NULL,
    microorganism_type VARCHAR(100),
    microorganism_amount FLOAT NOT NULL,
    total_time FLOAT DEFAULT 200,
    status VARCHAR(20) DEFAULT 'pending',
    execution_time FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE generations (
    id CHAR(36) PRIMARY KEY,
    experiment_id CHAR(36) NOT NULL,
    generation_number INT NOT NULL,
    best_fitness FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (experiment_id)
    REFERENCES experiments(id)
    ON DELETE CASCADE
);


CREATE TABLE individuals (
    id CHAR(36) PRIMARY KEY,
    generation_id CHAR(36) NOT NULL,
    rpm FLOAT NOT NULL,
    temperature FLOAT NOT NULL,
    flow FLOAT NOT NULL,
    fitness FLOAT,
    final_ethanol FLOAT,
    final_biomass FLOAT,
    final_substrate FLOAT,
    efficiency FLOAT,
    energy_consumption FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (generation_id)
    REFERENCES generations(id)
    ON DELETE CASCADE
);

CREATE TABLE simulation_results (
    id CHAR(36) PRIMARY KEY,
    individual_id CHAR(36) NOT NULL,
    time FLOAT NOT NULL,
    biomass FLOAT,
    substrate FLOAT,
    ethanol FLOAT,
    FOREIGN KEY (individual_id)
    REFERENCES individuals(id)
    ON DELETE CASCADE
);

CREATE TABLE experimental_results (
    id CHAR(36) PRIMARY KEY,
    experiment_id CHAR(36) NOT NULL,
    time FLOAT,
    ethanol FLOAT,
    biomass FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (experiment_id)
    REFERENCES experiments(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_generations_experiment
ON generations(experiment_id);

CREATE INDEX idx_individuals_generation
ON individuals(generation_id);

CREATE INDEX idx_simulation_individual
ON simulation_results(individual_id);

CREATE INDEX idx_experimental_experiment
ON experimental_results(experiment_id);