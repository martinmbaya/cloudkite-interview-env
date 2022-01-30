---
apiVersion: "apps/v1"
kind: "Deployment"
metadata:
  name: "cloudkite-gke-app"
  namespace: "cloudkite-gke-app-ns"
  labels:
    app: "cloudkite-gke-app"
spec:
  replicas: 3
  selector:
    matchLabels:
      app: "cloudkite-gke-app"
  template:
    metadata:
      labels:
        app: "cloudkite-gke-app"
    spec:
      containers:
        - name: "cloudkite-martin-image"
          image: "gcr.io/cloudkite-interviews-martin/cloudkite-martin-image:COMMIT_SHA"
          ports:
            - containerPort: 8080
---
apiVersion: "autoscaling/v2beta1"
kind: "HorizontalPodAutoscaler"
metadata:
  name: "cloudkite-gke-app-hpa-xv9j"
  namespace: "cloudkite-gke-app-ns"
  labels:
    app: "cloudkite-gke-app"
spec:
  scaleTargetRef:
    kind: "Deployment"
    name: "cloudkite-gke-app"
    apiVersion: "apps/v1"
  minReplicas: 1
  maxReplicas: 5
  metrics:
    - type: "Resource"
      resource:
        name: "cpu"
        targetAverageUtilization: 80
---
apiVersion: "v1"
kind: "Service"
metadata:
  name: "cloudkite-gke-app-service"
  namespace: "cloudkite-gke-app-ns"
  labels:
    app: "cloudkite-gke-app"
    app.kubernetes.io/managed-by: "gcp-cloud-build-deploy"
spec:
  ports:
    - protocol: "TCP"
      port: 8080
      targetPort: 8080
  selector:
    app: "cloudkite-gke-app"
  type: "LoadBalancer"
  loadBalancerIP: ""