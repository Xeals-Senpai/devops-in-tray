# platforms-lab

[![CI Pipeline](https://github.com/Xeals-Senpai/platforms-lab/actions/workflows/ci.yml/badge.svg)](https://github.com/Xeals-Senpai/platforms-lab/actions/workflows/ci.yml)

Personal Platform Engineering and DevOps learning environment.

## Overview

Platforms Lab is a local infrastructure playground used to learn, experiment with, and demonstrate modern DevOps and Platform Engineering concepts using Infrastructure as Code, monitoring, observability, and automation tools.

The project is intentionally built using local Docker infrastructure to provide a safe and cost-effective environment for testing and troubleshooting without requiring cloud resources.

Current technologies include:

- Terraform
- Docker
- Prometheus
- Grafana
- Flask
- GitHub Actions
- Ansible (work in progress)

The repository serves as a long-term learning platform where new technologies and operational scenarios can be added and explored over time.

---

## Current Architecture

```text
platforms-lab-network
│
├── web-container
│   ├── Flask Application
│   └── Prometheus Metrics Endpoint
│
├── prometheus
│   └── Scrapes Application and Host Metrics
│
└── grafana
    └── Visualises Metrics and Dashboards

Host Machine
│
└── Windows Exporter
    └── Exposes System Metrics
```

---

## Components

### Terraform

Terraform manages all infrastructure resources, including:

- Docker network creation
- Flask application container deployment
- Prometheus container deployment
- Grafana container deployment

Terraform is used as the primary Infrastructure as Code tool for the project.

### Flask Application

The sample Flask application provides a basic web service and exposes Prometheus metrics.

Available routes:

| Route | Purpose |
|---------|---------|
| `/` | Basic application response |
| `/metrics` | Prometheus metrics endpoint |
| `/slow` | Simulates a slow response |
| `/random` | Simulates random failures |
| `/load` | Simulates high CPU load |
| `/crash` | Simulates an application crash |

These routes are used to create realistic troubleshooting and monitoring scenarios.

### Prometheus

Prometheus collects metrics from:

- Flask application
- Windows Exporter

Metrics can be inspected directly through the Prometheus UI.

### Grafana

Grafana provides visualisation and dashboarding for collected metrics.

Configuration is provisioned automatically through:

- Datasources as code
- Dashboards as code

No manual dashboard creation is required after deployment.

### Ansible

Ansible configuration is included as part of the project and will be expanded in future iterations to automate system configuration and deployment tasks.

---

## Repository Structure

```text
platforms-lab/
│
├── .github/
│   └── workflows/
│
├── ansible/
│   ├── inventory.ini
│   └── playbook.yml
│
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── grafana/
│   ├── dashboards/
│   └── provisioning/
│
├── prometheus/
│   └── prometheus.yml
│
├── scripts/
│
├── terraform/
│   ├── versions.tf
│   ├── providers.tf
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
│
└── README.md
```

---

## Monitoring Stack

### Prometheus Targets

Current scrape targets:

- Flask application (`web-container`)
- Windows Exporter (`host.docker.internal:9182`)

### Grafana Dashboards

Current dashboards:

- Windows Infrastructure Dashboard

Future dashboards:

- Application Metrics Dashboard
- Alerting Dashboard
- Container Monitoring Dashboard

---

## Deployment

### Terraform

Initialise Terraform:

```bash
cd terraform
terraform init
```

Validate configuration:

```bash
terraform validate
```

Review changes:

```bash
terraform plan
```

Deploy infrastructure:

```bash
terraform apply
```

---

## Accessing Services

### Flask Application

```text
http://localhost:5050
```

### Prometheus

```text
http://localhost:9090
```

### Grafana

```text
http://localhost:3000
```

Default Grafana credentials:

```text
Username: admin
Password: admin
```

---

## Learning Objectives

This repository is used to explore:

- Infrastructure as Code
- Docker Networking
- Monitoring and Observability
- Grafana Provisioning
- Prometheus Configuration
- CI Validation
- Failure Simulation
- Troubleshooting and Root Cause Analysis
- Platform Engineering Concepts
- Configuration Management

---

## Current Status

Implemented:

- Terraform-managed infrastructure
- Docker networking
- Flask application deployment
- Prometheus monitoring
- Grafana provisioning
- Dashboard provisioning
- GitHub Actions validation

Planned:

- Application-specific metrics
- Custom Grafana dashboards
- Alerting rules
- Grafana persistence
- Expanded Ansible automation
- CI/CD enhancements
- Additional platform engineering scenarios

---

## Purpose

Platforms Lab is intended to be a practical, hands-on environment for learning and demonstrating DevOps, Infrastructure, Monitoring, and Platform Engineering skills through reproducible, code-driven infrastructure.
