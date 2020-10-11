docker build -t vincezzh/multi-client:latest -t vincezzh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vincezzh/multi-server:latest -t vincezzh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vincezzh/multi-worker:latest -t vincezzh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vincezzh/multi-client:latest
docker push vincezzh/multi-server:latest
docker push vincezzh/multi-worker:latest

docker push vincezzh/multi-client:$SHA
docker push vincezzh/multi-server:$SHA
docker push vincezzh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vincezzh/multi-server:$SHA
kubectl set image deployments/client-deployment client=vincezzh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vincezzh/multi-worker:$SHA