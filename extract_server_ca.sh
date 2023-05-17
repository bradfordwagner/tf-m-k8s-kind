kind get kubeconfig --internal --name ${cluster_name} > ~/.kube/kind/internal/${cluster_name}
export KUBECONFIG=~/.kube/kind/internal/${cluster_name}
kubectl config view --raw --minify --flatten \
  --output 'jsonpath={.clusters[].cluster.certificate-authority-data}' | base64 --decode \
  > ${KUBECONFIG}_ca
kubectl config view --raw --minify --flatten \
  --output 'jsonpath={.clusters[].cluster.server}' \
  > ${KUBECONFIG}_server
