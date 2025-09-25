````
vim pod.yaml
````

````
apiVersion: v1 
kind: Pod 
metadata: 
  name: pod-yoga 
  labels:
    app: yoga
spec: 
  containers:
   - name: c1 
     image: abhipraydh96/yoga 
     ports:
      - containerPort: 80

---
apiVersion: v1 
kind: Service 
metadata: 
  name: svc-yoga 
spec:
  selector: 
    app: yoga 
  ports:
   - port: 80
     protocol: "TCP"
     targetPort: 80
  type: ClusterIP
````

````
kubectl apply -f pod.yaml
````
````
kubectl get pods
kubectl get svc
````
````
kubectl exec -it pod-yoga -- curl <clusterip>
````
