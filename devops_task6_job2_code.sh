cd /root/task6/
if kubectl get pvc | grep httpd-data-pvc1
then
echo "httpd-data-pvc1 already exist"
else
kubectl apply -f pvc.yml
fi

if kubectl get svc | grep httpd-svc
then
echo "httpd-svc already exist"
else
kubectl apply -f svc.yml
fi

if  ls * | grep html
then
 if kubectl get pods | grep httpd-rs
 then
 echo "httpd-rs pod alredy exist"
 else
 kubectl apply  -f httpdimage.yml
 fi
 pod_name=$(kubectl get pods -o=jsonpath='{.items[0].metadata.name}')
 echo "$pod_name"
 kubectl cp *.html $pod_name:/usr/local/apache2/htdocs/
fi

