# DevOps In-Tray Exercise: Infrastructure, Monitoring & Issue Simulation

## Overview

This project is part of a DevOps in-tray exercise, designed to:

- **Provision infrastructure** using Terraform and configure it with Ansible
- **Deploy a Flask web application** in Docker
- **Monitor it with Prometheus**
- **Simulate issues** and troubleshoot them like a DevOps engineer

This README provides a beginner-friendly walkthrough and documents all challenges and resolutions throughout the tasks.

---

## Task 1: Infrastructure Review

### Objective

Review existing infrastructure and understand how services are provisioned and configured.

### Challenges Encountered

- **Cloud services can be expensive:** Had to provision infrastructure locally using Terraform's local backend to save cost
- **Docker setup on Windows:** Posed path-related and permission issues

### Actions Taken

- Chose to use Terraform with the Docker provider to create containers
- Installed Terraform and Docker CLI on Windows
- Used PowerShell to manage local infrastructure
- Created a custom Docker bridge network (`web`) to allow inter-container communication

---

## Task 2: Infrastructure Setup (Terraform + Ansible)

### Infrastructure Tools Used

- **Terraform:** Provision Docker containers
- **Ansible:** Run configuration tasks inside containers

### Challenges Encountered

- **Terraform error:** `unsupported attribute` regarding `docker_container web` and `latest`
    - **Cause:** Incorrect syntax accessing container image tags
    - **Fix:** Used explicit image names in Terraform
- **Ansible errors:** `permission denied`, `externally-managed-environment`, and container paused
    - **Cause:** Running Ansible against a non-running or misconfigured container
    - **Fix:** Ensured Docker was running, permissions were granted, and container was alive before playbook execution
- **pip install errors inside PowerShell**
    - **Cause:** Python not properly installed or virtual environment not activated
    - **Fix:** Installed Python manually, then created and activated a virtualenv

### Actions Taken

Wrote Ansible playbook to:

- Run `apt-get update`
- Install dependencies like `curl`
- Used `community.docker.docker_container` Ansible module
- Ensured Python, pip, Docker, and Terraform were working together on Windows

---

## Task 3: Service Deployment (Flask + Prometheus)

### Architecture

- **Flask App container:** `web-container`
- **Prometheus container:** `prometheus`
- **Docker network:** `web`

### Challenges Encountered

- **Prometheus connection refused to `host.docker.internal:5050`**
    - **Cause:** Docker network isolation
    - **Fix:** Ran both containers on the same Docker network (`web`) and changed Prometheus target to `web-container:5050`
- **Prometheus 404 or empty targets**
    - **Cause:** Port mismatch or wrong target
    - **Fix:** Aligned Flask app to use port 5050, and confirmed `/metrics` endpoint works

### Actions Taken

- Created `prometheus.yml` configuration
- Mounted it as a volume in the Prometheus container
- Verified target via Prometheus UI → **Status → Targets**

---

## Task 4: Issue Simulation and Troubleshooting

To simulate real-world issues, dedicated routes were added to the Flask app. These routes simulate specific problems only when they are accessed, keeping the application stable under normal use.

### 1. Simulated Slow Response

- **Route:** `/slow`
- **Behavior:** Adds `time.sleep(10)` to delay the response
- **Troubleshoot:** Notice the delay in browser or through Prometheus metrics

### 2. Simulated Random Failures

- **Route:** `/random`
- **Behavior:** Has a 50% chance of raising an exception to simulate failure
- **Troubleshoot:** Watch for errors in `docker logs web-container` or failure metrics in Prometheus

### 3. Simulated High CPU Load

- **Route:** `/load`
- **Behavior:** Performs a computationally heavy loop using `sum(range(10**7))`
- **Troubleshoot:** Monitor CPU usage via `docker stats` or increased request latency

### 4. Simulated Container Crash

- **Route:** `/crash`
- **Behavior:** Uses `os._exit(1)` to immediately kill the container
- **Troubleshoot:** Container disappears from `docker ps`, Prometheus marks it as DOWN

---

## Testing

Use browser or `curl`:

```sh
curl http://localhost:5050/slow
curl http://localhost:5050/random
curl http://localhost:5050/load
curl http://localhost:5050/crash
```

---

## How to Run Everything

### Build Flask App

```sh
cd app
docker build -t flask-app .
```

### Create Docker Network

```sh
docker network create web
```

### Run Flask App

```sh
docker run -d --name web-container --network web -p 5050:5050 flask-app
```

### Run Prometheus

```sh
docker run -d --name prometheus --network web -p 9090:9090 \
    -v "C:/path/to/prometheus.yml:/etc/prometheus/prometheus.yml" \
    prom/prometheus
```

### Visit

- **Flask App:** [http://localhost:5050](http://localhost:5050)
- **Prometheus:** [http://localhost:9090](http://localhost:9090)

---

## Cleanup

```sh
docker stop web-container prometheus
docker rm web-container prometheus
```

---

## Conclusion

This exercise covered infrastructure-as-code, service monitoring, and real-world issue simulation — all on a local environment using beginner-friendly tools.

With this setup, the following DevOps principles were demonstrated:

- **Toolchain knowledge:** Terraform, Ansible, Docker
- **Troubleshooting and root cause analysis**
- **System monitoring with Prometheus**
- **Clean, reproducible project documentation**
