Step 1: Create a directory on your node
```
sudo mkdir -p /mnt/data
sudo chmod 777 /mnt/data
```
```
kubectl apply -f pv-pvc-setup.yaml
```
Verify the obejcts:
```
kubectl get pv,pvc,pod
```

Verify the data;
```
kubectl exec -it demo-pod -- cat /data/hello.txt
```

Login to container:
```
 kubectl exec --stdin --tty demo-pod -- /bin/sh
```
